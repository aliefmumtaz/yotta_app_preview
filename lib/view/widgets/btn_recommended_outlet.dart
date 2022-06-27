part of 'widgets.dart';

class ButtonRecommendedOutlet extends StatelessWidget {
  final String outletName;
  final String distance;
  final bool isSelected;
  final EdgeInsets margin;

  ButtonRecommendedOutlet({
    required this.distance,
    required this.outletName,
    this.isSelected = false,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: margin,
      height: height * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (isSelected) ? ThemeColor.mainColor : Colors.transparent,
        border: Border.all(color: ThemeColor.mainColor),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              outletName,
              style: accentFontWhiteBold.copyWith(
                color: (isSelected) ? Colors.white : ThemeColor.mainColor,
                fontSize: 18,
              ),
            ),
            AutoSizeText(
              distance,
              style: accentFontWhiteRegular.copyWith(
                color: (isSelected) ? Colors.white : ThemeColor.mainColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
