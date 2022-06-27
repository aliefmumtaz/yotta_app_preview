part of 'pages.dart';

PageEvent? prevPageEvent;

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isVisible = true;
  Timer? timer;

  @override
  void initState() {
    Future?.delayed(Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // auth.User? firebaseUser = Provider.of<auth.User>(context);

    bool isCheckout = false;
    String isOrderType = 'No data';
    String orderStatus = '';

    auth.FirebaseAuth.instance.authStateChanges().listen(
      (auth.User? user) async {
        if (user == null) {
          // if (!(prevPageEvent is GoToHomePage)) {
            // BlocProvider.of<ListCityForRegistrationBloc>(context)
            //     .add(GetCityList());
            // context.read<GuestModeBloc>().add(SetGuestModeToInitial());

            prevPageEvent = GoToHomePage(0);
            // BlocProvider.of<PageBloc>(context).add(prevPageEvent!);
            context.read<GuestModeBloc>().add(SetGuestMode());
            context
                .read<ClaimedPromoBloc>()
                .add(GetAllClaimedPromo('testinguser1234'));

            context.read<PromoBloc>().add(
                  GetAllPromoList(
                    idMember: 'testing123',
                    userCity: 'Makassar',
                  ),
                );
            context.read<MenuBloc>().add(MenuToInitial());
            context.read<ListCityForRegistrationBloc>().add(GetCityList());
            context.read<SpecialOfferBloc>().add(GetSpecialOfferData());
            context.read<YottaOfTheWeekBloc>().add(GetYottaOfTheWeek());
            context.read<PageBloc>().add(prevPageEvent!);
          // }
        } else {
          // if (!(prevPageEvent is GoToHomePage)) {
            // _checkoutStatus(user.uid);
            // checking process
            // bool cekCheckout = await CheckoutOrderService.isCheckouted(
            //   user.uid,
            // );

            // String isType = await CheckoutOrderService.orderTypeCheck(
            //   user.uid,
            // );

            // String statusCheck = await CheckoutOrderService.orderStatusCheck(
            //   user.uid,
            // );

            // setState(() {
            //   isCheckout = cekCheckout;
            //   isOrderType = isType;
            //   orderStatus = statusCheck;
            // });

            // if (isCheckout == true) {
            //   print('ada checkout');
            //   // preOrder
            //   if (isOrderType == 'Pre-Order') {
            //     context.read<OrderTypeBloc>().add(PreOrder());
            //     if (orderStatus == 'Dalam Proses') {
            //       context.read<ChangeStatusOrderBloc>().add(
            //             SetNewStatusToProcess(),
            //           );
            //     } else if (orderStatus == 'Siap Diambil') {
            //       context.read<ChangeStatusOrderBloc>().add(
            //             SetNewStatusToDone(),
            //           );
            //     }
            //     // Delivery
            //   } else if (isOrderType == 'Delivery') {
            //     context.read<OrderTypeBloc>().add(DeliveryOrder());
            //     if (orderStatus == 'Dalam Proses') {
            //       context
            //           .read<ChangeStatusOrderBloc>()
            //           .add(SetNewStatusToProcess());
            //       context.read<CheckoutSelectedOutletLatlngBloc>().add(
            //             GetSelectedOutletLatLng(user.uid),
            //           );
            //     } else if (orderStatus == 'Siap Diambil') {
            //       context
            //           .read<ChangeStatusOrderBloc>()
            //           .add(SetNewStatusToDone());
            //       context.read<CheckoutSelectedOutletLatlngBloc>().add(
            //             GetSelectedOutletLatLng(user.uid),
            //           );
            //     }
            //   }
            // } else {
            //   print('tidak ada checkout');
            //   context.read<ChangeStatusOrderBloc>().add(
            //         SetNewStatusToInitial(),
            //       );
            //   context.read<OrderTypeBloc>().add(OrderTypeToInitial());
            // }
            context.read<UserBloc>().add(LoadUser(user.uid));
            context.read<MenuBloc>().add(MenuToInitial());
            context.read<ListCityForRegistrationBloc>().add(GetCityList());
            context.read<SpecialOfferBloc>().add(GetSpecialOfferData());
            context.read<YottaOfTheWeekBloc>().add(GetYottaOfTheWeek());
            context.read<VariantListBloc>().add(GetVariantList());
            context.read<ToppingBloc>().add(GetToppingData());
            context.read<SugarTypeBloc>().add(GetSugarTypeData());
            context.read<IceTypeBloc>().add(GetIceTypeData());
            context.read<GuestModeBloc>().add(SetGuestModeToInitial());
            context.read<ListOrderCartColdBloc>().add(
                  DeleteListOrderCartColdDrink(user.uid),
                );
            // context.read<PromoBloc>().add(
            //       GetAllPromoList(idMember: user.uid, userCity: 'Makassar'),
            //     );
            // context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(user.uid));
            print('creation time = ' + '${user.metadata.creationTime}');
            context.read<DateCreationBloc>().add(
                  GetDateCreation('${user.metadata.creationTime}'),
                );
            // prevPageEvent = GoToHomePage(0);
            context.read<PageBloc>().add(GoToHomePage(0));
          }
        // }
      },
    );

    return Stack(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => BlocBuilder<PageBloc, PageState>(
            builder: (_, pageState) {
              if (pageState is OnSplashPage) {
                return SplashPage();
              } else if (pageState is OnLoginPage) {
                return LoginPage();
              } else if (pageState is OnVerificationPage) {
                return VerificationPage(pageState.phoneNumber);
              } else if (pageState is OnChooseMemberStatusPage) {
                return ChooseMemberStatusPage();
              } else if (pageState is OnRegistrationPage) {
                return RegistrationPage(
                  pageState.registrationData,
                  pageState.registeredMemberData,
                  pageState.isIdRegistered,
                );
              } else if (pageState is OnInputMemberIdPage) {
                return InputMemberIdPage(pageState.registrationData);
              } else if (pageState is OnSelectMenuPage) {
                return SelectMenuPage(
                  pageState.selectedVariant,
                  pageState.selectedProductStyle,
                  preOrderData: pageState.preOrderData,
                  deliveryOrderData: pageState.deliveryOrderData,
                );
              } else if (pageState is OnSelectDetailOrderCup) {
                return SelectDetailOrderCupPage(
                  pageState.choosenColdMenu,
                  pageState.price,
                  pageState.drinkType,
                  pageState.selectedVariant,
                  pageState.selectedProductStyle,
                  preOrderData: pageState.preOrderData,
                  deliveryOrderData: pageState.deliveryOrderData,
                  imgUrl: pageState.imgUrl,
                );
              } else if (pageState is OnSelectDetailOrderBottle) {
                return SelectDetailOrderBottlePage(
                  pageState.choosenBottleMenu,
                  pageState.price,
                  pageState.drinkType,
                  pageState.selectedVariant,
                  pageState.selectedProductStyle,
                  preOrderData: pageState.preOrderData,
                  deliveryOrderData: pageState.deliveryOrderData,
                );
              } else if (pageState is OnSelectDetailOrderHot) {
                return SelectDetailOrderHotPage(
                  pageState.choosenHotMenu,
                  pageState.drinkType,
                  pageState.price,
                  pageState.selectedVariant,
                  pageState.selectedProductStyle,
                  preOrderData: pageState.preOrderData,
                  deliveryOrderData: pageState.deliveryOrderData,
                );
              } else if (pageState is OnSelectOutletPreOrder) {
                return SelectOutletPreOrder(
                  pageState.selectedCity,
                  pageState.orderType,
                  pageState.latLngInitialLocation,
                );
              } else if (pageState is OnCartDetailPage) {
                return CartDetailOrderPage(
                  pageState.selectedVariant,
                  pageState.selectedProductStyle,
                  preOrderData: pageState.preOrderData,
                  deliveryOrderData: pageState.deliveryOrderData,
                );
              } else if (pageState is OnSuccessCheckoutPage) {
                return SuccessCheckoutPage();
              } else if (pageState is OnCartCheckoutPage) {
                return CartCheckoutPage(pageState.pageEvent);
              } else if (pageState is OnHomePage) {
                return HomePage(
                  pageState.index,
                  selectedOrder: pageState.selectedOrder,
                  idMember:
                      (userState is UserLoaded) ? userState.user.idMember : '',
                  userCity:
                      (userState is UserLoaded) ? userState.user.city : '',
                  userBirthday:
                      (userState is UserLoaded) ? userState.user.birthday : '',
                  userID:(userState is UserLoaded) ? userState.user.uid : '',
                );
              } else if (pageState is OnHistoryOrderDetailPage) {
                return HistoryOrderDetailPage(
                  pageState.orderType,
                  detailHistoryOrderDeliveryType:
                      pageState.detailHistoryOrderDeliveryType,
                  detailHistoryOrderType: pageState.detailHistoryOrderType,
                );
              } else if (pageState is OnEditProfilePage) {
                return EditProfilePage(
                  name: pageState.name,
                  nickName: pageState.nickName,
                  email: pageState.email,
                  city: pageState.city,
                  selectedDate: pageState.date,
                  phoneNumber: pageState.phoneNumber,
                );
              // } else if (pageState is OnSetDeliveryLocationPage) {
              //   return SetDeliveryLocationPage(pageState.latLngInitialLocation);
              } else if (pageState is OnOutletPage) {
                return OutletPage(
                  pageState.latLngInitialLocation,
                  pageState.selectedCity,
                );
              } else if (pageState is OnMenuPage) {
                return MenuPage();
              } else if (pageState is OnContactUsPage) {
                return ContactUsPage();
              } else if (pageState is OnCartCheckoutDeliveryPage) {
                return CartCheckoutDeliveryPage(
                  outletLatLng: pageState.outletLatLng,
                  userLoc: pageState.userLoc,
                  pageEvent: pageState.pageEvent,
                );
              } else if (pageState is OnDetailSpecialOfferPage) {
                return DetailSpecialOfferPage(
                  detailSpecialOffer: pageState.detailSpecialOffer,
                );
              } else if (pageState is OnListPromoPage) {
                return ListPromoPage(
                  idMember: pageState.idMember,
                  userCity:
                      ((userState is UserLoaded) ? userState.user.city : '')!,
                );
              } else if (pageState is OnDetailPromoPage) {
                return DetailPromoPage(
                  isClaimed: pageState.isClaimed,
                  promo: pageState.promo,
                  userPromoId: pageState.userPromoId,
                  isSpecialPromo: pageState.isSpecialPromo,
                  isFromMainPage: pageState.isFromMainPage,
                  isBirthdayPromo: pageState.isBirthdayPromo,
                );
              } else if (pageState is OnAccountPage) {
                return AccountPage();
              } else {
                return Scaffold();
              }
            },
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: LoadingWelcomePage(),
        ),
      ],
    );
  }
}

class LoadingWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width * .7,
                child:
                    Image.asset('assets/semangatyo.png', fit: BoxFit.fitWidth),
              ),
              Column(
                children: [
                  Text(
                    'Yotta Indonesia App. Version $appVersion',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        (verticalMargin * 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
