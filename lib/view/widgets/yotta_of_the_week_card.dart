part of 'widgets.dart';

class YottaOfTheWeekCard extends StatelessWidget {
  final String? name;
  final String? imgUrl;
  final String? varian;
  final EdgeInsets? margin;
  final bool? isImg;

  YottaOfTheWeekCard({
    required this.name,
    required this.imgUrl,
    required this.varian,
    this.margin,
    this.isImg = true,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: margin,
      height: height * .25,
      width: height * .15,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultMargin / 2,
                ),
                height: height * .25,
                width: height * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: ThemeColor.whiteBackColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .15),
                    AutoSizeText(
                      name!,
                      textAlign: TextAlign.center,
                      style: mainFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: height * verticalMarginHalf),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: height * .15,
            width: height * .15,
            child: (isImg!) ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imgUrl!,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Container(
                        height: height * .15,
                        width: height * .15,
                        color: ThemeColor.accentColor5,
                      ),
                    );
                  }
                },
              ),
            ) : SizedBox(),
          ),
        ],
      ),
    );
  }
}
