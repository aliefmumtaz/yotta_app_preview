part of 'widgets.dart';

class CardHistoryDeliveryOrder extends StatefulWidget {
  final String? productName;
  final String? orderDate;
  final Function? onTap;

  CardHistoryDeliveryOrder({
    this.productName,
    this.orderDate,
    this.onTap,
  });

  @override
  _CardHistoryDeliveryOrderState createState() =>
      _CardHistoryDeliveryOrderState();
}

class _CardHistoryDeliveryOrderState extends State<CardHistoryDeliveryOrder> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    // return GestureDetector(
    //   onTap: () {
    //     if (widget.onTap != null) {
    //       widget.onTap!();
    //     }
    //   },
    //   child: Column(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: defaultMargin),
    //         height: height * .15,
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           image: DecorationImage(
    //             image: AssetImage('assets/card_order_delivery.png'),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: width * .55,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   SizedBox(height: height * verticalMarginHalf / 2),
    //                   Padding(
    //                     padding: EdgeInsets.only(left: defaultMargin),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           widget.productName!,
    //                           style: mainFontBlackBold.copyWith(
    //                             fontSize: 18,
    //                             color: Colors.white,
    //                           ),
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                         SizedBox(height: height * verticalMarginHalf / 2),
    //                         AutoSizeText(
    //                           '${widget.orderDate}',
    //                           style: accentFontWhiteRegular.copyWith(
    //                             fontSize: 14,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Container(
    //                         height: height * .045,
    //                         padding:
    //                             EdgeInsets.symmetric(horizontal: defaultMargin),
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                             topRight: Radius.circular(12),
    //                             bottomLeft: Radius.circular(12),
    //                           ),
    //                           gradient: LinearGradient(
    //                             begin: Alignment.topLeft,
    //                             end: Alignment.bottomRight,
    //                             colors: [ThemeColor.mainColor, ThemeColor.mainColor],
    //                           ),
    //                         ),
    //                         child: Center(
    //                           child: AutoSizeText(
    //                             widget.orderType!,
    //                             style: mainFontWhiteBold.copyWith(
    //                               fontSize: 18,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Spacer(),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 Spacer(),
    //                 Container(
    //                   height: height * .15,
    //                   width: width * .27,
    //                   child: Image.asset(
    //                     'assets/ilustration_ongoing_order_delivery.png',
    //                     fit: BoxFit.fitWidth,
    //                     alignment: Alignment.bottomCenter,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: height * verticalMargin),
    //     ],
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ThemeColor.mainColor2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMarginHalf),
                AutoSizeText(
                  '${widget.productName!}',
                  style: mainFontWhiteBold.copyWith(
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  maxFontSize: 18,
                  minFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * (verticalMarginHalf / 2)),
                AutoSizeText(
                  'Tanggal Order - ${widget.orderDate!}',
                  style: accentFontWhiteRegular.copyWith(fontSize: 12),
                  maxFontSize: 12,
                  minFontSize: 12,
                ),
                SizedBox(height: height * verticalMarginHalf),
              ],
            ),
          ),
          SizedBox(height: height * verticalMarginHalf),
        ],
      ),
    );
  }
}

class CardHistoryOrder extends StatefulWidget {
  final String? productName;
  final String? orderDate;
  final Function? onTap;

  CardHistoryOrder({
    this.productName,
    this.orderDate,
    this.onTap,
  });

  @override
  _CardHistoryOrderState createState() => _CardHistoryOrderState();
}

class _CardHistoryOrderState extends State<CardHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    // return GestureDetector(
    //   onTap: () {
    //     if (widget.onTap != null) {
    //       widget.onTap!();
    //     }
    //   },
    //   child: Column(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: defaultMargin),
    //         height: height * .15,
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           image: DecorationImage(
    //             image: AssetImage('assets/card_order.png'),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: width * .55,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   SizedBox(height: height * verticalMarginHalf / 2),
    //                   Padding(
    //                     padding: EdgeInsets.only(left: defaultMargin),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           widget.productName!,
    //                           style: mainFontBlackBold.copyWith(
    //                             fontSize: 18,
    //                             color: accentColor2,
    //                           ),
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                         SizedBox(height: height * verticalMarginHalf / 2),
    //                         AutoSizeText(
    //                           '${widget.orderDate}',
    //                           style: accentFontWhiteRegular.copyWith(
    //                             fontSize: 14,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Container(
    //                         height: height * .045,
    //                         padding:
    //                             EdgeInsets.symmetric(horizontal: defaultMargin),
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                             topRight: Radius.circular(12),
    //                             bottomLeft: Radius.circular(12),
    //                           ),
    //                           gradient: LinearGradient(
    //                             begin: Alignment.topLeft,
    //                             end: Alignment.bottomRight,
    //                             colors: [accentColor3, accentColor2],
    //                           ),
    //                         ),
    //                         child: Center(
    //                           child: AutoSizeText(
    //                             widget.orderType!,
    //                             style: mainFontWhiteBold.copyWith(
    //                               fontSize: 18,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Spacer(),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 Spacer(),
    //                 Container(
    //                   width: width * .28,
    //                   child: Image.asset(
    //                     'assets/tespic.png',
    //                     fit: BoxFit.fitWidth,
    //                     alignment: Alignment.topCenter,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: height * verticalMargin),
    //     ],
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ThemeColor.mainColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMarginHalf),
                AutoSizeText(
                  '${widget.productName!}',
                  style: mainFontWhiteBold.copyWith(
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  maxFontSize: 18,
                  minFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * (verticalMarginHalf / 2)),
                AutoSizeText(
                  'Tanggal Order - ${widget.orderDate!}',
                  style: accentFontWhiteRegular.copyWith(fontSize: 12),
                  maxFontSize: 12,
                  minFontSize: 12,
                ),
                SizedBox(height: height * verticalMarginHalf),
              ],
            ),
          ),
          SizedBox(height: height * verticalMarginHalf),
        ],
      ),
    );
  }
}
