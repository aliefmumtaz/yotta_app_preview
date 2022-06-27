part of 'pages.dart';

class SelectMenuPage extends StatefulWidget {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  SelectMenuPage(
    this.selectedProductStyle,
    this.selectedVariant, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  _SelectMenuPageState createState() => _SelectMenuPageState();
}

class _SelectMenuPageState extends State<SelectMenuPage> {
  String? selectedVariant;
  String selectedMenu = '';
  String? selectedProductStyle;
  List<String> productStyle = ['Dingin', 'Panas', 'Botol'];

  @override
  void initState() {
    selectedProductStyle = widget.selectedProductStyle;
    selectedVariant = widget.selectedVariant;
    super.initState();
  }

  void _backPrevPage(String? city, String orderType, String id) async {
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
          context.read<PickupTimeBloc>().add(PickUpTimeToInitial());
          context.read<PickupTimeBloc>().add(GetPickUpTime());
        },
        onTapBottomButton: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (_, orderTypeState) => BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) {
          if (userState is UserLoaded) {
            return WillPopScope(
              onWillPop: () async {
                _backPrevPage(
                  userState.user.city,
                  (orderTypeState is PreOrderType) ? 'Pre-Order' : 'Delivery',
                  userState.user.uid,
                );

                return false;
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: _customAppBar(
                  (orderTypeState is PreOrderType) ? 'Pre-Order' : 'Delivery',
                ) as PreferredSizeWidget?,
                body: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          expandedHeight: height * .28,
                          flexibleSpace: FlexibleSpaceBar(
                            background: _appBarSpaceBar(),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              _generatePreviewMenu(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // menutup bug(celah antara judul varian dengan appbar)
                    Container(
                      height: 1.5,
                      color: Colors.white,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Spacer(),
                          FilterButton(
                            onTap: () => _showBottomSheetForFiltering(),
                          ),
                          SizedBox(height: height * verticalMargin),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _customAppBar(String orderType) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(left: defaultMargin),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              return BackButtonWidget(
                name: 'Pilih Minuman',
                isMarginTop: true,
                onTapFunc: () async => _backPrevPage(
                  userState.user.city,
                  orderType,
                  userState.user.uid,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _appBarSpaceBar() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            height: height * .2,
            child: Image.asset(
              'assets/headline_menu.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SizedBox(height: height * verticalMargin),
          Padding(
            padding: EdgeInsets.only(left: defaultMargin),
            child: Text(
              'Filter: $selectedProductStyle / $selectedVariant',
              style: accentFontBlackRegular.copyWith(
                fontSize: 12,
                color: ThemeColor.accentColor4,
              ),
            ),
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _generatePreviewMenu() {
    if (selectedVariant == 'Semua Menu') {
      return _buildAllMenu();
    } else {
      return _buildMenuPerVariant();
    }
  }

  void _showBottomSheetForFiltering() {
    var height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            height: height * .7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * verticalMargin),
                Text(
                  'Jenis Minuman',
                  style: accentFontBlackBold.copyWith(
                    fontSize: 16,
                    color: ThemeColor.accentColor4,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _generateProductStyle(setState),
                ),
                SizedBox(height: height * verticalMargin),
                Text(
                  'Varian',
                  style: accentFontBlackBold.copyWith(
                    fontSize: 16,
                    color: ThemeColor.accentColor4,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Icon(Icons.arrow_drop_up, color: ThemeColor.mainColor),
                _buildButtonMenuFilter(setState),
                Icon(Icons.arrow_drop_down, color: ThemeColor.mainColor),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonMenuFilter(StateSetter stateSetter) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<OrderTypeBloc, OrderTypeState>(
      builder: (_, orderType) => BlocBuilder<VariantListBloc, VariantListState>(
        builder: (context, variantState) {
          if (variantState is LoadVariantData) {
            return Container(
              height: MediaQuery.of(context).size.height * .4,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: variantState.variant.toList().length,
                itemBuilder: (_, index) {
                  var variantList = variantState.variant.toList()[index];
                  var variantLength = variantState.variant.toList().length;

                  return GestureDetector(
                    onTap: () => _buttonFilterCupOnPressed(
                      stateSetter,
                      variantList,
                      (orderType is DeliveryType) ? true : false,
                    ),
                    child: Container(
                      height: height * 0.07,
                      padding:
                          EdgeInsets.symmetric(vertical: defaultMargin / 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: (index == variantLength - 1)
                                ? Colors.transparent
                                : ThemeColor.mainColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ButtonMenuFilter(
                        title: variantList.variantName,
                        isBorder: selectedVariant == variantList.variantName,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (variantState is LoadVariantBottleData) {
            return Container(
              height: MediaQuery.of(context).size.height * .4,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: variantState.variant.toList().length,
                itemBuilder: (_, index) {
                  var variantList = variantState.variant.toList()[index];
                  var variantLength = variantState.variant.toList().length;

                  return GestureDetector(
                    onTap: () => _buttonFilterBottleOnPressed(
                      stateSetter,
                      variantList,
                      (orderType is DeliveryType) ? true : false,
                    ),
                    child: Container(
                      height: height * 0.07,
                      padding:
                          EdgeInsets.symmetric(vertical: defaultMargin / 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: (index == variantLength - 1)
                                ? Colors.transparent
                                : ThemeColor.mainColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ButtonMenuFilter(
                        title: variantList.variantName,
                        isBorder: selectedVariant == variantList.variantName,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (variantState is LoadVariantHotData) {
            return Container(
              height: MediaQuery.of(context).size.height * .4,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: variantState.variant.toList().length,
                itemBuilder: (_, index) {
                  var variantList = variantState.variant.toList()[index];
                  var variantLength = variantState.variant.toList().length;

                  return GestureDetector(
                    onTap: () => _buttonFilterHotMenuOnPressed(
                      stateSetter,
                      variantList,
                      (orderType is DeliveryType) ? true : false,
                    ),
                    child: Container(
                      height: height * 0.07,
                      padding:
                          EdgeInsets.symmetric(vertical: defaultMargin / 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: (index == variantLength - 1)
                                ? Colors.transparent
                                : ThemeColor.mainColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ButtonMenuFilter(
                        title: variantList.variantName,
                        isBorder: selectedVariant == variantList.variantName,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * .4,
              child: SpinKitRing(
                color: ThemeColor.accentColor2,
                size: 24,
              ),
            );
          }
        },
      ),
    );
  }

  void _buttonFilterHotMenuOnPressed(
    StateSetter stateSetter,
    HotVariant variantList,
    bool isDelivery,
  ) {
    setState(() {
      selectedVariant = variantList.variantName;
    });

    stateSetter(() {
      selectedVariant = variantList.variantName;
    });

    if (selectedVariant == 'Semua Menu') {
      context.read<MenuBloc>().add(MenuToInitial());
    } else {
      context.read<MenuBloc>().add(MenuToInitial());
      context.read<MenuBloc>().add(
            LoadHotMenuPerVariant(
              selectedVariant,
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );
    }

    Navigator.pop(context);
  }

  void _buttonFilterBottleOnPressed(
    StateSetter stateSetter,
    BottleVariant variantList,
    bool isDelivery,
  ) {
    setState(() {
      selectedVariant = variantList.variantName;
    });

    stateSetter(() {
      selectedVariant = variantList.variantName;
    });

    if (selectedVariant == 'Semua Menu') {
      context.read<MenuBloc>().add(MenuToInitial());
    } else {
      context.read<MenuBloc>().add(MenuToInitial());
      context.read<MenuBloc>().add(
            LoadMenuBottlePerVariant(
              selectedVariant,
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );
    }

    Navigator.pop(context);
  }

  void _buttonFilterCupOnPressed(
    StateSetter stateSetter,
    Variant variantList,
    bool isDelivery,
  ) {
    setState(() {
      selectedVariant = variantList.variantName;
    });

    stateSetter(() {
      selectedVariant = variantList.variantName;
    });

    if (selectedVariant == 'Semua Menu') {
      context.read<MenuBloc>().add(MenuToInitial());
      print(selectedVariant);
    } else {
      print(selectedVariant);
      context.read<MenuBloc>().add(MenuToInitial());
      context.read<MenuBloc>().add(
            LoadMenuPerVariant(
              selectedVariant,
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );
    }

    Navigator.pop(context);
  }

  List<Widget> _generateProductStyle(StateSetter setStatter) {
    return productStyle
        .map(
          (e) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
            builder: (_, orderType) => GestureDetector(
              onTap: () => _productStyleOnPressed(
                setStatter,
                e,
                (orderType is DeliveryType) ? true : false,
              ),
              child: ButtonMenuFilterForMenuStyle(
                title: e,
                width: .27,
                isBorder: selectedProductStyle == e,
              ),
            ),
          ),
        )
        .toList();
  }

  void _productStyleOnPressed(
    StateSetter setStatter,
    String e,
    bool isDelivery,
  ) {
    setState(() {
      selectedProductStyle = e;
    });

    setStatter(() {
      selectedProductStyle = e;
    });

    if (e == 'Dingin') {
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllMenu(
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );

      setState(() {
        selectedVariant = 'Semua Menu';
      });

      setStatter(() {
        selectedVariant = 'Semua Menu';
      });

      context.read<VariantListBloc>().add(VariantListEvent());
      context.read<VariantListBloc>().add(GetVariantList());

      if (selectedVariant == 'Semua Menu') {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<AllMenuBloc>().add(
              GetAllMenu(
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadMenuPerVariant(
                selectedVariant,
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      }
    } else if (e == 'Botol') {
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllMenuBottle(
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );

      setState(() {
        selectedVariant = 'Semua Menu';
      });

      setStatter(() {
        selectedVariant = 'Semua Menu';
      });

      context.read<VariantListBloc>().add(VariantListEvent());
      context.read<VariantListBloc>().add(GetVariantBottleList());

      if (selectedVariant == 'Semua Menu') {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<AllMenuBloc>().add(
              GetAllMenuBottle(
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadMenuBottlePerVariant(
                selectedVariant,
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      }
    } else if (e == 'Panas') {
      print('tes');
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllHotMenu(
              (isDelivery == true)
                  ? widget.deliveryOrderData!.outlet
                  : widget.preOrderData!.outlet,
            ),
          );

      setState(() {
        selectedVariant = 'Semua Menu';
      });

      setStatter(() {
        selectedVariant = 'Semua Menu';
      });

      context.read<VariantListBloc>().add(VariantListEvent());
      context.read<VariantListBloc>().add(GetVariantHotList());

      if (selectedVariant == 'Semua Menu') {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<AllMenuBloc>().add(
              GetAllHotMenu(
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadHotMenuPerVariant(
                selectedVariant,
                (isDelivery == true)
                    ? widget.deliveryOrderData!.outlet
                    : widget.preOrderData!.outlet,
              ),
            );
      }
    }
  }

  void _cupMenuCardOnPressed(
    String? name,
    int? l,
    int? r,
    String? varian,
    String? imgUrl,
  ) {
    List<String> listPrice = ['R $r', 'L $l'];

    context.read<PageBloc>().add(
          GoToSelectDetailOrderCup(
            ChoosenColdMenu(
              name: name,
              priceL: l,
              priceR: r,
              varian: varian,
            ),
            listPrice,
            'Dingin',
            selectedVariant,
            selectedProductStyle,
            preOrderData: widget.preOrderData,
            deliveryOrderData: widget.deliveryOrderData,
            imgUrl: imgUrl,
          ),
        );
  }

  void _hotMenuCardOnPressed(String? name, int? r, String? varian) {
    List<String> listPrice = [''];

    context.read<PageBloc>().add(
          GoToSelectDetailOrderHot(
            ChoosenHotMenu(
              name: name,
              priceR: r,
              varian: varian,
            ),
            'Panas',
            listPrice,
            selectedVariant,
            selectedProductStyle,
            preOrderData: widget.preOrderData,
            deliveryOrderData: widget.deliveryOrderData,
          ),
        );
  }

  void _bottleMenuCardOnPressed(
    String? name,
    int? ml500,
    int? ml1000,
    String? varian,
  ) {
    List<String> bottleListPrice = [
      '500ml $ml500',
      '1000ml $ml1000',
    ];

    context.read<PageBloc>().add(
          GoToSelectDetailOrderBottle(
            ChoosenBottleMenu(
              name: name,
              price1000ml: ml1000,
              price500ml: ml500,
              varian: varian,
            ),
            bottleListPrice,
            'Botol',
            selectedVariant,
            selectedProductStyle,
            preOrderData: widget.preOrderData,
            deliveryOrderData: widget.deliveryOrderData,
          ),
        );
  }

  Widget _buildAllMenu() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<AllMenuBloc, AllMenuState>(
      builder: (_, allMenuState) {
        if (allMenuState is AllMenuLoad) {
          return Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: allMenuState.allMenu
                    .map(
                      (e) => StickyHeaderBuilder(
                        builder: (_, stuckAmount) {
                          stuckAmount = 1 - stuckAmount.clamp(0.0, 1.0);

                          return (e.name == 'Semua Menu')
                              ? Container()
                              : _customStickyHeaderAllMenuVariant(
                                  stuckAmount,
                                  e.name!,
                                );
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.allMenuList!.map((e) {
                                  var menu = e.listMenu!;

                                  return Column(
                                    children: [
                                      if (menu.isAvailable == true)
                                        ColdMenuCard(
                                          imgUrl: menu.imgUrl,
                                          menuName: menu.name,
                                          priceL: menu.priceL.toString(),
                                          priceR: menu.priceR.toString(),
                                          onTap: () {
                                            _cupMenuCardOnPressed(
                                              menu.name,
                                              menu.priceL,
                                              menu.priceR,
                                              menu.varian,
                                              menu.imgUrl,
                                            );
                                          },
                                        ),
                                      SizedBox(
                                        height: height * verticalMargin,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: height * verticalMargin)
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: height * verticalMargin * 4),
            ],
          );
        } else if (allMenuState is AllMenuBottleLoaded) {
          return Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: allMenuState.allMenuBottle
                    .map(
                      (e) => StickyHeaderBuilder(
                        builder: (_, stuckAmount) {
                          stuckAmount = 1 - stuckAmount.clamp(0.0, 1.0);

                          return (e.name == 'Semua Menu')
                              ? Container()
                              : _customStickyHeaderAllMenuVariant(
                                  stuckAmount,
                                  e.name!,
                                );
                        },
                        content: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.allMenuBottleList!.map((e) {
                                  var menu = e.bottleMenu!;

                                  return Column(
                                    children: [
                                      if (menu.isAvailable == true)
                                        BottleMenuCard(
                                            menuName: menu.name,
                                            price500ml: '${menu.ml500}',
                                            price1000ml: '${menu.ml1000}',
                                            onTap: () {
                                              _bottleMenuCardOnPressed(
                                                menu.name,
                                                menu.ml500,
                                                menu.ml1000,
                                                menu.varian,
                                              );
                                            }),
                                      SizedBox(
                                        height: height * verticalMargin,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: height * verticalMargin),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: height * verticalMargin * 4),
            ],
          );
        } else if (allMenuState is AllHotMenuLoaded) {
          return Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: allMenuState.allHotMenu
                    .map(
                      (e) => StickyHeaderBuilder(
                        builder: (_, stuckAmount) {
                          stuckAmount = 1 - stuckAmount.clamp(0.0, 1.0);

                          return (e.name == 'Semua Menu')
                              ? Container()
                              : _customStickyHeaderAllMenuVariant(
                                  stuckAmount,
                                  e.name!,
                                );
                        },
                        content: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.hotMenuPerVariant!.map((e) {
                                  var menu = e.hotMenu!;

                                  return Column(
                                    children: [
                                      if (menu.isAvailable == true)
                                        HotMenuCard(
                                          menuName: menu.name,
                                          priceR: '${menu.priceR}',
                                          onTap: () {
                                            _hotMenuCardOnPressed(
                                              menu.name,
                                              menu.priceR,
                                              menu.varian,
                                            );
                                          },
                                        ),
                                      SizedBox(
                                        height: height * verticalMargin,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: height * verticalMargin),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: height * verticalMargin * 4),
            ],
          );
        } else {
          if (selectedProductStyle == 'Dingin') {
            return SkeletonLoadingForAllMenu(
              height: .38,
              width: .41,
            );
          } else if (selectedProductStyle == 'Botol') {
            return SkeletonLoadingForAllMenu(
              height: .2,
              width: .41,
            );
          } else if (selectedProductStyle == 'Panas') {
            return SkeletonLoadingForAllMenu(
              height: .15,
              width: .41,
            );
          } else {
            return SizedBox();
          }
        }
      },
    );
  }

  Widget _customStickyHeaderAllMenuVariant(
    double stuckAmount,
    String variantName,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(defaultMargin, 6, 24, 6),
      child: Text(
        variantName,
        style: accentFontBlackBold.copyWith(
          color: ThemeColor.mainColor,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildMenuPerVariant() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<AllMenuBloc, AllMenuState>(
      builder: (_, allMenuState) => BlocBuilder<MenuBloc, MenuState>(
        builder: (_, menuState) {
          if (selectedProductStyle == 'Dingin') {
            if (menuState is MenuPerVariantLoaded) {
              return StickyHeaderBuilder(
                builder: (_, stuckAMount) {
                  return _customStickyHeaderAllMenuVariant(
                    stuckAMount,
                    selectedVariant!,
                  );
                },
                content: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.menuPerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  if (e.listMenu!.isAvailable == true)
                                    ColdMenuCard(
                                      imgUrl: e.listMenu!.imgUrl,
                                      menuName: e.listMenu!.name,
                                      priceL: '${e.listMenu!.priceL}',
                                      priceR: '${e.listMenu!.priceR}',
                                      isSelected:
                                          e.listMenu!.name == selectedMenu,
                                      onTap: () {
                                        _cupMenuCardOnPressed(
                                          e.listMenu!.name,
                                          e.listMenu!.priceL,
                                          e.listMenu!.priceR,
                                          e.listMenu!.varian,
                                          e.listMenu!.imgUrl,
                                        );
                                      },
                                    ),
                                  SizedBox(height: height * verticalMargin),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: height * verticalMargin * 4),
                  ],
                ),
              );
            } else {
              return SkeletonLoadingForAllMenu(
                height: .38,
                width: .41,
              );
            }
          } else if (selectedProductStyle == 'Botol') {
            if (menuState is MenuBottlePerVariantLoaded) {
              return StickyHeaderBuilder(
                builder: (_, stuckAmount) {
                  return _customStickyHeaderAllMenuVariant(
                    stuckAmount,
                    selectedVariant!,
                  );
                },
                content: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.menuBottlePerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  if (e.bottleMenu!.isAvailable == true)
                                    BottleMenuCard(
                                      menuName: e.bottleMenu!.name,
                                      price1000ml: '${e.bottleMenu!.ml1000}',
                                      price500ml: '${e.bottleMenu!.ml500}',
                                      onTap: () {
                                        _bottleMenuCardOnPressed(
                                          e.bottleMenu!.name,
                                          e.bottleMenu!.ml500,
                                          e.bottleMenu!.ml1000,
                                          e.bottleMenu!.varian,
                                        );
                                      },
                                    ),
                                  SizedBox(height: height * verticalMargin),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: height * verticalMargin * 4),
                  ],
                ),
              );
            } else {
              return SkeletonLoadingForAllMenu(
                height: .2,
                width: .41,
              );
            }
          } else if (selectedProductStyle == 'Panas') {
            if (menuState is HotMenuPerVariantLoaded) {
              return StickyHeaderBuilder(
                builder: (_, stuckAmount) {
                  return _customStickyHeaderAllMenuVariant(
                    stuckAmount,
                    selectedVariant!,
                  );
                },
                content: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.hotMenuPerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  if (e.hotMenu!.isAvailable == true)
                                    HotMenuCard(
                                      menuName: e.hotMenu!.name,
                                      priceR: '${e.hotMenu!.priceR}',
                                      onTap: () {
                                        _hotMenuCardOnPressed(
                                          e.hotMenu!.name,
                                          e.hotMenu!.priceR,
                                          e.hotMenu!.varian,
                                        );
                                      },
                                    ),
                                  SizedBox(height: height * verticalMargin),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: height * verticalMargin * 4),
                  ],
                ),
              );
            } else {
              return SkeletonLoadingForAllMenu(
                height: .15,
                width: .41,
              );
            }
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
