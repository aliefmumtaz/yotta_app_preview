part of 'pages.dart';

class SelectDetailOrderCupPage extends StatefulWidget {
  final ChoosenColdMenu choosenCupMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;
  final String? imgUrl;

  SelectDetailOrderCupPage(
    this.choosenCupMenu,
    this.price,
    this.drinkType,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
    this.imgUrl,
  });

  @override
  _SelectDetailOrderCupPageState createState() =>
      _SelectDetailOrderCupPageState();
}

class _SelectDetailOrderCupPageState extends State<SelectDetailOrderCupPage> {
  int amount = 1;
  List<String> listOfPrice = [];
  String selectedPrice = '';
  String? selectedTopping = '';
  String? selectedSugarType = '';
  String? selectedIceType = '';
  int selectedTypeCupPrice = 0;
  int totalPrice = 0;
  int selectedToppingPrice = 0;
  String selectedSizeCupType = '';

  String? selectedVariant;
  String? selectedProductStyle;

  @override
  void initState() {
    selectedVariant = widget.selectedVariant;
    selectedProductStyle = widget.selectedProductStyle;
    listOfPrice = widget.price;
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
          backgroundColor: ThemeColor.whiteBackColor,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: defaultMargin),
                      child: BackButtonWidget(
                        name: 'Pilih Detail Minuman',
                        onTapFunc: () async => _backPrevPage(orderState),
                      ),
                    ),
                    SizedBox(height: height * verticalMargin * 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPlaceHolderForCup(),
                        SizedBox(height: height * verticalMargin),
                        _buildButtonTitle('Ukuran'),
                        _buildButtonSizeWidget(),
                        SizedBox(height: height * verticalMarginHalf),
                        _buildButtonTitle('Topping'),
                        _buildButtonToppingWidget(),
                        SizedBox(height: height * verticalMarginHalf),
                        _buildButtonTitle('Sugar'),
                        _buildButtonSugarTypeWidget(),
                        SizedBox(height: height * verticalMarginHalf),
                        _buildButtonTitle('Ice'),
                        _buildIceTypeButtonWidget(),
                        SizedBox(height: height * verticalMargin * 4),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: BlocBuilder<OrderTypeBloc, OrderTypeState>(
                        builder: (_, orderState) =>
                            BlocBuilder<UserBloc, UserState>(
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
                                      _onPressedAddToCartPreOrder(
                                        userState.user.uid,
                                      );
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedAddToCartPreOrder(String id) async {
    if (amount == 0 ||
        selectedIceType == '' ||
        selectedSugarType == '' ||
        selectedTopping == '' ||
        selectedSizeCupType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: flushColor,
        animationDuration: Duration(milliseconds: 800),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      OrderCupDetail _orderCupDetail = OrderCupDetail(
        amount: amount,
        iceLevel: selectedIceType,
        productName: widget.choosenCupMenu.name,
        sugarLevel: selectedSugarType,
        topping: selectedTopping,
        type: widget.drinkType,
        imgUrl: widget.imgUrl,
        totalPrice: totalPrice,
        toppingPrice: selectedToppingPrice,
        typePrice: selectedTypeCupPrice,
        cupType: selectedSizeCupType,
      );

      await SelectedOrderServices.setSelectedOrderCup(
        _orderCupDetail,
        id,
      );

      context.read<ListOrderCartColdBloc>().add(
            ListOrderCartColdDrinkToInitial(),
          );

      context.read<ListOrderCartColdBloc>().add(GetListOrderCartColdDrink(id));

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
    if (amount == 0 ||
        selectedIceType == '' ||
        selectedSugarType == '' ||
        selectedTopping == '' ||
        selectedSizeCupType == '') {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: flushColor,
        animationDuration: Duration(milliseconds: 800),
        message: 'Silakan mengisi semua detail minuman',
      )..show(context);
    } else {
      OrderCupDetail _orderCupDetail = OrderCupDetail(
        amount: amount,
        iceLevel: selectedIceType,
        productName: widget.choosenCupMenu.name,
        sugarLevel: selectedSugarType,
        topping: selectedTopping,
        type: widget.drinkType,
        imgUrl: widget.imgUrl,
        totalPrice: totalPrice,
        toppingPrice: selectedToppingPrice,
        typePrice: selectedTypeCupPrice,
        cupType: selectedSizeCupType,
      );

      await SelectedOrderServices.setSelectedOrderCup(
        _orderCupDetail,
        id,
      );

      context.read<ListOrderCartColdBloc>().add(
            ListOrderCartColdDrinkToInitial(),
          );

      context.read<ListOrderCartColdBloc>().add(GetListOrderCartColdDrink(id));

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

  Widget _buildButtonTitle(String name) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: AutoSizeText(
            name,
            style: accentFontBlackBold.copyWith(
              fontSize: 12,
              color: ThemeColor.accentColor4,
            ),
          ),
        ),
        SizedBox(height: height * verticalMarginHalf / 2),
      ],
    );
  }

  Widget _buildPlaceHolderForCup() {
    return CupPlaceholder(
      imgUrl: widget.imgUrl,
      amount: amount,
      name: widget.choosenCupMenu.name,
      addAmount: () => _onPressedButtonAddDrink(),
      removeAmount: () => _onPressedButtonRemoveDrink(),
    );
  }

  void _onPressedButtonRemoveDrink() {
    if (amount > 1 && amount <= 5) {
      setState(() {
        amount--;
      });

      if (selectedPrice.split(' ')[0] == 'R') {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceR!) * amount;
        });
      } else if (selectedPrice.split(' ')[0] == 'L') {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceL!) * amount;
        });
      }
    }
  }

  void _onPressedButtonAddDrink() {
    if (amount < 5) {
      setState(() {
        amount++;
      });

      if (selectedPrice.split(' ')[0] == 'R') {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceR!) * amount;
        });
      } else if (selectedPrice.split(' ')[0] == 'L') {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceL!) * amount;
        });
      }
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: flushColor,
        animationDuration: Duration(milliseconds: 800),
        message: 'Pesanan sudah mencapai jumlah maksimum',
      )..show(context);
    }
  }

  Widget _buildIceTypeButtonWidget() {
    return BlocBuilder<IceTypeBloc, IceTypeState>(
      builder: (context, iceState) {
        if (iceState is LoadIceTypeData) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              itemCount: iceState.iceType.toList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                var ice = iceState.iceType[index];
                var iceLength = iceState.iceType.length;

                return ButtonSelectSugar(
                  onTap: () {
                    setState(() {
                      selectedIceType = ice.name;
                    });
                  },
                  name: ice.name,
                  isBorder: selectedIceType == ice.name,
                  margin: (index == iceLength - 1)
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
    );
  }

  Widget _buildButtonSugarTypeWidget() {
    return BlocBuilder<SugarTypeBloc, SugarTypeState>(
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
    );
  }

  int? selectedToppingPriceTemp;

  Widget _buildButtonToppingWidget() {
    return BlocBuilder<ToppingBloc, ToppingState>(
      builder: (context, toppingState) {
        if (toppingState is LoadToppingData) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              itemCount: toppingState.topping.toList().length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                var topping = toppingState.topping[index];
                var toppingLength = toppingState.topping.length;

                return ButtonSelectTopping(
                  img: topping.img,
                  margin: (index == toppingLength - 1)
                      ? EdgeInsets.only(right: defaultMargin)
                      : (index == 0)
                          ? EdgeInsets.only(
                              left: defaultMargin,
                              right: defaultMargin / 2,
                            )
                          : EdgeInsets.only(right: defaultMargin / 2),
                  name: topping.name,
                  price: topping.price,
                  isBorder: selectedTopping == topping.name,
                  onTap: () => _onPressedButtonTopping(
                    topping.name,
                    topping.price,
                    index,
                  ),
                );
              },
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildButtonSizeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listOfPrice
            .map(
              (e) => ButtonCupSize(
                isBorder: selectedPrice == e,
                size: e,
                onTap: () => _onPressedButtonSize(e),
              ),
            )
            .toList(),
      ),
    );
  }

  void _onPressedButtonTopping(
    String? toppingName,
    int? toppingPrice,
    int index,
  ) {
    if (index == 0) {
      if (selectedSizeCupType != '') {
        setState(() {
          selectedTopping = toppingName;

          if (selectedPrice.split(' ')[0] == 'R') {
            totalPrice = widget.choosenCupMenu.priceR! * amount;
          } else if (selectedPrice.split(' ')[0] == 'L') {
            totalPrice = widget.choosenCupMenu.priceL! * amount;
          }

          selectedToppingPrice = toppingPrice!;
        });
      }
    } else {
      if (selectedSizeCupType != '') {
        if (selectedToppingPrice == 0) {
          setState(() {
            selectedTopping = toppingName;
            selectedToppingPrice = toppingPrice!;

            if (selectedPrice.split(' ')[0] == 'R') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceR!) *
                      amount;
            } else if (selectedPrice.split(' ')[0] == 'L') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceL!) *
                      amount;
            }

            selectedToppingPriceTemp = selectedToppingPrice;
          });
        } else {
          setState(() {
            selectedTopping = toppingName;
            selectedToppingPrice = toppingPrice!;

            if (selectedPrice.split(' ')[0] == 'R') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceR!) *
                      amount;
            } else if (selectedPrice.split(' ')[0] == 'L') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceL!) *
                      amount;
            }

            selectedToppingPriceTemp = selectedToppingPrice;
          });
        }
      } else {
        if (selectedSizeCupType != '') {
          setState(() {
            selectedTopping = toppingName;
            selectedToppingPrice = toppingPrice!;

            totalPrice = totalPrice - selectedToppingPriceTemp!;
            if (selectedPrice.split(' ')[0] == 'R') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceR!) *
                      amount;
            } else if (selectedPrice.split(' ')[0] == 'L') {
              totalPrice =
                  (selectedToppingPrice + widget.choosenCupMenu.priceL!) *
                      amount;
            }

            selectedToppingPriceTemp = selectedToppingPrice;
          });
        }
      }
    }
  }

  void _onPressedButtonSize(String e) {
    setState(() {
      selectedPrice = e;
    });

    var stringToIntCupPrice = int.parse(selectedPrice.split(' ')[1]);

    setState(() {
      selectedTypeCupPrice = stringToIntCupPrice;
      selectedSizeCupType = (selectedPrice.split(' ')[0] == 'R')
          ? 'Regular'
          : (selectedPrice.split(' ')[0] == 'L')
              ? 'Large'
              : 'no no no';
    });

    if (selectedPrice.split(' ')[0] == 'R') {
      if (totalPrice > 0) {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceR!) * amount;
        });
      } else {
        totalPrice =
            (selectedToppingPrice + widget.choosenCupMenu.priceR!) * amount;
      }
    } else if (selectedPrice.split(' ')[0] == 'L') {
      if (totalPrice > 0) {
        setState(() {
          totalPrice =
              (selectedToppingPrice + widget.choosenCupMenu.priceL!) * amount;
        });
      } else {
        totalPrice =
            (selectedToppingPrice + widget.choosenCupMenu.priceL!) * amount;
      }
    }
  }
}
