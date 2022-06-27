part of 'widgets.dart';

class ButtonAddToCart extends StatelessWidget {
  final int? total;
  final Function? onTap;

  ButtonAddToCart({this.total, this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 10),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: defaultMargin / 2),
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
              height: height * 0.08,
              width: width * .4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                ),
              ),
              child: Center(
                child: Text(
                  'Tambahkan',
                  style: mainFontWhiteBold.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
