part of 'pages.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String? selectedVariant = 'Semua Menu';
  String selectedProductStyle = 'Dingin';
  List<String> productStyle = ['Dingin', 'Panas', 'Botol'];

  void _backPrevPage() async {
    context.read<PageBloc>().add(GoToHomePage(0));
    context.read<MenuBloc>().add(MenuToInitial());
    context.read<AllMenuBloc>().add(AllMenuToInitial());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<GuestModeBloc, GuestModeState>(
      builder: (_, guestMode) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
        builder: (_, orderTypeState) => BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (guestMode is GuestMode) {
              return WillPopScope(
                onWillPop: () async {
                  _backPrevPage();

                  return false;
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: _customAppBarGuestMode(
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
              if (userState is UserLoaded) {
                return WillPopScope(
                  onWillPop: () async {
                    _backPrevPage();

                    return false;
                  },
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: _customAppBar(
                      (orderTypeState is PreOrderType)
                          ? 'Pre-Order'
                          : 'Delivery',
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
            }
          },
        ),
      ),
    );
  }

  Widget _customAppBar(String orderType) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: defaultMargin),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              return BackButtonWidget(
                name: 'Pilih Minuman',
                isMarginTop: true,
                onTapFunc: () async => _backPrevPage(),
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

  Widget _customAppBarGuestMode(String orderType) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: defaultMargin),
        child: BackButtonWidget(
          name: 'Menu Minuman',
          isMarginTop: true,
          onTapFunc: () async => _backPrevPage(),
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
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            height: height * .2,
            child: Image.asset(
              'assets/headline_menu_page.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SizedBox(height: height * verticalMargin),
          Padding(
            padding: const EdgeInsets.only(left: defaultMargin),
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
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
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

    return BlocBuilder<VariantListBloc, VariantListState>(
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
                  ),
                  child: Container(
                    height: height * 0.07,
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultMargin / 2),
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
                  ),
                  child: Container(
                    height: height * 0.07,
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultMargin / 2,
                    ),
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
                  ),
                  child: Container(
                    height: height * 0.07,
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultMargin / 2,
                    ),
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
    );
  }

  void _buttonFilterHotMenuOnPressed(
    StateSetter stateSetter,
    HotVariant variantList,
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
              'Tamalate',
            ),
          );
    }

    Navigator.pop(context);
  }

  void _buttonFilterBottleOnPressed(
    StateSetter stateSetter,
    BottleVariant variantList,
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
              'Tamalate',
            ),
          );
    }

    Navigator.pop(context);
  }

  void _buttonFilterCupOnPressed(
    StateSetter stateSetter,
    Variant variantList,
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
              'Tamalate',
            ),
          );
    }

    Navigator.pop(context);
  }

  List<Widget> _generateProductStyle(StateSetter setStatter) {
    return productStyle
        .map(
          (e) => GestureDetector(
            onTap: () => _productStyleOnPressed(setStatter, e),
            child: ButtonMenuFilterForMenuStyle(
              title: e,
              width: .27,
              isBorder: selectedProductStyle == e,
            ),
          ),
        )
        .toList();
  }

  void _productStyleOnPressed(StateSetter setStatter, String e) {
    setState(() {
      selectedProductStyle = e;
    });

    setStatter(() {
      selectedProductStyle = e;
    });

    if (e == 'Dingin') {
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllMenu('Tamalate'),
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
                'Tamalate',
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadMenuPerVariant(
                selectedVariant,
                'Tamalate',
              ),
            );
      }
    } else if (e == 'Botol') {
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllMenuBottle(
              'Tamalate',
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
                'Tamalate',
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadMenuBottlePerVariant(
                selectedVariant,
                'Tamalate',
              ),
            );
      }
    } else if (e == 'Panas') {
      print('tes');
      context.read<AllMenuBloc>().add(AllMenuToInitial());
      context.read<AllMenuBloc>().add(
            GetAllHotMenu(
              'Tamalate',
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
                'Tamalate',
              ),
            );
      } else {
        context.read<MenuBloc>().add(MenuToInitial());
        context.read<MenuBloc>().add(
              LoadHotMenuPerVariant(
                selectedVariant,
                'Tamalate',
              ),
            );
      }
    }
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.allMenuList!.map((e) {
                                  var menu = e.listMenu!;

                                  return Column(
                                    children: [
                                      ColdMenuCard(
                                        menuName: menu.name,
                                        priceL: menu.priceL.toString(),
                                        priceR: menu.priceR.toString(),
                                        imgUrl: menu.imgUrl,
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.allMenuBottleList!.map((e) {
                                  var menu = e.bottleMenu!;

                                  return Column(
                                    children: [
                                      BottleMenuCard(
                                        menuName: menu.name,
                                        price500ml: '${menu.ml500}',
                                        price1000ml: '${menu.ml1000}',
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: e.hotMenuPerVariant!.map((e) {
                                  var menu = e.hotMenu!;

                                  return Column(
                                    children: [
                                      HotMenuCard(
                                        menuName: menu.name,
                                        priceR: '${menu.priceR}',
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.menuPerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  ColdMenuCard(
                                    menuName: e.listMenu!.name,
                                    priceL: '${e.listMenu!.priceL}',
                                    priceR: '${e.listMenu!.priceR}',
                                    imgUrl: e.listMenu!.imgUrl,
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.menuBottlePerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  BottleMenuCard(
                                    menuName: e.bottleMenu!.name,
                                    price1000ml: '${e.bottleMenu!.ml1000}',
                                    price500ml: '${e.bottleMenu!.ml500}',
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: menuState.hotMenuPerVariant
                            .map(
                              (e) => Column(
                                children: [
                                  HotMenuCard(
                                    menuName: e.hotMenu!.name,
                                    priceR: '${e.hotMenu!.priceR}',
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
