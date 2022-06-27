part of 'pages.dart';

class ListPromoPage extends StatefulWidget {
  final String idMember;
  final String userCity;

  ListPromoPage({
    required this.idMember,
    required this.userCity,
  });

  @override
  _ListPromoPageState createState() => _ListPromoPageState();
}

class _ListPromoPageState extends State<ListPromoPage>
    with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  AnimationController? _anicontroller, _scaleController;
  AnimationController? _footerController;

  void _onRefresh() async {
    print('refresh. . . . . .');

    context.read<PromoBloc>().add(
          GetAllPromoList(idMember: widget.idMember, userCity: widget.userCity),
        );

    context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(widget.idMember));

    await Future.delayed(Duration(seconds: 2));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print('loading. . . . . .');

    context.read<PromoBloc>().add(
          GetAllPromoList(
            idMember: widget.idMember,
            userCity: widget.userCity,
          ),
        );

    context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(widget.idMember));

    context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(widget.idMember));

    if (mounted) {
      setState(() {});
    }

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _anicontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _scaleController = AnimationController(
      value: 0.0,
      vsync: this,
      upperBound: 1.0,
    );

    _footerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _refreshController.headerMode!.addListener(() {
      if (_refreshController.headerStatus == RefreshStatus.idle) {
        _scaleController!.value = 0.0;
        _anicontroller!.reset();
      } else if (_refreshController.headerStatus == RefreshStatus.refreshing) {
        _anicontroller!.repeat();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildAppBar() {
      var height = MediaQuery.of(context).size.height;

      return Container(
        height: height * .06,
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.read<PageBloc>().add(GoToHomePage(0)),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: ThemeColor.blackTextColor,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * horizontalMarginHalf,
            ),
            AutoSizeText(
              'List Promo',
              style: mainFontBlackRegular.copyWith(
                fontSize: 16,
                color: ThemeColor.blackTextColor,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildStickyHeader(Widget widget) {
      return StickyHeaderBuilder(
        builder: (_, stuckAmount) {
          stuckAmount = 1 - stuckAmount.clamp(0.0, 1.0);

          return buildAppBar();
        },
        content: widget,
      );
    }

    Widget claimedPromoWidget(LoadAllClaimedPromo loadAllClaimedPromo) {
      return Column(
        children: loadAllClaimedPromo.claimedPromo.map(
          (e) {
            return GestureDetector(
              onTap: () {
                print('user promo id = ${e.userPromoId!}');

                context.read<PageBloc>().add(
                      GoToDetailPromoPage(
                        isBirthdayPromo:
                            (e.claimedPromo!.promoCategory == 'birthday')
                                ? true
                                : false,
                        isFromMainPage: false,
                        isSpecialPromo: false,
                        isClaimed: true,
                        promo: Promo(
                          img: e.claimedPromo!.img,
                          provision: e.claimedPromo!.provision,
                          promoId: e.claimedPromo!.promoId,
                          availableCity: [],
                          promoCategory: e.claimedPromo!.promoCategory,
                          promoEndDate: e.claimedPromo!.promoEndDate,
                          promoStartDate: e.claimedPromo!.promoStartDate,
                          termCondition: e.claimedPromo!.termCondition,
                        ),
                        userPromoId: e.userPromoId!,
                      ),
                    );
              },
              child: (e.claimedPromo!.promoCategory == 'birthday')
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultMargin / 2),
                      child: BirthdayCard(),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: defaultMargin / 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          '${e.claimedPromo!.img}',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * .3,
                                color: ThemeColor.accentColor5,
                              );
                            }
                          },
                        ),
                      ),
                    ),
            );
          },
        ).toList(),
      );
    }

    Widget unclaimedPromoWidget(LoadAllPromoList promoState) {
      return Column(
        children: promoState.promos.map(
          (e) {
            if (e.promoCategory != 'birthday') {
              return GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(
                        GoToDetailPromoPage(
                          isBirthdayPromo: false,
                          isFromMainPage: false,
                          isSpecialPromo: false,
                          isClaimed: false,
                          promo: Promo(
                            img: e.img!,
                            provision: e.provision!,
                            availableCity: e.availableCity,
                            promoCategory: e.promoCategory,
                            promoEndDate: e.promoEndDate,
                            promoStartDate: e.promoStartDate,
                            termCondition: e.termCondition,
                            promoId: e.promoId,
                          ),
                          userPromoId: 0,
                        ),
                      );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: defaultMargin / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      e.img!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .3,
                            color: ThemeColor.accentColor5,
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ).toList(),
      );
    }

    Widget promoStatusTitle({
      required String title,
      required String iconAsset,
      required String desc,
    }) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: defaultMargin / 2),
            height: height * 0.04,
            width: height * 0.04,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(iconAsset),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                style: accentFontBlackBold.copyWith(
                  fontSize: 16,
                ),
              ),
              Container(
                width: width * .7,
                // color: Colors.blue,
                child: AutoSizeText(
                  desc,
                  style: accentFontBlackRegular.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget skeletonLoading() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.only(top: defaultMargin / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ThemeColor.accentColor5,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.only(top: defaultMargin / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ThemeColor.accentColor5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget specialPromo() {
      var height = MediaQuery.of(context).size.height;

      return BlocBuilder<GetPromoNextPurchaseBloc, GetPromoNextPurchaseState>(
        builder: (_, nextPurchasePromoState) {
          if (nextPurchasePromoState is LoadPromoNextPurchaseData) {
            if (nextPurchasePromoState.message == 'data kosong') {
              return SizedBox();
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * verticalMargin),
                    AutoSizeText(
                      "Promo Spesial",
                      style: accentFontBlackBold.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: height * verticalMargin),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToDetailPromoPage(
                                isBirthdayPromo: false,
                                isFromMainPage: false,
                                isSpecialPromo: true,
                                promo: Promo(
                                  availableCity: [],
                                  img: nextPurchasePromoState
                                      .promo.claimedPromo!.img,
                                  promoCategory: nextPurchasePromoState
                                      .promo.claimedPromo!.promoCategory,
                                  promoEndDate: nextPurchasePromoState
                                      .promo.claimedPromo!.promoEndDate,
                                  promoId: '0',
                                  promoStartDate: nextPurchasePromoState
                                      .promo.claimedPromo!.promoStartDate,
                                  provision: nextPurchasePromoState
                                      .promo.claimedPromo!.provision,
                                  termCondition: nextPurchasePromoState
                                      .promo.claimedPromo!.termCondition,
                                ),
                                isClaimed: true,
                                userPromoId:
                                    nextPurchasePromoState.promo.userPromoId!,
                              ));
                        },
                        child: Image.network(
                          nextPurchasePromoState.promo.claimedPromo!.img!,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  print('loading bos');
                                },
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  color: ThemeColor.accentColor5,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .3,
              color: ThemeColor.accentColor5,
            );
          }
        },
      );
    }

    // Widget tes() {
    //   return TesWidget();
    // }

    Widget generateListPromo() {
      var height = MediaQuery.of(context).size.height;

      return BlocBuilder<ClaimedPromoBloc, ClaimedPromoState>(
        builder: (_, claimedPromoState) =>
            BlocBuilder<PromoBloc, PromoState>(builder: (_, promoState) {
          if (promoState is LoadAllPromoList) {
            if (claimedPromoState is LoadAllClaimedPromo) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    if (claimedPromoState.claimedPromo.isNotEmpty)
                      SizedBox(height: height * verticalMargin),
                    if (claimedPromoState.claimedPromo.isNotEmpty)
                      promoStatusTitle(
                        title: 'Berhasil Diklaim',
                        iconAsset: 'assets/promo_claimed.png',
                        desc: 'Tukarkan promonya di outlet terdekat',
                      ),
                    if (claimedPromoState.claimedPromo.isNotEmpty)
                      SizedBox(height: height * verticalMarginHalf),
                    claimedPromoWidget(claimedPromoState),
                    SizedBox(height: height * verticalMargin),
                    if (promoState.promos.isNotEmpty)
                      promoStatusTitle(
                        title: 'Pilihan Promo',
                        iconAsset: 'assets/promo_list_icon.png',
                        desc: 'Promo hemat, minum makin nikmat',
                      ),
                    if (promoState.promos.isNotEmpty)
                      SizedBox(height: height * verticalMarginHalf),
                    if (promoState.promos.isNotEmpty)
                      unclaimedPromoWidget(promoState),
                    SizedBox(height: height * verticalMargin),
                  ],
                ),
              );
            } else {
              return skeletonLoading();
            }
          } else {
            return skeletonLoading();
          }
        }),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToHomePage(0));

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: CustomHeader(
              refreshStyle: RefreshStyle.Behind,
              onOffsetChange: (offset) {
                if (_refreshController.headerMode!.value !=
                    RefreshStatus.refreshing)
                  _scaleController!.value = offset / 80.0;
              },
              builder: (c, m) {
                return Container(
                  child: FadeTransition(
                    opacity: _scaleController!,
                    child: ScaleTransition(
                      child: SpinKitFadingCircle(
                        size: 30.0,
                        controller: _anicontroller,
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven
                                  ? ThemeColor.mainColor
                                  : ThemeColor.mainColor2,
                            ),
                          );
                        },
                      ),
                      scale: _scaleController!,
                    ),
                  ),
                  alignment: Alignment.center,
                );
              },
            ),
            footer: CustomFooter(
              onModeChange: (mode) {
                if (mode == LoadStatus.loading) {
                  _scaleController!.value = 0.0;
                  _footerController!.repeat();
                } else {
                  _footerController!.reset();
                }
              },
              builder: (context, mode) {
                Widget? child;
                switch (mode) {
                  case LoadStatus.failed:
                    child = Text("failed,click retry");
                    break;
                  case LoadStatus.noMore:
                    child = Text("no more data");
                    break;
                  default:
                    child = SpinKitFadingCircle(
                      size: 30.0,
                      controller: _footerController,
                      itemBuilder: (_, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    );
                    break;
                }
                return Container(
                  height: 60,
                  child: Center(
                    child: child,
                  ),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              children: [
                buildStickyHeader(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      specialPromo(),
                      generateListPromo(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _anicontroller!.dispose();
    _scaleController!.dispose();
    _footerController!.dispose();

    super.dispose();
  }
}
