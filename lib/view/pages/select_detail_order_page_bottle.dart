part of 'pages.dart';

class SelectDetailOrderBottlePage extends StatefulWidget {
  final ChoosenBottleMenu choosenBottleMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  SelectDetailOrderBottlePage(
    this.choosenBottleMenu,
    this.price,
    this.drinkType,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  _SelectDetailOrderBottlePageState createState() =>
      _SelectDetailOrderBottlePageState();
}

class _SelectDetailOrderBottlePageState
    extends State<SelectDetailOrderBottlePage> {
  int amount = 1;
  List<String> listOfPriceBottle = [];
  String selectedPrice = '';
  String? selectedSugarType = '';
  int totalPrice = 0;

  String? selectedVariant;
  String? selectedProductStyle;

  @override
  void initState() {
    selectedVariant = widget.selectedVariant;
    selectedProductStyle = widget.selectedProductStyle;
    listOfPriceBottle = widget.price;
    super.initState();
  }

  void _backPrevPage(OrderTypeState orderState) {
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
                  SizedBox(height: height * verticalMargin),
                  _buildProductName(),
                  SizedBox(height: height * verticalMargin),
                  _buildButtonAddAmount(),
                  SizedBox(height: height * (verticalMargin / 2)),
                  _buildButtonSizeBottle(),
                  SizedBox(height: height * (verticalMargin / 2)),
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

    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (_, orderState) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ThemeColor.accentColor3,
              ThemeColor.accentColor2,
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              SafeArea(
                child: BackButtonWidget(
                  name: 'Pilih Detail Minuman',
                  onTapFunc: () => _backPrevPage(orderState),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * verticalMargin),
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Image.asset('assets/barbar.png'),
              ),
              SizedBox(height: height * verticalMargin),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: AutoSizeText(
        widget.choosenBottleMenu.name!,
        style: mainFontBlackBold.copyWith(
          color: ThemeColor.mainColor,
          fontSize: 24,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildButtonAddAmount() {
    return ButtonAddAmount(
      amount: amount,
      addAmount: () {
        if (amount < 5) {
          setState(() {
            amount++;
          });

          if (selectedPrice.split(' ')[0] == '500ml') {
            setState(() {
              totalPrice = amount * widget.choosenBottleMenu.price500ml!;
            });
          } else if (selectedPrice.split(' ')[0] == '1000ml') {
            setState(() {
              totalPrice = amount * widget.choosenBottleMenu.price1000ml!;
            });
          }
        } else {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: ThemeColor.mainColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Kamu hanya bisa memesan 5 botol Yotta',
          )..show(context);
        }
      },
      removeAmount: () {
        if (amount > 0 && amount < 6) {
          setState(() {
            amount--;
          });
        }

        if (selectedPrice.split(' ')[0] == '500ml') {
          setState(() {
            totalPrice = amount * widget.choosenBottleMenu.price500ml!;
          });
        } else if (selectedPrice.split(' ')[0] == '1000ml') {
          setState(() {
            totalPrice = amount * widget.choosenBottleMenu.price1000ml!;
          });
        }
      },
    );
  }

  Widget _buildButtonSizeBottle() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: AutoSizeText(
            'Ukuran',
            style: accentFontBlackBold.copyWith(
              fontSize: 12,
              color: ThemeColor.accentColor4,
            ),
          ),
        ),
        SizedBox(height: height * verticalMarginHalf),
        Container(
          height: height * 0.07,
          child: ListView.builder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: listOfPriceBottle.length,
            itemBuilder: (_, index) {
              var price = listOfPriceBottle[index];

              return ButtonBottleSize(
                size: price,
                margin: (index == listOfPriceBottle.length - 1)
                    ? EdgeInsets.only(right: defaultMargin)
                    : (index == 0)
                        ? EdgeInsets.only(
                            left: defaultMargin,
                            right: defaultMargin / 2,
                          )
                        : EdgeInsets.only(right: defaultMargin / 2),
                isBorder: price == selectedPrice,
                onTap: () {
                  setState(() {
                    selectedPrice = price;
                  });

                  if (selectedPrice.split(' ')[0] == '500ml') {
                    setState(() {
                      totalPrice =
                          amount * widget.choosenBottleMenu.price500ml!;
                    });
                  } else if (selectedPrice.split(' ')[0] == '1000ml') {
                    setState(() {
                      totalPrice =
                          amount * widget.choosenBottleMenu.price1000ml!;
                    });
                  }
                },
              );
            },
          ),
        ),
      ],
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
    if (amount == 0 || selectedPrice == '' || selectedSugarType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColor.mainColor,
        animationDuration: Duration(milliseconds: flushAnimationDuration),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      var selectedPriceToInt = int.parse(selectedPrice.split(' ')[1]);

      OrderBottleDetail _orderBottleDetail = OrderBottleDetail(
        amount: amount,
        productName: widget.choosenBottleMenu.name,
        size: selectedPrice.split(' ')[0],
        sugar: selectedSugarType,
        totalPrice: totalPrice,
        type: widget.drinkType,
        sizePrice: selectedPriceToInt,
      );

      await SelectedOrderServices.setSelectedOrderBottle(
        _orderBottleDetail,
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
    if (amount == 0 || selectedPrice == '' || selectedSugarType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ThemeColor.mainColor,
        animationDuration: Duration(milliseconds: flushAnimationDuration),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      var selectedPriceToInt = int.parse(selectedPrice.split(' ')[1]);

      OrderBottleDetail _orderBottleDetail = OrderBottleDetail(
        amount: amount,
        productName: widget.choosenBottleMenu.name,
        size: selectedPrice.split(' ')[0],
        sugar: selectedSugarType,
        totalPrice: totalPrice,
        type: widget.drinkType,
        sizePrice: selectedPriceToInt,
      );

      await SelectedOrderServices.setSelectedOrderBottle(
        _orderBottleDetail,
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
            deliveryOrderData: widget.deliveryOrderData,
          ));
    }
  }
}
