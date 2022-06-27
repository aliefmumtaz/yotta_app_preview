part of 'widgets.dart';

class PoinCircleYellow extends StatelessWidget {
  final String text;

  PoinCircleYellow(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .025,
      width: MediaQuery.of(context).size.height * .025,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.accentColor2, ThemeColor.accentColor3],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: accentFontWhiteBold.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}

class PoinCircleGreen extends StatelessWidget {
  final String text;

  PoinCircleGreen(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .025,
      width: MediaQuery.of(context).size.height * .025,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.mainColor, ThemeColor.mainColor],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: accentFontWhiteBold.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}

class PoinCircleYellowForHeader extends StatelessWidget {
  final String text;

  PoinCircleYellowForHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin / 4),
      height: MediaQuery.of(context).size.height * .03,
      // width: MediaQuery.of(context).size.height * .025,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.accentColor2, ThemeColor.accentColor3],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: accentFontWhiteBold.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
