part of 'pages.dart';

class CartDetailOrderPage extends StatefulWidget {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  CartDetailOrderPage(
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  _CartDetailOrderPageState createState() => _CartDetailOrderPageState();
}

class _CartDetailOrderPageState extends State<CartDetailOrderPage> {
  void _backButtOnPressed(String id) async {
    // auth.User firebaseUser = Provider.of<auth.User>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Ingin membatalkan pesanan?',
        isRightCTA: true,
        onTapTopButton: () async {
          Navigator.pop(context);

          context.read<PageBloc>().add(GoToHomePage(0));

          context.read<ListOrderCartColdBloc>().add(
                DeleteListOrderCartColdDrink(id),
              );

          context.read<MenuBloc>().add(MenuToInitial());

          context.read<AllMenuBloc>().add(AllMenuToInitial());
        },
        onTapBottomButton: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  String? selectedVariant;
  String? selectedProductStyle;

  @override
  void initState() {
    selectedVariant = widget.selectedVariant;
    selectedProductStyle = widget.selectedProductStyle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => WillPopScope(
        onWillPop: () async {
          _backButtOnPressed(
            (userState is UserLoaded) ? userState.user.uid : '',
          );

          return false;
        },
        child: Scaffold(
          backgroundColor: ThemeColor.whiteBackColor,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: ThemeColor.whiteBackColor,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    pinned: true,
                    title: _buildAppbar(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _buildContentList(),
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => _buildBottomCheckoutButton(
                  (userState is UserLoaded) ? userState.user.uid : '',
                  (userState is UserLoaded) ? userState.user.name : '',
                  (userState is UserLoaded) ? userState.user.phoneNumber : '',
                  (userState is UserLoaded) ? userState.user.tokenId : '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar(String id) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          BackButtonWidget(
            name: 'Detail Order',
            onTapFunc: () => _backButtOnPressed(id),
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          SizedBox(height: height * verticalMargin),
          BlocBuilder<ListOrderCartColdBloc, ListOrderCartColdState>(
            builder: (_, listOrderCartCold) {
              if (listOrderCartCold is LoadListOrderCartColdDrink) {
                return Column(
                  children: [
                    Column(
                      children: listOrderCartCold.orderCupDetail
                          .map(
                            (e) => CardDetailOrderColdDrink(
                              amount: e.amount,
                              drinkSize: e.cupType,
                              drinkType: e.type,
                              iceLevel: e.iceLevel,
                              productName: e.productName,
                              sizeCupPrice: e.typePrice,
                              sugarLevel: e.sugarLevel,
                              toppingName: e.topping,
                              toppingPrice: e.toppingPrice,
                              totalPrice: e.totalPrice,
                              imgUrl: e.imgUrl,
                            ),
                          )
                          .toList(),
                    ),
                    _buildListOrderHot(),
                    _buildListOrderBottle(),
                    _buildOrderType(),
                    SizedBox(height: height * verticalMargin),
                    BlocBuilder<OrderTypeBloc, OrderTypeState>(
                      builder: (_, orderState) => ButtonAddMoreDrink(
                        onTap: () async {
                          if (orderState is DeliveryType) {
                            _onPressedButtonAddMoreDrinkOnDelivery();
                          } else if (orderState is PreOrderType) {
                            _onPressedButtonAddMoreDrinkOnPreOrder();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height * verticalMargin),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => (userState is UserLoaded)
                          ? _buildButtonCencelOrder(userState.user.uid)
                          : SizedBox(),
                    ),
                  ],
                );
              } else {
                return Container(
                  height: height * .5,
                  child: SpinKitRing(
                    color: ThemeColor.accentColor2,
                    size: 34,
                  ),
                );
              }
            },
          ),
          SizedBox(height: height * (verticalMargin + textFieldHeight)),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _buildOrderType() {
    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (context, orderState) {
        if (orderState is PreOrderType) {
          return CardOrderType(
            isOrderIDVisible: false,
            orderID: widget.preOrderData!.orderID,
            orderType: widget.preOrderData!.orderType,
            outlet: widget.preOrderData!.outlet,
            pickupTime: widget.preOrderData!.pickupTime,
          );
        } else if (orderState is DeliveryType) {
          return BlocBuilder<TotalPriceBloc, TotalPriceState>(
            builder: (_, total) => CardDeliveryOrderType(
              orderID: widget.deliveryOrderData!.orderID,
              address: widget.deliveryOrderData!.address,
              deliveryFee: (total is LoadTotalPriceDelivery)
                  ? '${total.deliveryFee}'
                  : '',
              distance: widget.deliveryOrderData!.distance,
              orderType: widget.deliveryOrderData!.orderType,
              outlet: widget.deliveryOrderData!.outlet,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  void _onPressedButtonAddMoreDrinkOnDelivery() async {
    print('pressed');
    context.read<PageBloc>().add(
          GoToSelectMenuPage(
            selectedProductStyle,
            selectedVariant,
            deliveryOrderData: DeliveryOrderData(
              address: widget.deliveryOrderData!.address,
              deliveryFee: widget.deliveryOrderData!.deliveryFee,
              distance: widget.deliveryOrderData!.distance,
              outlet: widget.deliveryOrderData!.outlet,
              selectedLocationLat:
                  widget.deliveryOrderData!.selectedLocationLat,
              selectedLocationLng:
                  widget.deliveryOrderData!.selectedLocationLng,
              orderType: widget.deliveryOrderData!.orderType,
            ),
          ),
        );
  }

  void _onPressedButtonAddMoreDrinkOnPreOrder() async {
    print('pressed');
    context.read<PageBloc>().add(
          GoToSelectMenuPage(
            selectedProductStyle,
            selectedVariant,
            preOrderData: PreOrderData(
              orderType: widget.preOrderData!.orderType,
              outlet: widget.preOrderData!.outlet,
              pickupTime: widget.preOrderData!.pickupTime,
            ),
          ),
        );
  }

  Widget _buildButtonCencelOrder(String id) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (_) => AlertBoxWidget(
            boxTitle: 'Ingin membatalkan pesanan?',
            isRightCTA: true,
            onTapTopButton: () async {
              Navigator.pop(context);

              context.read<PageBloc>().add(GoToHomePage(0));

              context.read<AllMenuBloc>().add(AllMenuToInitial());

              context.read<ListOrderCartColdBloc>().add(
                    DeleteListOrderCartColdDrink(id),
                  );
            },
            onTapBottomButton: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Text(
        'Batalkan Pesanan',
        style: accentFontBlackBold.copyWith(
          color: ThemeColor.errorColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildListOrderHot() {
    return BlocBuilder<ListOrderCartHotBloc, ListOrderCartHotState>(
      builder: (_, hotState) {
        if (hotState is LoadListOrderCartHot) {
          return Column(
            children: hotState.orderHotDetail
                .map(
                  (e) => CardDetailOrderHotDrink(
                    amount: e.amount,
                    drinkType: e.type,
                    productName: e.productName,
                    sugar: e.sugar,
                    totalPrice: e.totalPrice,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildListOrderBottle() {
    return BlocBuilder<ListOrderCartBottleBloc, ListOrderCartBottleState>(
      builder: (_, bottleState) {
        if (bottleState is LoadListOrderCartBottleDrink) {
          return Column(
            children: bottleState.orderBottleDetail
                .map(
                  (e) => CardDetailOrderBottleDrink(
                    amount: e.amount,
                    drinkSize: e.size,
                    drinkType: e.type,
                    productName: e.productName,
                    sizeCupPrice: e.sizePrice,
                    totalPrice: e.totalPrice,
                    sugarLevel: e.sugar,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildBottomCheckoutButton(
    String id,
    String? userName,
    String? phoneNumber,
    String? tokenId,
  ) {
    return BlocBuilder<CheckoutSelectedOutletLatlngBloc,
        CheckoutSelectedOutletLatlngState>(
      builder: (_, locState) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
        builder: (_, orderState) =>
            BlocBuilder<TotalPriceBloc, TotalPriceState>(
          builder: (_, totalPriceState) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => CheckoutButton(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (_) => AlertBoxWidget(
                      boxTitle: 'Proses Pesanan?',
                      isDesc: true,
                      desc:
                          'Setelah diproses, kamu tidak bisa membatalkan pesanan',
                      isRightCTA: true,
                      onTapBottomButton: () {
                        Navigator.pop(context);
                      },
                      onTapTopButton: () async {
                        Navigator.pop(context);

                        if (orderState is DeliveryType) {
                          var deliveryData = DeliveryOrderData(
                            address: widget.deliveryOrderData!.address,
                            deliveryFee:
                                (totalPriceState is LoadTotalPriceDelivery)
                                    ? '${totalPriceState.deliveryFee}'
                                    : '',
                            distance: widget.deliveryOrderData!.distance,
                            orderType: widget.deliveryOrderData!.orderType,
                            outlet: widget.deliveryOrderData!.outlet,
                            selectedLocationLat:
                                widget.deliveryOrderData!.selectedLocationLat,
                            selectedLocationLng:
                                widget.deliveryOrderData!.selectedLocationLng,
                          );

                          await CheckoutOrderService
                              .selectedDrinkListToCheckoutListOrder(
                            id,
                            (totalPriceState is LoadTotalPriceDelivery)
                                ? totalPriceState.totalPriceDelivery
                                : 0,
                            'Dalam Proses',
                            DateTime.now().dateTime,
                            userName,
                            true,
                            deliveryOrderData: deliveryData,
                            phoneNumber: phoneNumber,
                            tokenId: tokenId,
                          );

                          context.read<NotificationBloc>().add(
                                SendNotificationToOutlet(
                                  contents:
                                      'Ada pesanan delivery baru, nih. Dari $userName. Langsung eksekusi ya!',
                                  headings: 'You Got New Delivery Order!',
                                  outlet: widget.deliveryOrderData!.outlet,
                                ),
                              );
                        } else if (orderState is PreOrderType) {
                          await CheckoutOrderService
                              .selectedDrinkListToCheckoutListOrder(
                            id,
                            (totalPriceState is LoadTotalPrice)
                                ? totalPriceState.totalPrice
                                : 0,
                            'Dalam Proses',
                            DateTime.now().dateTime,
                            userName,
                            false,
                            preOrderData: widget.preOrderData,
                            phoneNumber: phoneNumber,
                            tokenId: tokenId,
                          );

                          context.read<NotificationBloc>().add(
                                SendNotificationToOutlet(
                                  contents:
                                      'Ada pesanan Pre-Order baru, nih. Dari $userName. Langsung eksekusi ya!',
                                  headings: 'You Got New Pre-Order!',
                                  outlet: widget.preOrderData!.outlet,
                                ),
                              );
                        }

                        context.read<ListOrderCartColdBloc>().add(
                              DeleteListOrderCartColdDrink(id),
                            );

                        context.read<ListOrderCartBottleBloc>().add(
                              ListOrderCartBottleDrinkToInitial(),
                            );

                        context.read<ListOrderCartColdBloc>().add(
                              ListOrderCartColdDrinkToInitial(),
                            );

                        context.read<ListOrderCartHotBloc>().add(
                              ListOrderCartHotToInitial(),
                            );

                        // context.read<PageBloc>().add(GoToSuccessCheckoutPage());

                        context.read<ListOrderCheckoutCupBloc>().add(
                              GetListCheckoutOrderCup(
                                (userState is UserLoaded)
                                    ? userState.user.uid
                                    : '',
                              ),
                            );

                        context.read<ListOrderCheckoutBottleBloc>().add(
                              GetListCheckoutOrderBottle(
                                (userState is UserLoaded)
                                    ? userState.user.uid
                                    : '',
                              ),
                            );

                        context.read<ListOrderCheckoutHotBloc>().add(
                              GetListCheckoutOrderHot(
                                (userState is UserLoaded)
                                    ? userState.user.uid
                                    : '',
                              ),
                            );

                        if (orderState is DeliveryType) {
                          context.read<CheckoutDeliveryDataBloc>().add(
                                GetCheckoutDeliveryOrderData(
                                  (userState is UserLoaded)
                                      ? userState.user.uid
                                      : '',
                                ),
                              );

                          context.read<PageBloc>().add(
                                GoToCartCheckoutDeliveryPage(
                                  (locState is LoadSelectedOutletLatLng)
                                      ? locState.outletLatLng
                                      : LatLng(0, 0),
                                  (locState is LoadSelectedOutletLatLng)
                                      ? locState.userLoc
                                      : LatLng(0, 0),
                                  GoToHomePage(0,
                                      selectedOrder: 'Sedang Diproses'),
                                ),
                              );
                        } else {
                          context.read<CheckoutPreorderDataBloc>().add(
                                GetCheckoutPreOrderData(
                                  (userState is UserLoaded)
                                      ? userState.user.uid
                                      : '',
                                ),
                              );

                          context.read<PageBloc>().add(
                                GoToCartCheckoutPage(GoToHomePage(0)),
                              );
                        }

                        context.read<ChangeStatusOrderBloc>().add(
                              SetNewStatusToInitial(),
                            );

                        context.read<ChangeStatusOrderBloc>().add(
                              SetNewStatusToProcess(),
                            );

                        // context.read<CheckoutSelectedOutletLatlngBloc>().add(
                        //       GetSelectedOutletLatLng(
                        //         (userState is UserLoaded)
                        //             ? userState.user.uid
                        //             : '',
                        //       ),
                        //     );

                        // context.read<PageBloc>().add(GoToHomePage(0));

                        context.read<MenuBloc>().add(MenuToInitial());

                        context.read<AllMenuBloc>().add(AllMenuToInitial());
                      },
                    ),
                  );
                },
                total: (totalPriceState is LoadTotalPrice)
                    ? totalPriceState.totalPrice
                    : (totalPriceState is LoadTotalPriceDelivery)
                        ? totalPriceState.totalPriceDelivery
                        : 0,
              ),
            );
          },
        ),
      ),
    );
  }
}
