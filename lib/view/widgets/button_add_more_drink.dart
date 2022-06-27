part of 'widgets.dart';

class ButtonAddMoreDrink extends StatelessWidget {
  final Function? onTap;

  ButtonAddMoreDrink({this.onTap});

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
        width: double.infinity,
        height: height * .073,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 15),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              'Tambah Minuman',
              style: mainFontBlackBold.copyWith(
                fontSize: 18,
                color: ThemeColor.mainColor,
              ),
            ),
            SizedBox(width: width * horizontalMargin),
            Container(
              height: height * .034,
              width: height * .034,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
