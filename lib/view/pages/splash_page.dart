part of 'pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    PreferredSize header() {
      return PreferredSize(
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ThemeColor.blackTextColor,
                  size: 18,
                ),
                onPressed: () => context.read<PageBloc>().add(GoToHomePage(0)),
              ),
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(50),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToHomePage(0));

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  height: MediaQuery.of(context).size.height * .45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splash_screen.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Selamat datang di yotta!',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: mainFontBlackBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: height * verticalMarginHalf / 2),
                      AutoSizeText(
                        'Dapatkan berbagai penawaran menarik melalui aplikasi Yotta! kamu bisa menikmati Yotta dimana saja, kapan saja, tanpa antri',
                        textAlign: TextAlign.center,
                        minFontSize: 6,
                        maxLines: 3,
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 14,
                          color: ThemeColor.accentColor4,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GlobalButton(
                      title: 'Masuk',
                      onTapFunc: () async {
                        context.read<PageBloc>().add(GoToLoginPage());
                        ;
                      },
                    ),
                    SizedBox(height: height * verticalMargin),
                    GlobalButton(
                      title: 'Daftar',
                      isBorder: false,
                      onTapFunc: () async {
                        context
                            .read<ListCityForRegistrationBloc>()
                            .add(GetCityList());

                        context.read<PageBloc>().add(
                              GoToRegistrationPage(
                                RegistrationData(),
                                DataForRegisteredIdMember(),
                                false,
                              ),
                            );
                      },
                    ),
                    SizedBox(height: height * verticalMargin),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.read<GuestModeBloc>().add(SetGuestMode());
                    //     context
                    //         .read<ClaimedPromoBloc>()
                    //         .add(GetAllClaimedPromo('testinguser1234'));

                    //     context.read<PromoBloc>().add(
                    //           GetAllPromoList(
                    //             idMember: 'testing123',
                    //             userCity: 'Makassar',
                    //           ),
                    //         );
                    //     context.read<MenuBloc>().add(MenuToInitial());
                    //     context
                    //         .read<ListCityForRegistrationBloc>()
                    //         .add(GetCityList());
                    //     context
                    //         .read<SpecialOfferBloc>()
                    //         .add(GetSpecialOfferData());
                    //     context
                    //         .read<YottaOfTheWeekBloc>()
                    //         .add(GetYottaOfTheWeek());
                    //     context.read<PageBloc>().add(GoToHomePage(0));
                    //   },
                    //   child: AutoSizeText(
                    //     'Masuk sebagai tamu',
                    //     style: accentFontBlackRegular.copyWith(
                    //       color: mainColor,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: height * buttonBottomMargin,
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
}
