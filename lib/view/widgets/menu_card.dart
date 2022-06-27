part of 'widgets.dart';

class ColdMenuCard extends StatelessWidget {
  final String? menuName;
  final String? priceR;
  final String? priceL;
  final bool isSelected;
  final Function? onTap;
  final String? imgUrl;

  ColdMenuCard({
    this.onTap,
    this.menuName,
    this.priceL,
    this.priceR,
    this.isSelected = false,
    this.imgUrl = '-',
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
        height: height * .37,
        width: width * 0.41,
        decoration: BoxDecoration(
          color: (!isSelected) ? Colors.white : ThemeColor.accentColor2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ThemeColor.mainColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 15),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    SizedBox(height: height * verticalMarginHalf),
                    AutoSizeText(
                      menuName!,
                      maxLines: 2,
                      style: mainFontBlackBold.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * verticalMarginHalf),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoinCircleGreen('R'),
                          Text(
                            '${priceR}K',
                            style:
                                accentFontBlackRegular.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * verticalMarginHalf / 2),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoinCircleGreen('L'),
                          Text(
                            '${priceL}K',
                            style:
                                accentFontBlackRegular.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * .1,
                width: width * .35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ThemeColor.accentColor3.withOpacity(0.5),
                      ThemeColor.accentColor2.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Container(
                height: height * .2,
                child: Image.network(
                  imgUrl!,
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * .2,
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottleMenuCard extends StatelessWidget {
  final String? menuName;
  final String price500ml;
  final String price1000ml;
  final Function? onTap;

  BottleMenuCard({
    this.onTap,
    this.menuName = '',
    this.price1000ml = '0',
    this.price500ml = '0',
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
        width: width * .41,
        height: height * .15,
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.mainColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 15),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                menuName!,
                maxLines: 2,
                style: mainFontBlackBold.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin / 4,
                ),
                child: Column(
                  children: [
                    _buildSizeBox(context, '500L', '$price500ml'),
                    SizedBox(height: height * verticalMarginHalf / 2),
                    _buildSizeBox(context, '1000L', '$price1000ml'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeBox(BuildContext context, String text, String sizePrice) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: height * .025,
          width: width * .12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ThemeColor.mainColor, ThemeColor.mainColor],
            ),
          ),
          child: Center(
            child: AutoSizeText(
              text,
              style: accentFontWhiteBold.copyWith(fontSize: 12),
            ),
          ),
        ),
        AutoSizeText(
          '${sizePrice}K',
          style: accentFontBlackRegular.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}

class HotMenuCard extends StatelessWidget {
  final Function? onTap;
  final String? menuName;
  final String? priceR;

  HotMenuCard({this.onTap, this.menuName, this.priceR});

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
        width: width * .41,
        height: height * .15,
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.mainColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 15),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                menuName!,
                maxLines: 2,
                style: mainFontBlackBold.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoinCircleGreen('R'),
                    Text(
                      priceR! + 'K',
                      style: accentFontBlackRegular.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
