part of 'widgets.dart';

class CupPlaceholder extends StatefulWidget {
  final String? name;
  final int amount;
  final Function? addAmount;
  final Function? removeAmount;
  final String? imgUrl;

  CupPlaceholder({
    this.name = '',
    this.amount = 0,
    this.addAmount,
    this.removeAmount,
    this.imgUrl,
  });

  @override
  _CupPlaceholderState createState() => _CupPlaceholderState();
}

class _CupPlaceholderState extends State<CupPlaceholder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .22,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * .18,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.accentColor3, ThemeColor.accentColor2],
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 22),
                        width: width * .4,
                        height: height * .075,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            widget.name!,
                            maxLines: 2,
                            style: mainFontBlackBold.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * verticalMarginHalf,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: defaultMargin),
                        child: ButtonAddAmount(
                          addAmount: widget.addAmount,
                          removeAmount: widget.removeAmount,
                          amount: widget.amount,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * .3,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 0,
            child: Container(
              height: height * .24,
              width: width * .4,
              child: Image.network(widget.imgUrl!, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
