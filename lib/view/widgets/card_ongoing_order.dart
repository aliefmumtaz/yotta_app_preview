part of 'widgets.dart';

class CardOngoingOrder extends StatefulWidget {
  final String? uid;
  final String? orderType;

  CardOngoingOrder({this.uid, this.orderType});

  @override
  _CardOngoingOrderState createState() => _CardOngoingOrderState();
}

class _CardOngoingOrderState extends State<CardOngoingOrder> {
  String? id;
  String? type;

  @override
  void initState() {
    id = widget.uid;
    type = widget.orderType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference _orderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    return StreamBuilder<QuerySnapshot>(
      stream: _orderType
          .where(
            'tipe order',
            isEqualTo: type,
          )
          .snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SizedBox();
        } else if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return BlocBuilder<OrderTypeBloc, OrderTypeState>(
            builder: (_, orderState) => BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => Column(
                children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                  if (doc['status'] == 'Siap Diambil') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToInitial(),
                        );

                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToDone(),
                        );
                  } else if (doc['status'] == 'Selesai') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToInitial(),
                        );

                    if (orderState is PreOrderType) {
                      context.read<HistoryOrderBloc>().add(
                            SetDataOrderToHistory(
                              (userState is UserLoaded)
                                  ? userState.user.uid
                                  : '',
                              false,
                              (userState is UserLoaded) ? userState.user : null,
                              doc['kode order'],
                            ),
                          );
                    } else if (orderState is DeliveryType) {
                      context.read<HistoryOrderBloc>().add(
                            SetDataOrderToHistory(
                              (userState is UserLoaded)
                                  ? userState.user.uid
                                  : '',
                              true,
                              (userState is UserLoaded) ? userState.user : null,
                              doc['kode order'],
                            ),
                          );
                    }
                  }

                  if (orderState is PreOrderType) {
                    return OnGoingPreOrder(
                      orderType: doc['tipe order'],
                      totalPrice: "${doc['total harga']}.000",
                      pickupTime: doc['waktu pickup'],
                      status: doc['status'],
                    );
                  } else {
                    return OnGoingDelivery(
                      orderType: doc['tipe order'],
                      deliveryOutlet: doc['outlet'],
                      status: doc['status'],
                      totalPrice: doc['total harga'].toString(),
                    );
                  }
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}

class OnGoingPreOrder extends StatelessWidget {
  final String? orderType;
  final String? totalPrice;
  final String? pickupTime;
  final String? status;

  OnGoingPreOrder({
    this.orderType,
    this.totalPrice,
    this.pickupTime,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.mainColor, ThemeColor.mainColor],
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColor.mainColor.withOpacity(0.3),
            offset: Offset(0, 10),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMargin),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: AutoSizeText(
                    orderType!,
                    style: mainFontWhiteBold.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Total Belanja',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      AutoSizeText(
                        '${totalPrice!}.000',
                        style: accentFontWhiteBold.copyWith(
                          fontSize: 18,
                          color: ThemeColor.accentColor2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Waktu Pengambilan',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      AutoSizeText(
                        pickupTime!,
                        style: accentFontWhiteBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
            Positioned(
              bottom: -10,
              right: -35,
              child: Container(
                margin: EdgeInsets.only(right: defaultMargin / 2),
                width: width * .5,
                child: Image.asset('assets/no_order.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnGoingDelivery extends StatelessWidget {
  final String? orderType;
  final String? totalPrice;
  final String? deliveryOutlet;
  final String? status;

  OnGoingDelivery({
    this.orderType,
    this.totalPrice,
    this.deliveryOutlet,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeColor.mainColor, ThemeColor.mainColor],
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColor.mainColor.withOpacity(0.3),
            offset: Offset(0, 10),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * verticalMargin),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: AutoSizeText(
                    orderType!,
                    style: mainFontWhiteBold.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Total',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      AutoSizeText(
                        '$totalPrice.000',
                        style: accentFontWhiteBold.copyWith(
                          fontSize: 18,
                          color: ThemeColor.accentColor2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Outlet Pengantaran',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      Container(
                        width: width * .4,
                        child: AutoSizeText(
                          deliveryOutlet!,
                          style: accentFontWhiteBold.copyWith(
                            fontSize: 18,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: width * .36,
                child: Image.asset(
                  'assets/ilustration_ongoing_order_delivery.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
