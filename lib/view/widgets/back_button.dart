part of 'widgets.dart';

class BackButtonWidget extends StatelessWidget {
  final String? name;
  final bool title;
  final Function? onTapFunc;
  final Color? color;
  final bool isMarginTop;

  BackButtonWidget({
    this.isMarginTop = false,
    this.name,
    this.title = false,
    this.onTapFunc,
    this.color = ThemeColor.blackTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (isMarginTop)
            ? SizedBox()
            : SizedBox(
                height: MediaQuery.of(context).size.height * verticalMargin,
              ),
        Row(
          children: [
            GestureDetector(
              onTap: onTapFunc as void Function()?,
              child: Icon(Icons.arrow_back_ios, size: 20, color: color),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * horizontalMarginHalf,
            ),
            (title)
                ? SizedBox()
                : AutoSizeText(
                    name!,
                    style: mainFontBlackRegular.copyWith(
                        fontSize: 16, color: color),
                  ),
          ],
        ),
      ],
    );
  }
}
