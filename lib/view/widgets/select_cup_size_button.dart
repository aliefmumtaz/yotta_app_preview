part of 'widgets.dart';

class ButtonCupSize extends StatelessWidget {
  final String size;
  final EdgeInsets? margin;
  final bool isBorder;
  final Function? onTap;

  ButtonCupSize({
    this.isBorder = false,
    this.margin,
    this.onTap,
    this.size = 'R',
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: margin,
        height: height * 0.07,
        width: width * (.5 - horizontalMargin * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ThemeColor.mainColor),
          gradient: (!isBorder)
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              size.split(' ')[0],
              style: accentFontBlackBold.copyWith(
                fontSize: 24,
                color: (!isBorder) ? ThemeColor.mainColor : Colors.white,
              ),
            ),
            SizedBox(width: width * horizontalMarginHalf),
            Text(
              size.split(' ')[1] + '.000',
              style: accentFontBlackRegular.copyWith(
                fontSize: 18,
                color: (!isBorder) ? ThemeColor.accentColor3 : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
