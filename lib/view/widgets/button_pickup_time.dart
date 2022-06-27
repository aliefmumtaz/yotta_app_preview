part of 'widgets.dart';

class ButtonPickupTime extends StatelessWidget {
  final String? time;
  final bool isSelected;
  final Function? onTap;
  final EdgeInsets? margin;

  ButtonPickupTime({
    this.time = '12:30',
    this.isSelected = false,
    this.onTap,
    this.margin,
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
        height: height * 0.05,
        width: width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (!isSelected) ? ThemeColor.mainColor : Colors.white),
          gradient: (!isSelected)
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                ),
        ),
        child: Center(
          child: Text(
            time!,
            style: accentFontWhiteRegular.copyWith(
              fontSize: 16,
              color: (!isSelected) ? ThemeColor.mainColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
