part of 'pages.dart';

class CartCheckoutPage extends StatefulWidget {
  final PageEvent pageEvent;

  CartCheckoutPage(this.pageEvent);

  @override
  _CartCheckoutPageState createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage>
    with TickerProviderStateMixin {
  late AnimationController _colorAnimationController;
  Animation? _colorTween, _appbarColorTween;

  @override
  void dispose() {
    _colorAnimationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.black,
    ).animate(_colorAnimationController);

    _appbarColorTween = ColorTween(
      begin: Colors.white.withOpacity(0),
      end: ThemeColor.whiteBackColor,
    ).animate(_colorAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(
        scrollInfo.metrics.pixels / 50,
      );

      return true;
    } else {
      return false;
    }
  }

  void _backButtonPressed() async {
    context.read<PageBloc>().add(widget.pageEvent);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backButtonPressed();

        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                BlocBuilder<ChangeStatusOrderBloc, ChangeStatusOrderState>(
                  builder: (_, statusState) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: (statusState is ChangeStatusToDone)
                            ? [ThemeColor.accentColor3, ThemeColor.accentColor2]
                            : [ThemeColor.mainColor, ThemeColor.mainColor],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) => _buildHeader(
                    (userState is UserLoaded) ? userState.user.uid : '',
                  ),
                ),
                _buildDraggableWidget(),
                _buildAppBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    var height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _colorAnimationController,
          builder: (_, child) => Container(
            padding: EdgeInsets.only(left: defaultMargin),
            color: _appbarColorTween!.value,
            width: double.infinity,
            height: height * .1,
          ),
        ),
        AnimatedBuilder(
          animation: _colorAnimationController,
          builder: (_, child) => SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: defaultMargin),
              color: _appbarColorTween!.value,
              width: double.infinity,
              height: height * .08,
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackButtonWidget(
                  name: 'Detail Order',
                  color: _colorTween!.value,
                  onTapFunc: () async => _backButtonPressed(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusOrder(String? status) {
    return AutoSizeText(
      status!,
      style: mainFontWhiteBold.copyWith(
        fontSize: 34,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildHeader(String? id) {
    var height = MediaQuery.of(context).size.height;

    CollectionReference _orderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id!)
        .collection('checkout_order');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: height * 0.5,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(
            stream: _orderType
                .where('tipe order', isEqualTo: 'Pre-Order')
                .snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return SizedBox();
              } else if (!snapshot.hasData) {
                return SizedBox();
              } else {
                return Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    if (doc['status'] == 'Dalam Proses') {
                      return _statusOrder('Pesananmu\nSedang Diproses');
                    } else {
                      return _statusOrder('Pesananmu\nSudah Bisa Diambil');
                    }
                  }).toList(),
                );
              }
            },
          ),
          SizedBox(height: height * (verticalMargin * 2)),
          Image.asset(
            'assets/cart_checkout_outlet.png',
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableWidget() {
    var height = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
      initialChildSize: .505,
      minChildSize: .505,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: ThemeColor.whiteBackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ListView(
            controller: controller,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    BlocBuilder<ListOrderCheckoutCupBloc,
                        ListOrderCheckoutCupState>(builder: (_, cupOrderState) {
                      if (cupOrderState is LoadListCheckoutOrderCup) {
                        return Column(
                          children: [
                            Column(
                              children: cupOrderState.orderCupDetail
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
                            _buildHotOrderList(),
                            _buildBottleOrderList(),
                            _buildOrderTypeCard(),
                            _buildTotalPriceCard(),
                            GlobalButton(
                              title: 'Kembali',
                              onTapFunc: () async {
                                _backButtonPressed();
                              },
                            ),
                            SizedBox(height: defaultMargin),
                          ],
                        );
                      } else {
                        return Container(
                          height: height * .4,
                          child: SpinKitRing(
                            color: ThemeColor.accentColor2,
                            size: 34,
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottleOrderList() {
    return BlocBuilder<ListOrderCheckoutBottleBloc,
        ListOrderCheckoutBottleState>(
      builder: (_, bottleOrderState) {
        if (bottleOrderState is LoadListCheckoutOrderBottle) {
          return Column(
            children: bottleOrderState.orderBottleDetail
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

  Widget _buildHotOrderList() {
    return BlocBuilder<ListOrderCheckoutHotBloc, ListOrderCheckoutHotState>(
      builder: (_, hotOrderState) {
        if (hotOrderState is LoadListCheckoutOrderHot) {
          return Column(
            children: hotOrderState.orderHotDetail
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

  Widget _buildOrderTypeCard() {
    return BlocBuilder<CheckoutPreorderDataBloc, CheckoutPreorderDataState>(
      builder: (_, preOrderDataState) {
        if (preOrderDataState is LoadCheckoutPreOrderData) {
          var orderType = preOrderDataState.preOrderdata;

          return CardOrderType(
            orderType: orderType.orderType,
            outlet: orderType.outlet,
            pickupTime: orderType.pickupTime,
            orderID: orderType.orderID,
          );
        } else {
          return Text('eror');
        }
      },
    );
  }

  Widget _buildTotalPriceCard() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<CheckoutPreorderDataBloc, CheckoutPreorderDataState>(
      builder: (_, totalPrice) => Container(
        margin: EdgeInsets.symmetric(vertical: defaultMargin),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              SizedBox(height: height * verticalMargin),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'Total Harga',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 16,
                      color: ThemeColor.accentColor4,
                    ),
                  ),
                  AutoSizeText(
                    (totalPrice is LoadCheckoutPreOrderData)
                        ? '${totalPrice.totalPrice}.000'
                        : '',
                    style: accentFontBlackBold.copyWith(
                      fontSize: 18,
                      color: ThemeColor.accentColor3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * verticalMargin),
            ],
          ),
        ),
      ),
    );
  }
}
