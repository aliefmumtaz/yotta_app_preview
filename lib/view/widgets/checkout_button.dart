part of 'widgets.dart';

class CheckoutButton extends StatelessWidget {
  final int? total;
  final Function? onTap;

  CheckoutButton({this.total, this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var heightWidget = height * (verticalMargin + textFieldHeight);

    return Column(
      children: [
        Spacer(),
        Container(
          height: 1.5,
          color: ThemeColor.whiteBackColor,
          width: double.infinity,
        ),
        Container(
          height: heightWidget,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: defaultMargin),
                height: heightWidget,
                width: width * .38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Total',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 12,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    (total == 0)
                        ? AutoSizeText(
                            '0',
                            style: mainFontBlackBold.copyWith(
                              fontSize: 24,
                              color: ThemeColor.accentColor3,
                            ),
                          )
                        : AutoSizeText(
                            '$total.000',
                            maxLines: 1,
                            style: mainFontBlackBold.copyWith(
                              fontSize: 24,
                              color: ThemeColor.accentColor3,
                            ),
                          ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                  height: heightWidget,
                  width: width * .5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                    ),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(24)),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      'Checkout',
                      style: mainFontWhiteBold.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
