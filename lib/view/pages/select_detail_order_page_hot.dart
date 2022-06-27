part of 'pages.dart';

class SelectDetailOrderHotPage extends StatefulWidget {
  final ChoosenHotMenu choosenHotMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  SelectDetailOrderHotPage(
    this.choosenHotMenu,
    this.drinkType,
    this.price,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  _SelectDetailOrderHotPageState createState() =>
      _SelectDetailOrderHotPageState();
}

class _SelectDetailOrderHotPageState extends State<SelectDetailOrderHotPage> {
  int amount = 1;
  // List<String> listOfPriceHot = [];
  int totalPrice = 0;
  String? selectedSugarType = '';

  String? selectedVariant;
  String? selectedProductStyle;

  @override
  void initState() {
    selectedVariant = widget.selectedVariant;
    selectedProductStyle = widget.selectedProductStyle;
    totalPrice = widget.choosenHotMenu.priceR! * amount;
    super.initState();
  }

  void _backPrevPage(OrderTypeState orderState) async {
    if (orderState is PreOrderType) {
      context.read<PageBloc>().add(
            GoToSelectMenuPage(
              selectedProductStyle,
              selectedVariant,
              preOrderData: PreOrderData(
                orderType: widget.preOrderData!.orderType ?? '',
                outlet: widget.preOrderData!.outlet ?? '',
                pickupTime: widget.preOrderData!.pickupTime ?? '',
              ),
            ),
          );
    } else if (orderState is DeliveryType) {
      context.read<PageBloc>().add(
            GoToSelectMenuPage(
              selectedProductStyle,
              selectedVariant,
              deliveryOrderData: DeliveryOrderData(
                address: widget.deliveryOrderData!.address ?? '',
                deliveryFee: widget.deliveryOrderData!.deliveryFee ?? '',
                distance: widget.deliveryOrderData!.distance ?? '',
                outlet: widget.deliveryOrderData!.outlet ?? '',
                selectedLocationLat:
                    widget.deliveryOrderData!.selectedLocationLat ?? 0,
                selectedLocationLng:
                    widget.deliveryOrderData!.selectedLocationLng ?? 0,
                orderType: widget.deliveryOrderData!.orderType ?? '',
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (_, orderState) => WillPopScope(
        onWillPop: () async {
          _backPrevPage(orderState);

          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: height * (verticalMargin * 2)),
                  _buildProductName(),
                  SizedBox(height: height * verticalMargin),
                  _buildAddAmount(),
                  SizedBox(height: height * verticalMargin),
                  _buildButtonSugarTypeWidget(),
                ],
              ),
              _buildAddToCartWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (_, orderState) => Container(
        width: double.infinity,
        height: height * 0.52,
        // color: Colors.green,
        child: Stack(
          children: [
            Container(
              height: height * 0.52,
              child: Image.asset(
                'assets/select_hot_detail_order_header.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: SafeArea(
                    child: Column(
                      children: [
                        BackButtonWidget(
                          name: 'Pilih Detail Minuman',
                          onTapFunc: () => _backPrevPage(orderState),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height * .35,
                  width: width,
                  // color: Colors.red,
                  child: Center(
                    child: Image.asset('assets/kopi.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin * 2),
      child: AutoSizeText(
        widget.choosenHotMenu.name!,
        style: mainFontBlackBold.copyWith(
          color: ThemeColor.mainColor,
          fontSize: 24,
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _buildAddAmount() {
    return ButtonAddAmount(
      amount: amount,
      addAmount: () {
        if (amount < 5) {
          setState(() {
            amount++;
            totalPrice = amount * widget.choosenHotMenu.priceR!;
          });
        } else {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: ThemeColor.mainColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Kamu hanya bisa memesan 5 hot Yotta',
          )..show(context);
        }
      },
      removeAmount: () {
        if (amount > 0 && amount < 6) {
          setState(() {
            amount--;
            totalPrice = amount * widget.choosenHotMenu.priceR!;
          });
        }
      },
    );
  }

  Widget _buildButtonSugarTypeWidget() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: AutoSizeText(
            'Sugar',
            style: accentFontBlackBold.copyWith(
              fontSize: 12,
              color: ThemeColor.accentColor4,
            ),
          ),
        ),
        SizedBox(height: height * verticalMarginHalf),
        BlocBuilder<SugarTypeBloc, SugarTypeState>(
          builder: (context, sugarState) {
            if (sugarState is LoadSugarTypeData) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: ListView.builder(
                  itemCount: sugarState.sugarType.toList().length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    var sugar = sugarState.sugarType[index];
                    var sugarLength = sugarState.sugarType.length;

                    return ButtonSelectSugar(
                      onTap: () {
                        setState(() {
                          selectedSugarType = sugar.name;
                        });
                      },
                      name: sugar.name,
                      isBorder: selectedSugarType == sugar.name,
                      margin: (index == sugarLength - 1)
                          ? EdgeInsets.only(right: defaultMargin)
                          : (index == 0)
                              ? EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin / 2,
                                )
                              : EdgeInsets.only(right: defaultMargin / 2),
                    );
                  },
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget _buildAddToCartWidget() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: BlocBuilder<OrderTypeBloc, OrderTypeState>(
            builder: (_, orderState) => BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => (userState is UserLoaded)
                  ? ButtonAddToCart(
                      total: totalPrice,
                      onTap: () async {
                        if (orderState is DeliveryType) {
                          _onPressedAddToCartDelivery(
                            userState.user.uid,
                            widget.deliveryOrderData!.distance,
                            widget.deliveryOrderData!.deliveryFee,
                          );
                        } else if (orderState is PreOrderType) {
                          _onPressedAddToCartPreOrder(userState.user.uid);
                        }
                      },
                    )
                  : SizedBox(),
            ),
          ),
        ),
        SizedBox(
          height: height * verticalMargin,
        ),
      ],
    );
  }

  void _onPressedAddToCartPreOrder(String id) async {
    if (amount == 0 || selectedSugarType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColor.mainColor,
        animationDuration: Duration(milliseconds: flushAnimationDuration),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      OrderHotDetail _orderHotDetail = OrderHotDetail(
        amount: amount,
        productName: widget.choosenHotMenu.name,
        sugar: selectedSugarType,
        totalPrice: totalPrice,
        type: widget.drinkType,
      );

      await SelectedOrderServices.setSelectedOrderHot(
        _orderHotDetail,
        id,
      );

      context.read<ListOrderCartColdBloc>().add(
            ListOrderCartColdDrinkToInitial(),
          );

      context.read<ListOrderCartColdBloc>().add(GetListOrderCartColdDrink(id));

      context.read<ListOrderCartBottleBloc>().add(
            GetListOrderCartBottleDrink(id),
          );

      context.read<ListOrderCartHotBloc>().add(GetListOrderCartHot(id));

      context.read<TotalPriceBloc>().add(GetTotalPrice(id));

      context.read<PageBloc>().add(GoToCartDetailPage(
            selectedVariant,
            selectedProductStyle,
            preOrderData: widget.preOrderData,
            deliveryOrderData: widget.deliveryOrderData,
          ));
    }
  }

  void _onPressedAddToCartDelivery(
    String id,
    String? distance,
    String? deliveryFee,
  ) async {
    if (amount == 0 || selectedSugarType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColor.mainColor,
        animationDuration: Duration(milliseconds: flushAnimationDuration),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      OrderHotDetail _orderHotDetail = OrderHotDetail(
        amount: amount,
        productName: widget.choosenHotMenu.name,
        sugar: selectedSugarType,
        totalPrice: totalPrice,
        type: widget.drinkType,
      );

      await SelectedOrderServices.setSelectedOrderHot(
        _orderHotDetail,
        id,
      );

      context.read<ListOrderCartColdBloc>().add(
            ListOrderCartColdDrinkToInitial(),
          );

      context.read<ListOrderCartColdBloc>().add(GetListOrderCartColdDrink(id));

      context.read<ListOrderCartBottleBloc>().add(
            GetListOrderCartBottleDrink(id),
          );

      context.read<ListOrderCartHotBloc>().add(GetListOrderCartHot(id));

      var _distanceStrToDouble = double.parse(
        distance!.split(' ')[0],
      );

      var _deliveryFeeStrToInt = int.parse(deliveryFee!);

      context.read<TotalPriceBloc>().add(
            GetTotalPriceDelivery(
              id,
              _distanceStrToDouble,
              _deliveryFeeStrToInt,
            ),
          );

      context.read<PageBloc>().add(GoToCartDetailPage(
            selectedVariant,
            selectedProductStyle,
            preOrderData: widget.preOrderData,
            deliveryOrderData: widget.deliveryOrderData,
          ));
    }
  }
}
