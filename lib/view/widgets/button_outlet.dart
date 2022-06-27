part of 'widgets.dart';

class ButtonOutlet extends StatelessWidget {
  final String? address;
  final String? name;
  final Function? onTap;
  final bool isSelected;

  ButtonOutlet({
    this.address = '',
    this.name = '',
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          defaultMargin,
          defaultMargin / 2,
          0,
          defaultMargin / 2,
        ),
        margin: EdgeInsets.only(bottom: defaultMargin / 4),
        decoration: BoxDecoration(
          gradient: (!isSelected)
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                name!,
                style: accentFontBlackBold.copyWith(
                  fontSize: 18,
                  color:
                      (!isSelected) ? ThemeColor.blackTextColor : Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: defaultMargin,
                ),
                child: AutoSizeText(
                  address!,
                  style: accentFontBlackRegular.copyWith(
                    fontSize: 12,
                    color: (!isSelected)
                        ? ThemeColor.blackTextColor
                        : Colors.white,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
