part of 'widgets.dart';

class ViewHeader extends StatefulWidget {
  const ViewHeader({Key? key}) : super(key: key);

  @override
  _ViewHeaderState createState() => _ViewHeaderState();
}

class _ViewHeaderState extends State<ViewHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPointBloc, UserPointState>(
      builder: (_, pointState) =>
          BlocBuilder<GuestModeBloc, GuestModeState>(builder: (_, guestState) {
        if (guestState is GuestMode) {
          return HeaderGuestMode(point: '-');
        } else {
          return Header(
            point: (pointState is LoadUserPoint) ? '${pointState.point}' : '0',
          );
        }
      }),
    );
  }
}

class Header extends StatefulWidget {
  final String point;

  Header({required this.point});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Future<Response> sendNotification({
    required List<String> tokenId,
    required String contents,
    required String heading,
  }) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id": oneSignalAppId,
        "include_player_ids": tokenId,
        "android_accent_color": "FF9976D2",
        // "small_icon": "ic_stat_onesignal_default",
        "large_icon":
            "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png",
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    (userState is UserLoaded)
                        ? 'Hai, ${userState.user.nickName}'
                        : '',
                    maxLines: 1,
                    maxFontSize: 24,
                    style: mainFontWhiteBold.copyWith(
                      fontSize: 24,
                      color: ThemeColor.mainColor,
                    ),
                  ),
                  SizedBox(
                    height: height * verticalMarginHalf / 4,
                  ),
                  Row(
                    children: [
                      PoinCircleYellowForHeader('Y-Poin'),
                      SizedBox(width: height * horizontalMarginHalf / 2),
                      AutoSizeText(
                        widget.point,
                        maxLines: 1,
                        maxFontSize: 24,
                        style: mainFontWhiteBold.copyWith(
                          fontSize: 20,
                          color: ThemeColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<PageBloc>().add(GoToAccountPage());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .033,
                            width: MediaQuery.of(context).size.height * .033,
                            child: Image.asset(
                              'assets/icon_account_active.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(height: height * verticalMarginHalf / 2),
                          AutoSizeText(
                            'Profil',
                            style: accentFontWhiteRegular.copyWith(
                              fontSize: 12,
                              color: ThemeColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderGuestMode extends StatefulWidget {
  final String point;

  HeaderGuestMode({required this.point});

  @override
  _HeaderGuestModeState createState() => _HeaderGuestModeState();
}

class _HeaderGuestModeState extends State<HeaderGuestMode> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * verticalMarginHalf,
                      ),
                      AutoSizeText(
                        'Guest',
                        maxLines: 1,
                        maxFontSize: 24,
                        style: mainFontWhiteBold.copyWith(
                          fontSize: 24,
                          color: ThemeColor.mainColor,
                        ),
                      ),
                      SizedBox(
                        height: height * verticalMarginHalf / 4,
                      ),
                      Row(
                        children: [
                          PoinCircleYellowForHeader('Y-Poin'),
                          SizedBox(width: height * horizontalMarginHalf / 2),
                          AutoSizeText(
                            '0',
                            maxLines: 1,
                            maxFontSize: 24,
                            style: mainFontWhiteBold.copyWith(
                              fontSize: 20,
                              color: ThemeColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * verticalMarginHalf,
                      ),
                    ],
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
