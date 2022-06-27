part of 'widgets.dart';

class QuickTipsDeliveryMarker extends StatelessWidget {
  final Function? onTap;

  QuickTipsDeliveryMarker({this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ThemeColor.mainColor),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              offset: Offset(0, 15),
              blurRadius: 15,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultMargin / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Tentukan Lokasi',
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                      color: ThemeColor.mainColor,
                    ),
                  ),
                  SizedBox(height: height * verticalMarginHalf / 2),
                  AutoSizeText(
                    'Tahan dan geser pin lokasi ke titik pengantaran',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            _btnClose(context),
          ],
        ),
      ),
    );
  }

  Widget _btnClose(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
          height: height * .04,
          width: height * .04,
          decoration: BoxDecoration(
            color: ThemeColor.accentColor2,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Icon(Icons.close, color: ThemeColor.mainColor),
        ),
      ),
    );
  }
}
