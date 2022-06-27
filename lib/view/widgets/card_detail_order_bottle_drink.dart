part of 'widgets.dart';

class CardDetailOrderBottleDrink extends StatelessWidget {
  final String? productName;
  final int? amount;
  final String? drinkSize;
  final int? sizeCupPrice;
  final String? drinkType;
  final String? sugarLevel;
  final int? totalPrice;

  CardDetailOrderBottleDrink({
    this.productName = '',
    this.amount = 0,
    this.drinkSize = '',
    this.sizeCupPrice = 0,
    this.drinkType = '',
    this.sugarLevel = '',
    this.totalPrice = 0,
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
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.12,
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
              height: height * 0.035,
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
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          height: height * 0.12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                productName!,
                style: mainFontBlackBold.copyWith(
                  fontSize: 24,
                  color: ThemeColor.mainColor,
                ),
                maxLines: 1,
              ),
              SizedBox(height: height * verticalMarginHalf),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    height: height * 0.035,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ThemeColor.accentColor3,
                          ThemeColor.accentColor2
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        drinkType!,
                        style: accentFontWhiteBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * horizontalMarginHalf),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    height: height * 0.035,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ThemeColor.accentColor3,
                          ThemeColor.accentColor2
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        drinkSize!,
                        style: accentFontWhiteBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
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
