part of 'widgets.dart';

class CardMember extends StatelessWidget {
  final String? name;
  final int? yPoin;
  final String? idMember;
  final String? phoneNumber;

  CardMember({
    this.idMember,
    this.name,
    this.phoneNumber,
    this.yPoin,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 10),
            color: ThemeColor.accentColor2.withOpacity(0.4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ThemeColor.accentColor3, ThemeColor.accentColor2],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.023),
                    Row(
                      children: [
                        Container(
                          height: height * .06,
                          width: height * .06,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: height * 0.023,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultMargin / 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * verticalMargin),
                    Padding(
                      padding: EdgeInsets.only(right: defaultMargin * 3),
                      child: AutoSizeText(
                        name!,
                        style: mainFontWhiteBold.copyWith(fontSize: 26),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: height * verticalMargin),
                    Row(
                      children: [
                        AutoSizeText(
                          'Poin: ',
                          style: mainFontWhiteBold.copyWith(fontSize: 20),
                        ),
                        AutoSizeText(
                          '$yPoin',
                          style: mainFontWhiteBold.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    BlocBuilder<GuestModeBloc, GuestModeState>(
                      builder: (_, guestState) {
                        if (guestState is GuestMode) {
                          return SizedBox();
                        } else {
                          return BlocBuilder<DateCreationBloc,
                              DateCreationState>(builder: (_, dateCreation) {
                            if (dateCreation is LoadDateCreation) {
                              return AutoSizeText(
                                'Exp: ${dateCreation.validUntil}',
                                style: accentFontWhiteRegular.copyWith(
                                    fontSize: 6),
                              );
                            } else {
                              return SizedBox();
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(height: height * verticalMargin),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'ID Member',
                              style:
                                  accentFontWhiteRegular.copyWith(fontSize: 6),
                            ),
                            Container(
                              width: width * 0.25,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    idMember!,
                                    maxLines: 1,
                                    style: mainFontWhiteBold.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'No. Handphone',
                              style:
                                  accentFontWhiteRegular.copyWith(fontSize: 6),
                            ),
                            Container(
                              width: width * 0.40,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    phoneNumber!,
                                    maxLines: 1,
                                    style: mainFontWhiteBold.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
