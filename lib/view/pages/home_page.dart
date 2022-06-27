part of 'pages.dart';

class HomePage extends StatefulWidget {
  final int bottomNavbarIndex;
  final String? selectedOrder;
  final String? idMember;
  final String? userCity;
  final String? userBirthday;
  final String? userID;

  HomePage(
    this.bottomNavbarIndex, {
    this.selectedOrder = 'Sedang Diproses',
    required this.idMember,
    required this.userCity,
    required this.userBirthday,
    required this.userID,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController? pageController;
  int? navbarIndex;
  String? selectedOrder;
  bool isMainPage = true;

  @override
  void initState() {
    navbarIndex = widget.bottomNavbarIndex;
    selectedOrder = widget.selectedOrder;
    if (widget.bottomNavbarIndex != 0) {
      setState(() {
        isMainPage = false;
      });
    }

    // pageController = PageController(initialPage: navbarIndex!);
    super.initState();
  }

  @override
  void dispose() {
    // pageController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<GetPromoNextPurchaseBloc>().add(GetPromoNextPurchase(widget.idMember!));

    return BlocBuilder<GuestModeBloc, GuestModeState>(
      builder: (_, guestState) {
        if (guestState is GuestMode) {
          return _homePageContent(isGuest: true);
        } else {
          return BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              DocumentReference _user = FirebaseFirestore.instance
                  .collection('user')
                  .doc((userState is UserLoaded) ? userState.user.uid : '-');

              print((userState is UserLoaded) ? 'ada' : 'tdak ada');

              return StreamBuilder(
                stream: _user.snapshots(),
                builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold();
                  } else if (!snapshot.hasData) {
                    return Scaffold();
                  } else {
                    if (snapshot.data!['isEmailVerified'] == true) {
                      return _homePageContent(isGuest: false);
                    } else {
                      return BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) => RegistrationVerificationPage(
                          uid: (userState is UserLoaded)
                              ? userState.user.uid
                              : '',
                          email: (userState is UserLoaded)
                              ? userState.user.email
                              : '',
                          idMember: (userState is UserLoaded)
                              ? userState.user.idMember
                              : '',
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _homePageContent({required bool isGuest}) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: MainPage(
        idMember: (isGuest) ? '-' : widget.idMember,
        isGuest: isGuest,
        userCity: (isGuest) ? 'Kota' : widget.userCity,
        userBirthday: (isGuest) ? '' :  widget.userBirthday,
        userID: (isGuest) ? '' : widget.userID,
      ),
    );
  }

  // Widget _homePageContent({required bool isGuest}) {
  //   return Scaffold(
  //     backgroundColor: Colors.red,
  //     body: Stack(
  //       children: [
  //         PageView(
  //           physics: NeverScrollableScrollPhysics(),
  //           controller: pageController,
  //           onPageChanged: (index) {
  //             setState(() {
  //               navbarIndex = index;
  //             });
  //           },
  //           children: [
  //             MainPage(
  //               idMember: (isGuest) ? '-' : widget.idMember,
  //               isGuest: isGuest,
  //               userCity: widget.userCity,
  //             ),
  //             // RewardPage(),
  //             CartPage(selectedOrder),
  //             AccountPage(),
  //           ],
  //         ),
  //         SafeArea(
  //           child: _buildCustomBottomNavigationBar(isGuest: isGuest),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildCustomBottomNavigationBar({required bool isGuest}) {
  //   var displayHeight = MediaQuery.of(context).size.height;

  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(
  //         horizontal: defaultMargin,
  //         vertical: displayHeight * verticalMarginHalf,
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(24),
  //         boxShadow: [
  //           BoxShadow(
  //             offset: Offset(2, 4),
  //             blurRadius: 20,
  //             color: Colors.black.withOpacity(0.1),
  //           ),
  //         ],
  //       ),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: defaultMargin / 2,
  //         vertical: displayHeight * verticalMarginHalf,
  //       ),
  //       child: BottomNavigationBar(
  //         selectedLabelStyle: accentFontBlackBold.copyWith(
  //           fontSize: 12,
  //         ),
  //         unselectedLabelStyle: accentFontBlackRegular.copyWith(
  //           fontSize: 12,
  //           color: mainColor,
  //         ),
  //         type: BottomNavigationBarType.fixed,
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         selectedItemColor: mainColor,
  //         unselectedItemColor: accentColor4,
  //         currentIndex: navbarIndex!,
  //         onTap: (index) {
  //           if (isGuest) {
  //             if (index == 0) {
  //               context.read<SpecialOfferBloc>().add(
  //                     GetSpecialOfferData(),
  //                   );
  //               context.read<YottaOfTheWeekBloc>().add(GetYottaOfTheWeek());

  //               setState(() {
  //                 isMainPage = true;
  //               });
  //             }

  //             if (index == 0 || index == 1 || index == 2) {
  //               setState(() {
  //                 selectedOrder = 'Sedang Diproses';
  //               });
  //             }

  //             if (index != 0) {
  //               setState(() {
  //                 isMainPage = false;
  //               });
  //             }
  //             setState(() {
  //               navbarIndex = index;
  //               pageController!.jumpToPage(index);
  //             });
  //           } else {
  //             setState(() {
  //               context.read<StatusOrderBloc>().add(SetOnGoingOrder());

  //               navbarIndex = index;
  //               pageController!.jumpToPage(index);
  //             });

  //             if (index == 0) {
  //               context.read<SpecialOfferBloc>().add(
  //                     GetSpecialOfferData(),
  //                   );
  //               context.read<YottaOfTheWeekBloc>().add(GetYottaOfTheWeek());

  //               setState(() {
  //                 isMainPage = true;
  //               });
  //             }

  //             if (index == 0 || index == 2) {
  //               context
  //                   .read<UserPointBloc>()
  //                   .add(GetUserPoint(widget.idMember));
  //             }

  //             if (index == 0 || index == 1 || index == 2) {
  //               setState(() {
  //                 selectedOrder = 'Sedang Diproses';
  //               });
  //             }

  //             if (index != 0) {
  //               setState(() {
  //                 isMainPage = false;
  //               });
  //             }
  //           }
  //         },
  //         items: [
  //           BottomNavigationBarItem(
  //             icon: Container(
  //               margin: EdgeInsets.only(bottom: 6),
  //               height: MediaQuery.of(context).size.height * .035,
  //               width: MediaQuery.of(context).size.height * .035,
  //               child: Image.asset(
  //                 (navbarIndex == 0)
  //                     ? 'assets/icon_home_active.png'
  //                     : 'assets/icon_home_inactive.png',
  //               ),
  //             ),
  //             label: 'Beranda',
  //           ),
  //           // BottomNavigationBarItem(
  //           //   icon: Container(
  //           //     margin: EdgeInsets.only(bottom: 6),
  //           //     height: MediaQuery.of(context).size.height * .035,
  //           //     width: MediaQuery.of(context).size.height * .035,
  //           //     child: Image.asset(
  //           //       (navbarIndex == 1)
  //           //           ? 'assets/icon_reward_active.png'
  //           //           : 'assets/icon_reward_inactive.png',
  //           //     ),
  //           //   ),
  //           //   label: 'Reward',
  //           // ),
  //           BottomNavigationBarItem(
  //             icon: Container(
  //               margin: EdgeInsets.only(bottom: 6),
  //               height: MediaQuery.of(context).size.height * .035,
  //               width: MediaQuery.of(context).size.height * .035,
  //               child: Image.asset(
  //                 (navbarIndex == 1)
  //                     ? 'assets/icon_cart_active.png'
  //                     : 'assets/icon_cart_inactive.png',
  //               ),
  //             ),
  //             label: 'Keranjang',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Container(
  //               margin: EdgeInsets.only(bottom: 6),
  //               height: MediaQuery.of(context).size.height * .035,
  //               width: MediaQuery.of(context).size.height * .035,
  //               child: Image.asset(
  //                 (navbarIndex == 2)
  //                     ? 'assets/icon_account_active.png'
  //                     : 'assets/icon_account_inactive.png',
  //               ),
  //             ),
  //             label: 'Profil',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
