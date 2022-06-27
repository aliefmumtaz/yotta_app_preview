part of 'pages.dart';

class MainPage extends StatefulWidget {
  final String? idMember;
  final bool? isGuest;
  final String? userCity;
  final String? userBirthday;
  final String? userID;

  MainPage({
    required this.idMember,
    required this.isGuest,
    required this.userCity,
    required this.userBirthday,
    required this.userID,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> dummyStr = ['a', 'b', 'c', 'd'];

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  AnimationController? _anicontroller, _scaleController;
  AnimationController? _footerController;

  void _onRefresh() async {
    print('refresh. . . . . .');

    context.read<PromoBloc>().add(
          GetAllPromoList(
            idMember: (widget.isGuest!) ? 'testing123' : widget.idMember!,
            userCity: (widget.isGuest!) ? 'Makassar' : widget.userCity!,
          ),
        );

    context.read<UserPointBloc>().add(GetUserPoint(widget.idMember!));

    context.read<SpecialOfferBloc>().add(GetSpecialOfferData());

    context.read<GetPromoNextPurchaseBloc>().add(
          GetPromoNextPurchase(widget.idMember!),
        );

    context.read<BirthdayCheckingBloc>().add(
          CheckBirthday(
            todayDate: DateTime.now().dateTime,
            birthday: widget.userBirthday!,
            idMember: widget.idMember!,
          ),
        );

    await Future.delayed(Duration(seconds: 2));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print('loading. . . . . .');

    context.read<UserPointBloc>().add(GetUserPoint(widget.idMember!));

    context.read<PromoBloc>().add(
          GetAllPromoList(
            idMember: (widget.isGuest!) ? 'testing123' : widget.idMember!,
            userCity: (widget.isGuest!) ? 'Makassar' : widget.userCity!,
          ),
        );

    context.read<GetPromoNextPurchaseBloc>().add(
          GetPromoNextPurchase(widget.idMember!),
        );

    context.read<BirthdayCheckingBloc>().add(
          CheckBirthday(
            todayDate: DateTime.now().dateTime,
            birthday: widget.userBirthday!,
            idMember: widget.idMember!,
          ),
        );

    if (mounted) {
      setState(() {});
    }

    _refreshController.loadComplete();
  }

  bool isBirthday = false;

  @override
  void initState() {
    super.initState();

    if (!widget.isGuest!) {
      context.read<PromoBloc>().add(
            GetAllPromoList(
              idMember: widget.idMember!,
              userCity: 'Makassar',
            ),
          );
    }

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
  }

  @override
  void dispose() {
    _footerController!.dispose();
    _anicontroller!.dispose();
    _scaleController!.dispose();
    _refreshController.dispose();

    super.dispose();
  }

  bool isSpecialPromoLoadingImg = false;

  bool _isPromoBtnPressed = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.isGuest == false) {
      context.read<UserPointBloc>().add(GetUserPoint(widget.idMember));

      context.read<UserBloc>().add(LoadUser(widget.userID!));

      context.read<ClaimedPromoBloc>().add(
            GetAllClaimedPromo(widget.idMember!),
          );

      context.read<BirthdayCheckingBloc>().add(
            CheckBirthday(
              todayDate: DateTime.now().dateTime,
              birthday: widget.userBirthday!,
              idMember: widget.idMember!,
            ),
          );
    }

    var height = MediaQuery.of(context).size.height;

    Widget birthdayPromoWidget() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: BlocBuilder<BirthdayCheckingBloc, bool>(
          builder: (_, isItBirthday) =>
              BlocBuilder<ClaimedPromoBloc, ClaimedPromoState>(
            builder: (_, promoState) {
              if (promoState is LoadAllClaimedPromo) {
                if (isItBirthday) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: height * verticalMargin,
                    ),
                    child: Column(
                      children: promoState.claimedPromo.map(
                        (e) {
                          if (e.claimedPromo!.promoCategory == 'birthday') {
                            return GestureDetector(
                              onTap: () {
                                context.read<PageBloc>().add(
                                      GoToDetailPromoPage(
                                        isBirthdayPromo: true,
                                        isFromMainPage: true,
                                        isSpecialPromo: false,
                                        isClaimed: true,
                                        promo: Promo(
                                          img: e.claimedPromo!.img,
                                          provision: e.claimedPromo!.provision,
                                          promoId: e.claimedPromo!.promoId,
                                          availableCity: [],
                                          promoCategory:
                                              e.claimedPromo!.promoCategory,
                                          promoEndDate:
                                              e.claimedPromo!.promoEndDate,
                                          promoStartDate:
                                              e.claimedPromo!.promoStartDate,
                                          termCondition:
                                              e.claimedPromo!.termCondition,
                                        ),
                                        userPromoId: e.userPromoId!,
                                      ),
                                    );
                              },
                              child: BirthdayCard(),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ).toList(),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      );
    }

    Widget _buildWhatsNewCarousalSlider() {
      var widthDisplay = MediaQuery.of(context).size.width;
      final double size = .62;
      List<String> dummyStr = ['a', 'b', 'c', 'd'];

      return BlocBuilder<SpecialOfferBloc, SpecialOfferState>(
          builder: (_, offerState) {
        if (offerState is LoadOfferData) {
          return Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: widthDisplay * size,
                enlargeCenterPage: false,
                viewportFraction: size,
                aspectRatio: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: offerState.specialOfferData
                  .map(
                    (e) => Container(
                      height: widthDisplay * size,
                      width: widthDisplay * size,
                      // width: double.infinity,
                      color: ThemeColor.accentColor5,
                      child: Image.network(
                        e.imgUrl!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: widthDisplay * size,
              enlargeCenterPage: false,
              viewportFraction: size,
              aspectRatio: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
            items: dummyStr
                .map(
                  (e) => Container(
                    height: widthDisplay * size,
                    width: widthDisplay * size,
                    // width: double.infinity,
                    color: ThemeColor.accentColor5,
                  ),
                )
                .toList(),
          );
        }
      });
    }

    void _noPromoAlertBox() {
      showDialog(
        context: context,
        builder: (_) => AlertBoxWidget(
          boxTitle: 'Belum ada promo\nyang berlaku',
          onTapOneButton: () {
            Navigator.pop(context);
          },
          oneButtonText: 'Ok',
          isOneButton: true,
        ),
      );
    }

    void _onPressedPromoWidget() {
      showDialog(
        context: context,
        builder: (_) => AlertBoxWidget(
          boxTitle: 'Dapatkan promonya dengan menjadi member',
          topButtonTitle: 'Daftar',
          bottomButtonTitle: 'Batal',
          isRightCTA: true,
          onTapBottomButton: () {
            Navigator.pop(context);
          },
          onTapTopButton: () async {
            Navigator.pop(context);

            context.read<PageBloc>().add(GoToSplashPage());
          },
        ),
      );
    }

    void _onPressedPromoBtn({
      required String idMember,
      required String userCity,
    }) async {
      if (widget.isGuest!) {
        _onPressedPromoWidget();
      } else {
        print('pressed');
        setState(() {
          _isPromoBtnPressed = true;
        });

        List<ClaimedUserPromo> claimedPromos =
            await PromoService.getAllClaimedPromo(idMember: idMember);

        List<Promo> promos = await PromoService.getAllPromo(
          idMember: idMember,
          userCity: userCity,
        ).then((List<Promo> promos) {
          setState(() {
            _isPromoBtnPressed = false;
          });

          return promos;
        });

        if (promos.isEmpty && claimedPromos.isEmpty) {
          _noPromoAlertBox();
        } else {
          context.read<GetPromoNextPurchaseBloc>().add(
                GetPromoNextPurchase(widget.idMember!),
              );

          context.read<PromoBloc>().add(
                GetAllPromoList(
                  idMember: widget.idMember!,
                  userCity: widget.userCity!,
                ),
              );

          context.read<ClaimedPromoBloc>().add(
                GetAllClaimedPromo(idMember),
              );

          context.read<PageBloc>().add(
                GoToListPromoPage(idMember),
              );
        }
      }
    }

    Widget _buildPromoBTN() {
      return BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => GestureDetector(
          onTap: () => _onPressedPromoBtn(
            idMember:
                ((userState is UserLoaded) ? userState.user.idMember : '')!,
            userCity: ((userState is UserLoaded) ? userState.user.city : '')!,
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/promo_btn.png', fit: BoxFit.fitWidth),
            ),
          ),
        ),
      );
    }

    Widget _buildYottaOfTheWeek() {
      var height = MediaQuery.of(context).size.height;

      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: AutoSizeText(
                "Rasa Pilihan Yotters",
                style: accentFontBlackBold.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(height: height * verticalMarginHalf),
            BlocBuilder<YottaOfTheWeekBloc, YottaOfTheWeekState>(
                builder: (_, yottaState) {
              if (yottaState is LoadYottaOfTheWeek) {
                return Container(
                  height: height * .25,
                  child: ListView.builder(
                    itemCount: yottaState.yottaOfTheWeek.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      var yotta = yottaState.yottaOfTheWeek[index];
                      var yottaLength = yottaState.yottaOfTheWeek.length;

                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return YottaOfTheWeekModalBottom(
                                imgUrl: yotta.imgUrl,
                                name: yotta.name,
                                varian: yotta.varian,
                                priceL: '${yotta.priceL}',
                                priceR: '${yotta.priceR}',
                              );
                            },
                          );
                        },
                        child: YottaOfTheWeekCard(
                          imgUrl: yotta.imgUrl,
                          name: yotta.name,
                          varian: yotta.varian,
                          margin: EdgeInsets.only(
                            right: (index == yottaLength - 1)
                                ? defaultMargin
                                : defaultMargin / 2,
                            left: (index == 0) ? defaultMargin : 0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  height: height * .25,
                  child: ListView.builder(
                    itemCount: dummyStr.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      var yottaLength = dummyStr.length;

                      return YottaOfTheWeekCard(
                        isImg: false,
                        imgUrl: '',
                        name: '',
                        varian: '',
                        margin: EdgeInsets.only(
                          right: (index == yottaLength - 1)
                              ? defaultMargin
                              : defaultMargin / 2,
                          left: (index == 0) ? defaultMargin : 0,
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      );
    }

    Widget _buildMenuAndOutletBTN() {
      return BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () async {
                  LatLngInitialLocation firstOutlet =
                      await OutletServices.getFirstOutletOnSelectedCity(
                    'Makassar',
                  );
                  context.read<ListOutletBloc>().add(
                        GetListOutlet('Makassar'),
                      );
                  context.read<PageBloc>().add(
                        GoToOutletPage(firstOutlet, 'Makassar'),
                      );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width * .5) -
                      defaultMargin -
                      6,
                  height: (MediaQuery.of(context).size.width * .5) -
                      defaultMargin -
                      6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/outlet_btn.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(GoToMenuPage());
                  context.read<VariantListBloc>().add(GetVariantList());
                  context.read<AllMenuBloc>().add(AllMenuToInitial());
                  context.read<AllMenuBloc>().add(GetAllMenu('Tamalate'));
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width * .5) -
                      defaultMargin -
                      6,
                  height: (MediaQuery.of(context).size.width * .5) -
                      defaultMargin -
                      6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/menu_btn.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _specialPromo() {
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
                      style: accentFontBlackBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: height * verticalMarginHalf),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(
                                GoToDetailPromoPage(
                                  isBirthdayPromo: false,
                                  isFromMainPage: true,
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
                                ),
                              );
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

    Widget allBTN() {
      return Container(
        color: ThemeColor.accentColor8,
        child: Column(
          children: [
            SizedBox(height: height * verticalMargin),
            _buildPromoBTN(),
            SizedBox(height: height * verticalMarginHalf),
            _buildMenuAndOutletBTN(),
            SizedBox(height: height * verticalMargin),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  SmartRefresher(
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
                                    color: index.isEven
                                        ? Colors.red
                                        : Colors.green,
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
                        if (widget.isGuest!) GuestHeaderAskRegister(),
                        _buildWhatsNewCarousalSlider(),
                        SizedBox(height: height * verticalMargin),
                        if (!widget.isGuest!) ViewHeader(),
                        birthdayPromoWidget(),
                        SizedBox(height: height * verticalMargin),
                        allBTN(),
                        if (!widget.isGuest!) _specialPromo(),
                        SizedBox(height: height * verticalMargin),
                        _buildYottaOfTheWeek(),
                        SizedBox(height: height * verticalMargin),
                      ],
                    ),
                  ),
                  if (_isPromoBtnPressed)
                    Container(
                      color: Colors.black.withOpacity(.4),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: SpinKitRing(
                            color: ThemeColor.accentColor2,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // Widget _buildOrderCardTest(String? id, String? orderType) {
  //   var height = MediaQuery.of(context).size.height;

  //   CollectionReference _orderType = FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(id!)
  //       .collection('checkout_order');

  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _orderType.where('tipe order', isEqualTo: orderType!).snapshots(),
  //     builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return _buildButtonOrderNow();
  //       } else if (!snapshot.hasData) {
  //         return _buildButtonOrderNow();
  //       } else {
  //         return BlocBuilder<UserBloc, UserState>(
  //           builder: (_, userState) => Container(
  //             color: Colors.white,
  //             child: Column(
  //               children: [
  //                 SizedBox(height: height * verticalMarginHalf),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: defaultMargin,
  //                   ),
  //                   child: Column(
  //                       children:
  //                           snapshot.data!.docs.map((DocumentSnapshot doc) {
  //                     if (orderType == 'Delivery') {
  //                       if (doc['status'] == 'Selesai') {
  //                         context.read<HistoryOrderBloc>().add(
  //                               SetDataOrderToHistory(
  //                                 id,
  //                                 true,
  //                                 (userState is UserLoaded)
  //                                     ? userState.user
  //                                     : null,
  //                                 doc['kode order'],
  //                               ),
  //                             );

  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToInitial(),
  //                             );

  //                         context
  //                             .read<OrderTypeBloc>()
  //                             .add(OrderTypeToInitial());
  //                       }

  //                       if (doc['status'] == 'Dalam Prosas') {
  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToProcess(),
  //                             );

  //                         return CardStatusOrderOnProcess(
  //                           deliveryOutlet: doc['outlet pengantaran'],
  //                           orderType: 'Delivery',
  //                           pickupTime: '',
  //                         );
  //                       } else if (doc['status'] == 'Siap Diambil') {
  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToDone(),
  //                             );

  //                         return CardStatusOrderSucess(
  //                           deliveryOutlet: doc['outlet pengantaran'],
  //                           orderType: 'Delivery',
  //                           pickupTime: '',
  //                         );
  //                       } else {
  //                         return _buildButtonOrderNow();
  //                       }
  //                     } else if (orderType == 'Pre-Order') {
  //                       if (doc['status'] == 'Selesai') {
  //                         context.read<HistoryOrderBloc>().add(
  //                               SetDataOrderToHistory(
  //                                 id,
  //                                 false,
  //                                 (userState is UserLoaded)
  //                                     ? userState.user
  //                                     : null,
  //                                 doc['kode order'],
  //                               ),
  //                             );

  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToInitial(),
  //                             );

  //                         context
  //                             .read<OrderTypeBloc>()
  //                             .add(OrderTypeToInitial());
  //                       }

  //                       if (doc['status'] == 'Dalam Proses') {
  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToProcess(),
  //                             );

  //                         return CardStatusOrderOnProcess(
  //                           deliveryOutlet: '',
  //                           orderType: 'Pre-Order',
  //                           pickupTime: doc['waktu pickup'],
  //                         );
  //                       } else if (doc['status'] == 'Siap Diambil') {
  //                         context.read<ChangeStatusOrderBloc>().add(
  //                               SetNewStatusToDone(),
  //                             );

  //                         return CardStatusOrderSucess(
  //                           deliveryOutlet: '',
  //                           orderType: 'Pre-Order',
  //                           pickupTime: doc['waktu pickup'],
  //                         );
  //                       } else {
  //                         return _buildButtonOrderNow();
  //                       }
  //                     } else {
  //                       return _buildButtonOrderNow();
  //                     }
  //                   }).toList()),
  //                 ),
  //                 SizedBox(height: height * verticalMarginHalf),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget _buildButtonOrderNow() {
  //   var height = MediaQuery.of(context).size.height;

  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: [
  //         SizedBox(height: height * verticalMarginHalf),
  //         GlobalButton(
  //           margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
  //           title: "Pesan Sekarang, Yuk!",
  //           onTapFunc: () {
  //             // int currentHour = DateTime.now().hour;
  //             int currentHour = 17;
  //             // int currentMinute = DateTime.now().minute;
  //             // int currentMinute = 20;

  //             if (currentHour >= 20) {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => AlertBoxWidget(
  //                   isDesc: true,
  //                   desc:
  //                       'Pemesanan online hanya bisa sampai pukul 8 malam. Kamu boleh pesan lagi besok ya',
  //                   boxTitle: 'Yah, waktu online\nordernya udah lewat :(',
  //                   isOneButton: true,
  //                   isOneLine: false,
  //                   oneButtonText: 'Oke',
  //                   onTapOneButton: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               );
  //             } else if ((currentHour >= 20 && currentHour <= 23) ||
  //                 (currentHour >= 0 && currentHour <= 7)) {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => AlertBoxWidget(
  //                   isDesc: true,
  //                   desc:
  //                       'Outlet mulai beroperasi pukul 9 pagi. Tunggu sebentar lagi, ya',
  //                   boxTitle: 'Hai, kami bentar lagi buka',
  //                   isOneButton: true,
  //                   isOneLine: true,
  //                   oneButtonText: 'Oke',
  //                   onTapOneButton: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               );
  //             } else {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) {
  //                   return _buildDialogOrderBox();
  //                 },
  //               );
  //             }
  //           },
  //         ),
  //         SizedBox(height: height * verticalMarginHalf),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDialogOrderBox() {
  //   var height = MediaQuery.of(context).size.height;

  //   return BlocBuilder<UserBloc, UserState>(
  //     builder: (_, userState) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(24),
  //           color: Colors.white,
  //         ),
  //         child: ListView(
  //           shrinkWrap: true,
  //           children: [
  //             SizedBox(height: height * verticalMargin),
  //             _buildOrderButton(
  //               'assets/icon_delivery.png',
  //               'Delivery',
  //               onTapFunc: () {
  //                 Navigator.pop(context);

  //                 _onPressedDeliveryButton(
  //                   city: (userState is UserLoaded) ? userState.user.city : '',
  //                 );
  //               },
  //             ),
  //             SizedBox(height: height * verticalMargin),
  //             _buildOrderButton(
  //               'assets/icon_pre-order.png',
  //               'Pre-Order',
  //               onTapFunc: () {
  //                 Navigator.pop(context);

  //                 // _onPressedPreOrderButton(
  //                 //   city: (userState is UserLoaded) ? userState.user.city : '',
  //                 // );
  //               },
  //             ),
  //             SizedBox(height: height * verticalMargin),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildOrderButton(
  //   String assetImg,
  //   String buttonName, {
  //   Function? onTapFunc,
  // }) {
  //   var height = MediaQuery.of(context).size.height;

  //   return GestureDetector(
  //     onTap: () {
  //       if (onTapFunc != null) {
  //         onTapFunc();
  //       }
  //     },
  //     child: Container(
  //       height: height * .16,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //         color: accentColor2,
  //       ),
  //       child: Container(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //               height: height * .13,
  //               width: height * .13,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: AssetImage(assetImg),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               width: height * .13,
  //               child: AutoSizeText(
  //                 buttonName,
  //                 maxLines: 1,
  //                 style: mainFontBlackBold.copyWith(
  //                   fontSize: 22,
  //                   color: ThemeColor.mainColor,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _onPressedPreOrderButton({required String city}) async {
  //   int currentHour = DateTime.now().hour;
  //   // int currentHour = 17;
  //   // int currentMinute = DateTime.now().minute;
  //   // int currentMinute = 20;

  //   if (currentHour >= 20) {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertBoxWidget(
  //         isDesc: true,
  //         desc:
  //             'Pemesanan online hanya bisa sampai pukul 8 malam. Kamu boleh pesan lagi besok ya',
  //         boxTitle: 'Yah, waktu online\nordernya udah lewat :(',
  //         isOneButton: true,
  //         isOneLine: false,
  //         oneButtonText: 'Oke',
  //         onTapOneButton: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     );
  //   } else if ((currentHour >= 20 && currentHour <= 23) ||
  //       (currentHour >= 0 && currentHour <= 7)) {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertBoxWidget(
  //         isDesc: true,
  //         desc:
  //             'Outlet mulai beroperasi pukul 9 pagi. Tunggu sebentar lagi, ya',
  //         boxTitle: 'Hai, kami bentar lagi buka',
  //         isOneButton: true,
  //         isOneLine: true,
  //         oneButtonText: 'Oke',
  //         onTapOneButton: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     );
  //   } else {
  //     LatLngInitialLocation firstOutlet =
  //         await OutletServices.getFirstOutletOnSelectedCity(city);

  //     context.read<OrderTypeBloc>().add(PreOrder());
  //     context.read<PickupTimeBloc>().add(GetPickUpTime());
  //     context.read<PageBloc>().add(
  //           GoToSelectOutletPreorder(city, 'Pre-Order', firstOutlet),
  //         );
  //     context.read<ListOutletBloc>().add(GetListOutlet(city));
  //   }
  // }

  // // void _onPressedDeliveryButton({String? city}) async {
  // //   LatLngInitialLocation firstOutlet =
  // //       await OutletServices.getFirstOutletOnSelectedCity(city);
  // //   context.read<PageBloc>().add(GoToSetDeliveryLocationPage(firstOutlet));
  // //   context.read<OrderTypeBloc>().add(DeliveryOrder());
  // // }
// class ButtonOrder {
//   String name;
//   String imgUrl;
//   Color color;
//   String img;

//   ButtonOrder(this.name, this.imgUrl, this.color, this.img);
// }