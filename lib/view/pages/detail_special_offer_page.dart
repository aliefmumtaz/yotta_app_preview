part of 'pages.dart';

class DetailSpecialOfferPage extends StatefulWidget {
  final DetailSpecialOffer detailSpecialOffer;

  DetailSpecialOfferPage({required this.detailSpecialOffer});

  @override
  _DetailSpecialOfferPageState createState() => _DetailSpecialOfferPageState();
}

class _DetailSpecialOfferPageState extends State<DetailSpecialOfferPage> {
  String desc = '';

  @override
  void initState() {
    desc = widget.detailSpecialOffer.desc!.replaceAll("\\n", "\n");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: CustomBehavior(),
              child: ListView(
                children: [
                  SizedBox(height: height * .5),
                  SizedBox(height: height * verticalMargin),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: AutoSizeText(
                      desc,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: height *
                          ((verticalMargin * 2) + verticalMarginHalf + 0.06)),
                ],
              ),
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: height * verticalMarginHalf),
                      GlobalButton(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        title: 'Kembali',
                        onTapFunc: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: height * verticalMargin),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: height * .5,
                  width: double.infinity,
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.detailSpecialOffer.imgUrl!,
                    child: Image.network(
                      widget.detailSpecialOffer.imgUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: height * .04,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.0)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
