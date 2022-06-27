part of 'pages.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _backPrevPage() async {
      context.read<PageBloc>().add(GoToHomePage(2));
    }

    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        _backPrevPage();

        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWidget(
                  name: 'Hubungi Kami',
                  onTapFunc: () async => _backPrevPage(),
                ),
                SizedBox(height: height * verticalMargin),
                Container(
                  height: height * .3,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/contact_us.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: height * verticalMargin),
                AutoSizeText(
                  'Admin Yotta (MinYo)',
                  style: mainFontBlackBold.copyWith(fontSize: 22),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  '0853-8683-2015',
                  style: mainFontBlackBold.copyWith(
                    fontSize: 28,
                    color: ThemeColor.mainColor,
                  ),
                ),
                SizedBox(height: height * verticalMargin),
                AutoSizeText(
                  'Instagram',
                  style: mainFontBlackBold.copyWith(fontSize: 22),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  '@yotta_id',
                  style: mainFontBlackBold.copyWith(
                    fontSize: 28,
                    color: ThemeColor.mainColor,
                  ),
                ),
                SizedBox(height: height * verticalMargin),
                AutoSizeText(
                  'Email',
                  style: mainFontBlackBold.copyWith(fontSize: 22),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  'cs@yotta.co.id',
                  style: mainFontBlackBold.copyWith(
                    fontSize: 28,
                    color: ThemeColor.mainColor,
                  ),
                ),
                SizedBox(height: height * verticalMargin),
                AutoSizeText(
                  'Website',
                  style: mainFontBlackBold.copyWith(fontSize: 22),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  'www.yotta.co.id',
                  style: mainFontBlackBold.copyWith(
                    fontSize: 28,
                    color: ThemeColor.mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
