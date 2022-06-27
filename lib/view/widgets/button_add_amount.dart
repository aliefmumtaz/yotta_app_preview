part of 'widgets.dart';

class ButtonAddAmount extends StatelessWidget {
  final Function? removeAmount;
  final Function? addAmount;
  final int? amount;

  ButtonAddAmount({this.addAmount, this.removeAmount, this.amount});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .05,
      width: width * .4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 10),
            blurRadius: 12,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.mainColor, ThemeColor.mainColor],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (removeAmount != null) {
                removeAmount!();
              }
            },
            child: Container(
              height: height * .05,
              width: width * .15,
              child: Icon(
                Icons.remove,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
          AutoSizeText(
            '$amount',
            style: accentFontBlackBold.copyWith(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (addAmount != null) {
                addAmount!();
              }
            },
            child: Container(
              height: height * .05,
              width: width * .15,
              child: Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
