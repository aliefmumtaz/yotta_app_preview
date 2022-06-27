part of 'widgets.dart';

class YottaOfTheWeekModalBottom extends StatelessWidget {
  final String? imgUrl;
  final String? name;
  final String? varian;
  final String? priceR;
  final String? priceL;

  YottaOfTheWeekModalBottom({
    required this.imgUrl,
    required this.name,
    required this.varian,
    required this.priceR,
    required this.priceL,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
          height: height * .7,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        child: Image.network(
                          imgUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    height: height * .2,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * verticalMargin),
                        Padding(
                          padding: const EdgeInsets.only(right: defaultMargin),
                          child: AutoSizeText(
                            name!,
                            style: mainFontBlackBold.copyWith(
                                fontSize: 24, color: ThemeColor.mainColor),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: height * verticalMarginHalf),
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PoinCircleGreen('R'),
                                SizedBox(width: defaultMargin / 4),
                                Text(
                                  '$priceR.000',
                                  style: accentFontBlackRegular.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: defaultMargin / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PoinCircleGreen('L'),
                                SizedBox(width: defaultMargin / 4),
                                Text(
                                  '$priceL.000',
                                  style: accentFontBlackRegular.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * verticalMargin),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}