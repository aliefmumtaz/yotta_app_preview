part of 'widgets.dart';

class SkeletonLoadingForAllMenu extends StatelessWidget {
  final double height;
  final double width;

  SkeletonLoadingForAllMenu({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    List<String> dummyStirngForLoading = ['', '', '', '', '', ''];

    return Shimmer(
      gradient: shimmerGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeColor.accentColor5,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Text(
                '',
                style: accentFontBlackBold.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: mediaHeight * verticalMargin),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: dummyStirngForLoading
                  .map(
                    (e) => Column(
                      children: [
                        Container(
                          height: mediaHeight * height,
                          width: mediaWidth * width,
                          decoration: BoxDecoration(
                            color: ThemeColor.accentColor5,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        SizedBox(height: mediaHeight * verticalMargin),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
