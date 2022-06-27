part of 'widgets.dart';

class AlertBoxWidget extends StatelessWidget {
  final String boxTitle;
  final String desc;
  final bool isDesc;
  final String topButtonTitle;
  final String bottomButtonTitle;
  final bool isLeftCTA;
  final bool isRightCTA;
  final Function? onTapTopButton;
  final Function? onTapBottomButton;
  final bool isOneButton;
  final String oneButtonText;
  final Function? onTapOneButton;
  final bool isOneLine;

  AlertBoxWidget({
    this.boxTitle = '',
    this.isDesc = false,
    this.desc = '',
    this.topButtonTitle = 'Ya',
    this.bottomButtonTitle = 'Tidak',
    this.isLeftCTA = false,
    this.isRightCTA = false,
    this.onTapTopButton,
    this.onTapBottomButton,
    this.isOneButton = false,
    this.oneButtonText = '',
    this.onTapOneButton,
    this.isOneLine = false,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * verticalMargin),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMargin * 2,
                  ),
                  child: AutoSizeText(
                    boxTitle,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                    ),
                    maxLines: (!isOneLine) ? 5 : 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                (isDesc)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: AutoSizeText(
                          desc,
                          textAlign: TextAlign.center,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                          ),
                          maxLines: 3,
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: (isDesc) ? height * verticalMarginHalf : 0),
                SizedBox(height: height * verticalMarginHalf),
                (!isOneButton)
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (onTapTopButton != null) {
                                onTapTopButton!();
                              }
                            },
                            child: Container(
                              height: height * 0.065,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: ThemeColor.accentColor7,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  topButtonTitle,
                                  style: mainFontBlackBold.copyWith(
                                    fontSize: 18,
                                    color: (!isLeftCTA)
                                        ? ThemeColor.mainColor
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (onTapBottomButton != null) {
                                onTapBottomButton!();
                              }
                            },
                            child: Container(
                              height: height * 0.065,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: ThemeColor.accentColor7,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  bottomButtonTitle,
                                  style: mainFontBlackBold.copyWith(
                                    fontSize: 18,
                                    color: (!isRightCTA)
                                        ? ThemeColor.mainColor
                                        : ThemeColor.accentColor4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
            (!isOneButton)
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      if (onTapOneButton != null) {
                        onTapOneButton!();
                      }
                    },
                    child: Container(
                      height: height * .065,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: ThemeColor.accentColor5,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          oneButtonText,
                          style: mainFontBlackBold.copyWith(
                            fontSize: 18,
                            color: ThemeColor.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
