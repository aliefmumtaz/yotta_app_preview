part of 'pages.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Widget _buildAppBar() {
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height * .06,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.read<PageBloc>().add(GoToHomePage(0)),
            child: Icon(Icons.arrow_back_ios, size: 20, color: ThemeColor.blackTextColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * horizontalMarginHalf,
          ),
          AutoSizeText(
            'Profil',
            style: mainFontBlackRegular.copyWith(
              fontSize: 16,
              color: ThemeColor.blackTextColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToHomePage(0));

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _contentWidget(),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _backBTN(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfoWidget({
    required String? name,
    required String? idMember,
    required String? phoneNumber,
    required int? userPoint,
    required String? validUntil,
    required String? email,
  }) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          name!,
          style: mainFontBlackBold.copyWith(
            fontSize: 24,
          ),
        ),
        AutoSizeText(
          email!,
          style: accentFontBlackRegular.copyWith(
            fontSize: 12,
          ),
        ),
        SizedBox(height: height * verticalMargin),
        AutoSizeText(
          'Poin: $userPoint',
          style: mainFontBlackBold.copyWith(
            fontSize: 24,
          ),
        ),
        AutoSizeText(
          'Exp: $validUntil',
          style: accentFontBlackRegular.copyWith(
            fontSize: 12,
          ),
        ),
        SizedBox(height: height * verticalMargin),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: defaultMargin / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: .5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'ID Member',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  AutoSizeText(
                    idMember!,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'No. HandPhone',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  AutoSizeText(
                    phoneNumber!,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contentWidget() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              SizedBox(height: height * verticalMargin),
              BlocBuilder<DateCreationBloc, DateCreationState>(
                builder: (_, creationState) =>
                    BlocBuilder<UserPointBloc, UserPointState>(
                  builder: (_, userPoint) =>
                      BlocBuilder<GuestModeBloc, GuestModeState>(
                    builder: (_, guestMode) => (guestMode is GuestMode)
                        ? CardMember(
                            idMember: '-',
                            name: 'Guest',
                            phoneNumber: '-',
                            yPoin: 0,
                          )
                        : _userInfoWidget(
                            email: (userState is UserLoaded)
                                ? userState.user.email
                                : '',
                            idMember: (userState is UserLoaded)
                                ? userState.user.idMember
                                : '',
                            name: (userState is UserLoaded)
                                ? userState.user.name
                                : '',
                            phoneNumber: (userState is UserLoaded)
                                ? userState.user.phoneNumber
                                : '',
                            userPoint: (userPoint is LoadUserPoint)
                                ? userPoint.point
                                : 0,
                            validUntil: (creationState is LoadDateCreation)
                                ? creationState.validUntil
                                : '',
                          ),
                  ),
                ),
              ),
              SizedBox(height: height * (verticalMargin * 2)),
              BlocBuilder<GuestModeBloc, GuestModeState>(
                builder: (_, guestModeState) =>
                    BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) => (guestModeState is GuestMode)
                      ? SizedBox()
                      : Column(
                          children: [
                            _buildLineSpacer(),
                            _buildOption(
                              'Edit Profil',
                              onTap: () async {
                                _onPressedEditProfile(
                                  (userState is UserLoaded)
                                      ? userState.user.name
                                      : '',
                                  (userState is UserLoaded)
                                      ? userState.user.nickName
                                      : '',
                                  (userState is UserLoaded)
                                      ? userState.user.email
                                      : '',
                                  (userState is UserLoaded)
                                      ? userState.user.city
                                      : '',
                                  (userState is UserLoaded)
                                      ? userState.user.birthday
                                      : '',
                                  (userState is UserLoaded)
                                      ? userState.user.phoneNumber
                                      : '',
                                );
                              },
                            ),
                            _buildLineSpacer(),
                          ],
                        ),
                ),
              ),
              _buildOption(
                'Hubungi Kami',
                onTap: () async {
                  context.read<PageBloc>().add(GoToContactUsPage());
                },
              ),
              // _buildOption('Syarat dan Ketentuan'),
              _buildLineSpacer(),
              SizedBox(height: height * (verticalMargin * 2)),
              _logoutBTN(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutBTN() {
    return BlocBuilder<GuestModeBloc, GuestModeState>(
      builder: (_, guestState) => GestureDetector(
        onTap: () async {
          if (guestState is GuestMode) {
            context.read<PageBloc>().add(
                  GoToSplashPage(),
                );
          } else {
            _logoutOnPressed();
          }
        },
        child: AutoSizeText(
          (guestState is GuestMode) ? 'Daftar Sekarang!' : 'Logout',
          style: accentFontBlackBold.copyWith(
            fontSize: 18,
            color: ThemeColor.accentColor3,
          ),
        ),
      ),
    );
  }

  Widget _backBTN() {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        context.read<PageBloc>().add(GoToHomePage(0));
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: defaultMargin
        ),
        height: height * 0.06,
        width: height * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColor.mainColor,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String name, {Function? onTap}) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        children: [
          SizedBox(height: height * verticalMarginHalf),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                name,
                style: accentFontBlackBold.copyWith(
                  fontSize: 18,
                  color: ThemeColor.mainColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ThemeColor.blackTextColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: height * verticalMarginHalf),
        ],
      ),
    );
  }

  void _onPressedEditProfile(
    String? name,
    String? nickName,
    String? email,
    String? city,
    String? date,
    String? phoneNumber,
  ) async {
    context.read<PageBloc>().add(
          GoToEditProfilePage(
            name: name,
            nickName: nickName,
            email: email,
            city: city,
            date: date,
            phoneNumber: phoneNumber,
          ),
        );
  }

  Widget _buildLineSpacer() {
    return Container(
      child: Divider(
        color: Colors.black,
      ),
    );
  }

  void _logoutOnPressed() {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Yakin ingin keluar?',
        isRightCTA: true,
        onTapBottomButton: () {
          Navigator.pop(context);
        },
        onTapTopButton: () async {
          Navigator.pop(context);
          await AuthServices.signOut();
          context.read<UserBloc>().add(SignOut());
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
            context.read<PageBloc>().add(GoToHomePage(0));
        },
      ),
    );
  }
}
