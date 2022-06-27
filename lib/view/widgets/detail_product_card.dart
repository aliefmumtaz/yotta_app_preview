part of 'widgets.dart';

class ProductCardDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: ThemeColor.mainColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 10),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
