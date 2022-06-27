part of 'widgets.dart';

class GuestHeaderAskRegister extends StatelessWidget {
  const GuestHeaderAskRegister({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.accentColor2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * verticalMargin),
          AutoSizeText(
            'Nikmati berbagai fitur dan promo lainnya dengan menjadi member Yotta!',
            style: accentFontBlackRegular.copyWith(
              fontSize: 16,
            ),
            maxLines: 2,
          ),
          SizedBox(height: height * verticalMarginHalf),
          GestureDetector(
            onTap: () {
              context.read<PageBloc>().add(GoToSplashPage());
              // context.read<ListCityForRegistrationBloc>().add(GetCityList());

              // context.read<PageBloc>().add(
              //       GoToRegistrationPage(
              //         RegistrationData(),
              //         DataForRegisteredIdMember(),
              //         false,
              //       ),
              //     );
            },
            child: AutoSizeText(
              'Daftar sekarang',
              style: accentFontBlackBold.copyWith(
                fontSize: 18,
                color: ThemeColor.mainColor,
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }
}