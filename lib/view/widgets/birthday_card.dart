part of 'widgets.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.only(left: defaultMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeColor.accentColor2),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 5,
            color: Colors.black.withOpacity(.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMargin),
                Text(
                  'Happy\nBirthday!',
                  style: mainFontBlackBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Text(
                  'Ada hadiah spesial\nuntuk kamu ❤️' ,
                  style: mainFontBlackRegular.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
          animation.Lottie.asset(
            'assets/animation_birthday.json',
            width: (MediaQuery.of(context).size.width * .5) - defaultMargin,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
