part of 'shared.dart';

const double defaultMargin = 24;

// responsive size
const double textFieldHeight = 0.06;
const double horizontalMargin = 0.057;
const double horizontalMarginHalf = horizontalMargin / 2;
const double verticalMargin = 0.026;
const double verticalMarginHalf = verticalMargin / 2;
const double buttonBottomMargin = 0.065;

// global color
class ThemeColor {
  static const Color mainColor = Color(0xFF6EB322);
  static const Color mainColor2 = Color(0xFF066E33);
  static const Color mainColorAccent = Color(0xFF7DC72C);
  static const Color accentColor1 = Color(0xFF6EB322);
  static const Color accentColor2 = Color(0xFFFFD76E);
  static const Color accentColor3 = Color(0xFFF59332);
  static const Color accentColor4 = Color(0xFF7E7E7E);
  static const Color accentColor5 = Color(0xFFDADADA);
  static const Color accentColor6 = Color(0xFFFBFBFB);
  static const Color accentColor7 = Color(0xFFC4C4C4);
  static const Color accentColor8 = Color(0xFFF5F5F5);
  static const Color whiteBackColor = Color(0xFFF5f5f5);
  static const Color errorColor = Color(0xFFC94242);
  static const Color blackTextColor = Color(0xFF1C1C1C);
  static const Color outlineColor = Color(0xFFEEEEEE);
}

// global shimmer style
const LinearGradient shimmerGradient = LinearGradient(
  stops: [.3, .5, .7],
  colors: [
    ThemeColor.accentColor6,
    ThemeColor.accentColor5,
    ThemeColor.accentColor6
  ],
);

// global text style
TextStyle mainFontBlackBold = GoogleFonts.nunito().copyWith(
  color: ThemeColor.blackTextColor,
  fontWeight: FontWeight.bold,
);

TextStyle mainFontWhiteBold = GoogleFonts.nunito().copyWith(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle mainFontBlackRegular = GoogleFonts.nunito().copyWith(
  color: ThemeColor.blackTextColor,
  fontWeight: FontWeight.w300,
);

TextStyle mainFontWhiteRegular = GoogleFonts.nunito().copyWith(
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

TextStyle accentFontBlackBold = GoogleFonts.montserrat().copyWith(
  color: ThemeColor.blackTextColor,
  fontWeight: FontWeight.bold,
);

TextStyle accentFontWhiteBold = GoogleFonts.montserrat().copyWith(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle accentFontBlackRegular = GoogleFonts.montserrat().copyWith(
  color: ThemeColor.blackTextColor,
  fontWeight: FontWeight.w300,
);

TextStyle accentFontWhiteRegular = GoogleFonts.montserrat().copyWith(
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

TextStyle accentFontWhiteLight = GoogleFonts.montserrat().copyWith(
  color: ThemeColor.accentColor4,
  fontWeight: FontWeight.w300,
);

// global flushbar style
const Color flushColor = ThemeColor.accentColor3;
const int flushAnimationDuration = 800;
