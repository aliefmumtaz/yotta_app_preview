part of 'widgets.dart';

class GuestModeHomePage extends StatefulWidget {
  final PageController? pageController;
  final int? navBarIndex;
  final String? selectedOrder;

  GuestModeHomePage({
    required this.pageController,
    required this.navBarIndex,
    required this.selectedOrder,
  });

  @override
  _GuestModeHomePageState createState() => _GuestModeHomePageState();
}

class _GuestModeHomePageState extends State<GuestModeHomePage> {
  int? navbarIndex;
  String? selectedOrder;

  @override
  void initState() {
    selectedOrder = widget.selectedOrder;
    navbarIndex = widget.navBarIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.whiteBackColor,
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: widget.pageController,
            onPageChanged: (index) {
              setState(() {
                navbarIndex = index;
              });
            },
            children: [
              MainPage(
                idMember: '0',
                isGuest: true,
                userCity: 'Makassar',
                userBirthday: '',
                userID: '',
              ),
              // RewardPage(),
              CartPage(selectedOrder),
              AccountPage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.all(defaultMargin / 2),
        child: BottomNavigationBar(
          selectedLabelStyle: accentFontBlackBold.copyWith(
            fontSize: 12,
          ),
          unselectedLabelStyle: accentFontBlackRegular.copyWith(
            fontSize: 12,
            color: ThemeColor.mainColor,
          ),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: ThemeColor.mainColor,
          unselectedItemColor: ThemeColor.accentColor4,
          currentIndex: navbarIndex!,
          onTap: (index) {
            setState(() {
              context.read<StatusOrderBloc>().add(SetOnGoingOrder());

              navbarIndex = index;
              widget.pageController!.jumpToPage(index);
            });

            if (index == 0) {
              context.read<SpecialOfferBloc>().add(GetSpecialOfferData());
              context.read<YottaOfTheWeekBloc>().add(GetYottaOfTheWeek());
            }

            if (index == 0 || index == 1 || index == 2) {
              setState(() {
                selectedOrder = 'Sedang Diproses';
              });
            }
          },






          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.height * .035,
                child: Image.asset(
                  (navbarIndex == 0)
                      ? 'assets/icon_home_active.png'
                      : 'assets/icon_home_inactive.png',
                ),
              ),
              label: 'Beranda',
            ),
            // BottomNavigationBarItem(
            //   icon: Container(
            //     margin: EdgeInsets.only(bottom: 6),
            //     height: MediaQuery.of(context).size.height * .035,
            //     width: MediaQuery.of(context).size.height * .035,
            //     child: Image.asset(
            //       (navbarIndex == 1)
            //           ? 'assets/icon_reward_active.png'
            //           : 'assets/icon_reward_inactive.png',
            //     ),
            //   ),
            //   label: 'Reward',
            // ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.height * .035,
                child: Image.asset(
                  (navbarIndex == 1)
                      ? 'assets/icon_cart_active.png'
                      : 'assets/icon_cart_inactive.png',
                ),
              ),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.height * .035,
                child: Image.asset(
                  (navbarIndex == 2)
                      ? 'assets/icon_account_active.png'
                      : 'assets/icon_account_inactive.png',
                ),
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
