part of 'widgets.dart';

class ButtonMenuFilter extends StatelessWidget {
  final bool isBorder;
  final String? title;
  final double fontSize;
  final double height;

  ButtonMenuFilter({
    this.height = textFieldHeight,
    this.isBorder = true,
    this.title = '',
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: (!isBorder)
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ThemeColor.mainColor, ThemeColor.mainColor],
              ),
      ),
      child: Center(
        child: AutoSizeText(
          title!,
          style: mainFontWhiteBold.copyWith(
            color: (!isBorder) ? ThemeColor.mainColor : Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

class ButtonMenuFilterForMenuStyle extends StatelessWidget {
  final bool isBorder;
  final String title;
  final double fontSize;
  final double height;
  final double width;

  ButtonMenuFilterForMenuStyle({
    this.width = 1,
    this.height = textFieldHeight,
    this.isBorder = true,
    this.title = '',
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        border: Border.all(
          color: (!isBorder) ? ThemeColor.mainColor : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
        gradient: (!isBorder)
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ThemeColor.mainColor, ThemeColor.mainColor],
              ),
      ),
      child: Center(
        child: AutoSizeText(
          title,
          style: mainFontWhiteBold.copyWith(
            color: (!isBorder) ? ThemeColor.mainColor : Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
