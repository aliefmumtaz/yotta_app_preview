part of 'widgets.dart';

class ButtonBottleSize extends StatelessWidget {
  final String? size;
  final EdgeInsets? margin;
  final bool isBorder;
  final Function? onTap;

  ButtonBottleSize({
    this.isBorder = false,
    this.margin,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: margin,
        height: height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ThemeColor.mainColor),
            gradient: (!isBorder)
                ? null
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                  )),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                gradient: (!isBorder)
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                      )
                    : null,
              ),
              child: Center(
                child: AutoSizeText(
                  size!.split(' ')[0],
                  style: accentFontWhiteBold.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
              child: Text(
                size!.split(' ')[1] + '.000',
                style: accentFontBlackBold.copyWith(
                  fontSize: 18,
                  color: (!isBorder) ? ThemeColor.accentColor3 : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
