part of 'widgets.dart';

class CardOrderType extends StatelessWidget {
  final String? orderType;
  final String? pickupTime;
  final String? outlet;
  final String? orderID;
  final bool isOrderIDVisible;

  CardOrderType({
    this.isOrderIDVisible = true,
    this.orderType,
    this.outlet,
    this.pickupTime,
    required this.orderID,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                SizedBox(height: height * verticalMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Jenis Pesanan',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      orderType!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (isOrderIDVisible)
                  SizedBox(height: height * verticalMarginHalf / 2),
                if (isOrderIDVisible) _buildLineSpacer(),
                if (isOrderIDVisible)
                  SizedBox(height: height * verticalMarginHalf / 2),
                if (isOrderIDVisible)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Order ID',
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 16,
                          color: ThemeColor.accentColor4,
                        ),
                      ),
                      AutoSizeText(
                        orderID!,
                        style: accentFontBlackBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
        SizedBox(height: height * verticalMargin),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                SizedBox(height: height * verticalMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Waktu Pengambilan',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      pickupTime!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                _buildLineSpacer(),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * .33,
                      child: AutoSizeText(
                        'Outlet',
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 16,
                          color: ThemeColor.accentColor4,
                        ),
                      ),
                    ),
                    Container(
                      width: width * .37,
                      child: AutoSizeText(
                        outlet!,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        style: accentFontBlackBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLineSpacer() {
    return Container(
      width: double.infinity,
      child: Divider(
        color: Colors.black,
      ),
    );
  }
}

class CardDeliveryOrderType extends StatelessWidget {
  final String? address;
  final String? outlet;
  final String? orderType;
  final String? distance;
  final String? deliveryFee;
  final String? orderID;

  CardDeliveryOrderType({
    this.address,
    this.outlet,
    this.orderType,
    this.distance,
    this.deliveryFee,
    required this.orderID,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                SizedBox(height: height * verticalMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Jenis Pesanan',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      orderType!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                _buildLineSpacer(),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Order ID',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      orderID!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
        SizedBox(height: height * verticalMargin),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMargin),
                AutoSizeText(
                  'Alamat Pengiriman',
                  style: accentFontBlackRegular.copyWith(
                    fontSize: 16,
                    color: ThemeColor.accentColor4,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  address!,
                  style: accentFontBlackBold.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      height: height * .07,
                      child: Image.asset(
                        'assets/distance_line.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    AutoSizeText(
                      distance!,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                AutoSizeText(
                  outlet!,
                  style: accentFontBlackBold.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                _buildLineSpacer(),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Ongkos Kirim',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      (deliveryFee == '0') ? 'Gratis' : '$deliveryFee.000',
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLineSpacer() {
    return Container(
      width: double.infinity,
      child: Divider(
        color: Colors.black,
      ),
    );
  }
}

class CardHistoryOrderType extends StatelessWidget {
  final String? orderType;
  final String? pickupTime;
  final String? outlet;
  final int? totalPrice;
  final String? orderID;

  CardHistoryOrderType({
    this.orderID,
    this.orderType,
    this.outlet,
    this.pickupTime,
    this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                SizedBox(height: height * verticalMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Jenis Pesanan',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      orderType!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                _buildLineSpacer(),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Order ID',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      orderID!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
        SizedBox(height: height * verticalMargin),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                SizedBox(height: height * verticalMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Waktu Pengambilan',
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 16,
                        color: ThemeColor.accentColor4,
                      ),
                    ),
                    AutoSizeText(
                      pickupTime!,
                      style: accentFontBlackBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMarginHalf / 2),
                _buildLineSpacer(),
                SizedBox(height: height * verticalMarginHalf / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * .33,
                      child: AutoSizeText(
                        'Outlet',
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 16,
                          color: ThemeColor.accentColor4,
                        ),
                      ),
                    ),
                    Container(
                      width: width * .37,
                      child: AutoSizeText(
                        outlet!,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        style: accentFontBlackBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          ),
        ),
        SizedBox(height: height * verticalMargin),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: height * verticalMargin),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'Total Harga',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 16,
                      color: ThemeColor.accentColor4,
                    ),
                  ),
                  AutoSizeText(
                    "$totalPrice.000",
                    style: accentFontBlackBold.copyWith(
                      fontSize: 18,
                      color: ThemeColor.accentColor3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * verticalMargin),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLineSpacer() {
    return Container(
      width: double.infinity,
      child: Divider(
        color: Colors.black,
      ),
    );
  }
}
