part of 'widgets.dart';

class CardSuccessOrder extends StatefulWidget {
  final String? uid;
  final String? orderType;

  CardSuccessOrder({this.uid, this.orderType});

  @override
  _CardSuccessOrderState createState() => _CardSuccessOrderState();
}

class _CardSuccessOrderState extends State<CardSuccessOrder> {
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
                                (userState is UserLoaded)
                                    ? userState.user
                                    : null,
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
                                (userState is UserLoaded)
                                    ? userState.user
                                    : null,
                                doc['kode order'],
                              ),
                            );
                      }
                    }

                    if (orderState is PreOrderType) {
                      return SuccessOrderPreOrder(
                        outlet: doc['outlet'],
                      );
                    } else {
                      return SuccessOrderDelivery(
                        outlet: doc['outlet'],
                      );
                    }
                  }).toList(),
                ),
              ),
            );
          }
        });
  }
}

class SuccessOrderPreOrder extends StatelessWidget {
  final String? outlet;

  SuccessOrderPreOrder({this.outlet});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ThemeColor.accentColor3,
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
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin * 4,
                  ),
                  child: AutoSizeText(
                    'Pesananmu\nSudah Bisa\nDiambil',
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
                        'Loksi Outlet',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: width * .45,
                        child: AutoSizeText(
                          outlet!,
                          maxLines: 2,
                          style: accentFontWhiteBold.copyWith(
                            fontSize: 18,
                          ),
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

class SuccessOrderDelivery extends StatelessWidget {
  final String? outlet;

  SuccessOrderDelivery({this.outlet});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ThemeColor.accentColor3,
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
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin * 4,
                  ),
                  child: AutoSizeText(
                    'Pesananmu\nSedang\nDiantarkan',
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
                        'Outlet Pengantaran',
                        style: accentFontWhiteRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        width: width * .45,
                        child: AutoSizeText(
                          outlet!,
                          maxLines: 2,
                          style: accentFontWhiteBold.copyWith(
                            fontSize: 18,
                          ),
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
