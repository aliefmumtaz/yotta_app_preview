part of 'widgets.dart';

class ButtonSelectIce extends StatelessWidget {
  final String name;
  final EdgeInsets? margin;
  final bool isBorder;
  final Function? onTap;

  ButtonSelectIce({
    this.isBorder = true,
    this.margin,
    this.name = '',
    this.onTap,
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
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        height: height * 0.06,
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
        child: Center(
          child: Text(
            name,
            style: accentFontBlackBold.copyWith(
              fontSize: 18,
              color: (!isBorder) ? ThemeColor.mainColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
