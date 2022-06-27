part of 'widgets.dart';

class CardDetailOrderColdDrink extends StatelessWidget {
  final String? productName;
  final int? amount;
  final String? drinkSize;
  final int? sizeCupPrice;
  final String? drinkType;
  final String? toppingName;
  final int? toppingPrice;
  final String? iceLevel;
  final String? sugarLevel;
  final int? totalPrice;
  final String? imgUrl;

  CardDetailOrderColdDrink({
    this.productName,
    this.amount,
    this.drinkSize,
    this.sizeCupPrice,
    this.drinkType,
    this.toppingName,
    this.toppingPrice,
    this.iceLevel,
    this.sugarLevel,
    this.totalPrice,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: defaultMargin),
          child: Column(
            children: [
              Container(
                height: height * 0.08,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      height: height * .08,
                    ),
                    SizedBox(height: height * verticalMargin),
                    _buildDrinkType(context, 'Jumlah', '$amount'),
                    _buildLineSpacer(),
                    _buildDrinkType(
                      context,
                      'Size',
                      drinkSize!,
                      isPrice: true,
                      contentTextPrice: sizeCupPrice,
                    ),
                    _buildLineSpacer(),
                    _buildDrinkType(context, 'Tipe', drinkType!),
                    _buildLineSpacer(),
                    _buildDrinkType(
                      context,
                      'Topping',
                      toppingName!,
                      isPrice: true,
                      contentTextPrice:
                          (toppingName == 'None') ? 0 : toppingPrice,
                    ),
                    _buildLineSpacer(),
                    _buildDrinkType(context, 'Ice', iceLevel!),
                    _buildLineSpacer(),
                    _buildDrinkType(context, 'Sugar', sugarLevel!),
                    _buildLineSpacer(),
                    _buildTotalPriceWidget(context, 'Total', totalPrice),
                    SizedBox(height: height * verticalMargin),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: height * 0.08),
            Container(
              height: height * 0.08,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.04),
                    offset: Offset(0, 22),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: height * .16,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * .13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/placeholder_detail_cup.png'),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: defaultMargin, top: 12),
                        height: height * .13,
                        width: width * .5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            productName!,
                            style: mainFontBlackBold.copyWith(
                              fontSize: 24,
                              color: ThemeColor.mainColor,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: -10,
                child: Container(
                  height: height * 0.17,
                  width: width * .3,
                  child: Image.network(imgUrl!),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLineSpacer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      child: Divider(
        color: Colors.black,
      ),
    );
  }

  Widget _buildTotalPriceWidget(
    BuildContext context,
    String titleText,
    int? totalPrice,
  ) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          SizedBox(height: height * verticalMarginHalf / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                titleText,
                style: accentFontBlackRegular.copyWith(
                  fontSize: 16,
                  color: ThemeColor.accentColor4,
                ),
              ),
              AutoSizeText(
                '$totalPrice.000',
                style: accentFontBlackRegular.copyWith(
                  fontSize: 16,
                  color: ThemeColor.accentColor3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkType(
    BuildContext context,
    String titleText,
    String contentText, {
    int? contentTextPrice = 0,
    bool isPrice = false,
  }) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          SizedBox(height: height * verticalMarginHalf / 2),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                titleText,
                style: accentFontBlackRegular.copyWith(
                  fontSize: 16,
                  color: ThemeColor.accentColor4,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    contentText,
                    style: accentFontBlackBold.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  (isPrice)
                      ? SizedBox(height: height * verticalMarginHalf / 2)
                      : SizedBox(),
                  (isPrice)
                      ? AutoSizeText(
                          (contentTextPrice == 0)
                              ? '0'
                              : '$contentTextPrice.000',
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 16,
                            color: ThemeColor.accentColor3,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
          SizedBox(height: height * verticalMarginHalf / 2),
        ],
      ),
    );
  }
}
