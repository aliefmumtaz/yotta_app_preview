part of 'widgets.dart';

class ButtonSelectTopping extends StatelessWidget {
  final String? name;
  final int? price;
  final EdgeInsets? margin;
  final bool isBorder;
  final Function? onTap;
  final String? img;

  ButtonSelectTopping({
    this.img = '',
    this.name = '',
    this.margin,
    this.onTap,
    this.price = 0,
    this.isBorder = true,
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
      child: (name != 'None')
          ? Container(
              margin: margin,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11.6),
                    child: Container(
                      height: height * 0.07,
                      width: height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Image.network(img!, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin / 2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: accentFontBlackBold.copyWith(
                            fontSize: 16,
                            color: (!isBorder) ? ThemeColor.mainColor : Colors.white,
                          ),
                        ),
                        Text(
                          '$price.000',
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 14,
                            color: (!isBorder) ? ThemeColor.accentColor3 : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: margin,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              height: height * textFieldHeight,
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
                  'None',
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
