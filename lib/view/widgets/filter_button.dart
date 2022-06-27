part of 'widgets.dart';

class FilterButton extends StatelessWidget {
  final Function? onTap;

  FilterButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin * 5),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
        height: MediaQuery.of(context).size.height * textFieldHeight,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ThemeColor.mainColor.withOpacity(0.4),
              offset: Offset(0, 10),
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ThemeColor.mainColor, ThemeColor.mainColor],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Filter',
                style: mainFontWhiteBold.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * horizontalMargin,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .02,
                width: MediaQuery.of(context).size.height * .02,
                child: Image.asset('assets/filter_icon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
