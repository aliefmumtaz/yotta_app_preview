part of 'widgets.dart';

class GlobalButton extends StatefulWidget {
  final String? title;
  final Function? onTapFunc;
  final Color gradient1;
  final Color gradient2;
  final bool isBorder;
  final double height;
  final double width;
  final bool isSelected;
  final Color borderColor;
  final Color textColor;
  final EdgeInsets? margin;
  final double fontSize;
  final bool isButtonSolidColor;
  final Color? buttonSolidColor;
  final bool isButtonLoading;
  final bool isButtonClicked;

  GlobalButton({
    this.fontSize = 18,
    this.title,
    this.onTapFunc,
    this.gradient1 = ThemeColor.mainColor,
    this.gradient2 = ThemeColor.mainColor,
    this.isBorder = true,
    this.height = 0.06,
    this.width = 1,
    this.isSelected = false,
    this.borderColor = ThemeColor.mainColor,
    this.textColor = ThemeColor.mainColor,
    this.margin,
    this.buttonSolidColor = ThemeColor.accentColor4,
    this.isButtonSolidColor = false,
    this.isButtonLoading = false,
    this.isButtonClicked = false,
  });

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin, // height: 60,-=
      height: MediaQuery.of(context).size.height * widget.height,
      width: MediaQuery.of(context).size.width * widget.width,
      decoration: BoxDecoration(
        color: (!widget.isButtonSolidColor) ? null : widget.buttonSolidColor,
        border: Border.all(
          color: (!widget.isBorder) ? widget.borderColor : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
        gradient: (!widget.isBorder)
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.gradient1, widget.gradient2],
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTapFunc as void Function()?,
          child: Center(
            child: (widget.isButtonLoading)
                ? Container(
                    height: MediaQuery.of(context).size.height * .05,
                    child: SpinKitRing(
                      color: Colors.white,
                      size: 18,
                      lineWidth: 2,
                    ),
                  )
                : AutoSizeText(
                    widget.title!,
                    style: mainFontWhiteBold.copyWith(
                      color:
                          (!widget.isBorder) ? widget.textColor : Colors.white,
                      fontSize: widget.fontSize,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
