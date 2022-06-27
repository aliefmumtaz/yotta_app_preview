part of 'pages.dart';

class CartPage extends StatefulWidget {
  final String? selectedOrder;
  final List<String> orderCathergory = ['Sedang Diproses', 'Riwayat Pesanan'];

  CartPage(this.selectedOrder);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? selectedOrderCathegory;
  bool isDone = false;

  @override
  void initState() {
    selectedOrderCathegory = widget.selectedOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              children: [
                CartDummyWidget(),
                Column(
                  children: [
                    BlocBuilder<StatusOrderBloc, StatusOrderState>(
                      builder: (_, statusOrder) {
                        if (statusOrder is OnGoingOrder) {
                          // return _buildCardOnGoingOrder();
                          return BlocBuilder<OrderTypeBloc, OrderTypeState>(
                            builder: (_, orderState) =>
                                BlocBuilder<UserBloc, UserState>(
                                    builder: (_, userState) {
                              if (orderState is DeliveryType) {
                                return _buildCardOnGoingOrderTest(
                                  (userState is UserLoaded)
                                      ? userState.user.uid
                                      : '',
                                  'Delivery',
                                );
                              } else if (orderState is PreOrderType) {
                                return _buildCardOnGoingOrderTest(
                                  (userState is UserLoaded)
                                      ? userState.user.uid
                                      : '',
                                  'Pre-Order',
                                );
                              } else {
                                return _noOrder();
                              }
                            }),
                          );
                        } else if (statusOrder is PastOrder) {
                          // return SizedBox();
                          return BlocBuilder<HistoryOrderListBloc,
                              HistoryOrderListState>(
                            builder: (_, historyListState) {
                              if (historyListState is LoadHistoryOrderList) {
                                return Column(
                                  children: [
                                    _buildListCardPastOrder(),
                                    _buildListCardPastOrderDelivery(),
                                  ],
                                );
                              } else {
                                return Container(
                                  height: height * .1,
                                  child: SpinKitRing(
                                    color: ThemeColor.accentColor2,
                                    size: 34,
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return Text('eror');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: height * verticalMargin),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Cek pesananmu di sini',
                              style: mainFontBlackBold.copyWith(
                                fontSize: 24,
                              ),
                              maxLines: 1,
                            ),
                            // ElevatedButton(
                            //   child: Text('Set Database'),
                            //   onPressed: () async {
                            //     await MenuServices.setDatabase();
                            //   },
                            // ),
                            SizedBox(height: height * verticalMargin),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _generateBottomOrderChategory(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * verticalMargin),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: whiteBackColor,
    //   body: FutureBuilder<bool>(
    //     future: ConnectionCheck.isInternet(),
    //     builder: (_, AsyncSnapshot<bool> snapshot) {
    //       if (snapshot.data == true ||
    //           snapshot.connectionState == ConnectionState.waiting) {
    //         return Stack(
    //           children: [
    //             SafeArea(
    //               child: ListView(
    //                 children: [
    //                   CartDummyWidget(),
    //                   Column(
    //                     children: [
    //                       BlocBuilder<StatusOrderBloc, StatusOrderState>(
    //                         builder: (_, statusOrder) {
    //                           if (statusOrder is OnGoingOrder) {
    //                             return _buildCardOnGoingOrder();
    //                           } else if (statusOrder is PastOrder) {
    //                             // return SizedBox();
    //                             return BlocBuilder<HistoryOrderListBloc,
    //                                 HistoryOrderListState>(
    //                               builder: (_, historyListState) {
    //                                 if (historyListState
    //                                     is LoadHistoryOrderList) {
    //                                   return Column(
    //                                     children: [
    //                                       _buildListCardPastOrder(),
    //                                       _buildListCardPastOrderDelivery(),
    //                                     ],
    //                                   );
    //                                 } else {
    //                                   return Container(
    //                                     height: height * .1,
    //                                     child: SpinKitRing(
    //                                       color: accentColor2,
    //                                       size: 34,
    //                                     ),
    //                                    );
    //                                 }
    //                               },
    //                             );
    //                           } else {
    //                             return Text('eror');
    //                           }
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Column(
    //               children: [
    //                 Container(
    //                   color: whiteBackColor,
    //                   child: SafeArea(
    //                     child: Column(
    //                       children: [
    //                         SizedBox(height: height * verticalMargin),
    //                         Padding(
    //                           padding: EdgeInsets.symmetric(
    //                               horizontal: defaultMargin),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               AutoSizeText(
    //                                 'Cek pesananmu di sini',
    //                                 style: mainFontBlackBold.copyWith(
    //                                   fontSize: 24,
    //                                 ),
    //                                 maxLines: 1,
    //                               ),
    //                               // ElevatedButton(
    //                               //   child: Text('Set Database'),
    //                               //   onPressed: () async {
    //                               //     await MenuServices.setDatabase();
    //                               //   },
    //                               // ),
    //                               SizedBox(height: height * verticalMargin),
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: _generateBottomOrderChategory(),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         SizedBox(height: height * verticalMargin),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Spacer(),
    //               ],
    //             ),
    //           ],
    //         );
    //       } else {
    //         return SafeArea(
    //           child: Center(
    //             child: Text('no connection'),
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  Widget _buildListCardPastOrder() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<HistoryOrderListBloc, HistoryOrderListState>(
      builder: (_, historyListState) {
        if (historyListState is LoadHistoryOrderList) {
          if (historyListState.historyOrderList.isEmpty) {
            return _noOrder();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: defaultMargin),
                  child: AutoSizeText(
                    'Pre-Order',
                    style: accentFontBlackBold.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: height * verticalMarginHalf),
                Column(
                  children: historyListState.historyOrderList
                      .map(
                        (e) => BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => CardHistoryOrder(
                            onTap: () async => _onPressedHistoryOrderCard(
                              e.orderID!,
                              (userState is UserLoaded)
                                  ? userState.user.uid
                                  : '',
                              e.orderDocID,
                              orderType: e.orderType,
                              outlet: e.outlet,
                              pickupTime: e.pickupTime,
                              totalPrice: e.totalPrice,
                            ),
                            productName: e.productName,
                            orderDate: e.orderDate,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          }
        } else {
          // return Container(
          //   height: MediaQuery.of(context).size.height * .1,
          //   child: SpinKitRing(color: accentColor2, size: 34),
          // );
          return SizedBox();
        }
      },
    );
  }

  Widget _buildListCardPastOrderDelivery() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<HistoryOrderListBloc, HistoryOrderListState>(
      builder: (_, historyListState) {
        if (historyListState is LoadHistoryOrderList) {
          if (historyListState.historyOrderList.isEmpty) {
            return SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (historyListState.historyOrderDeliveryList.isEmpty)
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: defaultMargin),
                        child: AutoSizeText(
                          'Delivery',
                          style: accentFontBlackBold.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                SizedBox(height: height * verticalMarginHalf),
                Column(
                  children: historyListState.historyOrderDeliveryList
                      .map(
                        (e) => BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => CardHistoryDeliveryOrder(
                            onTap: () async =>
                                _onPressedHostoryOrderDeliveryCard(
                              e.orderID!,
                              (userState is UserLoaded)
                                  ? userState.user.uid
                                  : '',
                              e.orderDocID,
                              orderType: e.orderType,
                              outlet: e.outlet,
                              address: e.address,
                              deliveryFee: e.deliveryFee,
                              distance: e.distance.toString(),
                            ),
                            productName: e.productName,
                            orderDate: e.orderDate,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          }
        } else {
          // return Container(
          //   height: MediaQuery.of(context).size.height * .1,
          //   child: SpinKitRing(color: accentColor2, size: 34),
          // );
          return SizedBox();
        }
      },
    );
  }

  Widget _buildCardOnGoingOrderTest(String? id, String? orderType) {
    CollectionReference _orderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id!)
        .collection('checkout_order');

    return StreamBuilder<QuerySnapshot>(
      stream: _orderType.where('tipe order', isEqualTo: orderType!).snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return _noOrder();
        } else if (!snapshot.hasData) {
          return _noOrder();
        } else {
          return BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) => BlocBuilder<
                CheckoutSelectedOutletLatlngBloc,
                CheckoutSelectedOutletLatlngState>(
              builder: (_, locState) => Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot? doc) {
                if (orderType == 'Delivery') {
                  if (doc!['status'] == 'Selesai') {
                    context.read<HistoryOrderBloc>().add(
                          SetDataOrderToHistory(
                            id,
                            true,
                            (userState is UserLoaded) ? userState.user : null,
                            doc['kode order'],
                          ),
                        );

                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToInitial(),
                        );

                    context.read<OrderTypeBloc>().add(OrderTypeToInitial());
                  }

                  if (doc['status'] == 'Dalam Proses') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToProcess(),
                        );

                    return GestureDetector(
                      onTap: () async => _onPressedOnGoingOrderDeliveryCard(
                        id,
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.outletLatLng
                            : LatLng(0, 0),
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.userLoc
                            : LatLng(0, 0),
                      ),
                      child: OnGoingPreOrder(
                        orderType: doc['tipe order'],
                        totalPrice: "${doc['total harga']}.000",
                        pickupTime: doc['waktu pickup'],
                        status: doc['status'],
                      ),
                    );
                  } else if (doc['status'] == 'Siap Diambil') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToDone(),
                        );

                    return GestureDetector(
                      onTap: () async => _onPressedOnGoingOrderDeliveryCard(
                        id,
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.outletLatLng
                            : LatLng(0, 0),
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.userLoc
                            : LatLng(0, 0),
                      ),
                      child: SuccessOrderDelivery(
                        outlet: doc['outlet'],
                      ),
                    );
                  } else {
                    return _noOrder();
                  }
                } else if (orderType == 'Pre-Order') {
                  if (doc!['tipe order'] == 'Pre-Order' &&
                      doc['status'] == 'Selesai') {
                    context.read<HistoryOrderBloc>().add(
                          SetDataOrderToHistory(
                            id,
                            false,
                            (userState is UserLoaded) ? userState.user : null,
                            doc['kode order'],
                          ),
                        );

                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToInitial(),
                        );

                    context.read<OrderTypeBloc>().add(OrderTypeToInitial());
                  }

                  if (doc['status'] == 'Dalam Proses') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToProcess(),
                        );

                    return GestureDetector(
                      onTap: () async => _onPressedOnGoingOrderCard(id),
                      child: OnGoingPreOrder(
                        orderType: doc['tipe order'],
                        pickupTime: doc['waktu pickup'],
                        status: doc['status'],
                        totalPrice: doc['total harga'].toString(),
                      ),
                    );
                  } else if (doc['status'] == 'Siap Diambil') {
                    context.read<ChangeStatusOrderBloc>().add(
                          SetNewStatusToDone(),
                        );

                    return GestureDetector(
                      onTap: () async => _onPressedOnGoingOrderCard(id),
                      child: SuccessOrderPreOrder(
                        outlet: doc['outlet'],
                      ),
                    );
                  } else {
                    return _noOrder();
                  }
                } else {
                  return _noOrder();
                }
              }).toList()),
            ),
          );
        }
      },
    );
  }

  // Widget _buildCardOnGoingOrder() {
  //   return BlocBuilder<CheckoutSelectedOutletLatlngBloc,
  //       CheckoutSelectedOutletLatlngState>(
  //     builder: (_, locState) => BlocBuilder<UserBloc, UserState>(
  //       builder: (_, userState) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
  //         builder: (_, orderState) =>
  //             BlocBuilder<ChangeStatusOrderBloc, ChangeStatusOrderState>(
  //           builder: (_, statusState) {
  //             if (orderState is PreOrderType) {
  //               if (statusState is ChangeStatusToProcess) {
  //                 return GestureDetector(
  //                   onTap: () async => _onPressedOnGoingOrderCard(
  //                     (userState is UserLoaded) ? userState.user.uid : '',
  //                   ),
  //                   child: CardOngoingOrder(
  //                     uid: (userState is UserLoaded) ? userState.user.uid : '',
  //                     orderType: 'Pre-Order',
  //                   ),
  //                 );
  //               } else if (statusState is ChangeStatusToDone) {
  //                 return GestureDetector(
  //                   onTap: () async => _onPressedOnGoingOrderCard(
  //                     (userState is UserLoaded) ? userState.user.uid : '',
  //                   ),
  //                   child: CardSuccessOrder(
  //                     uid: (userState is UserLoaded) ? userState.user.uid : '',
  //                     orderType: 'Pre-Order',
  //                   ),
  //                 );
  //               } else {
  //                 return _noOrder();
  //               }
  //             } else if (orderState is DeliveryType) {
  //               if (statusState is ChangeStatusToProcess) {
  //                 return GestureDetector(
  //                   onTap: () async => _onPressedOnGoingOrderDeliveryCard(
  //                     (userState is UserLoaded) ? userState.user.uid : '',
  //                     (locState is LoadSelectedOutletLatLng)
  //                         ? locState.outletLatLng
  //                         : LatLng(0, 0),
  //                     (locState is LoadSelectedOutletLatLng)
  //                         ? locState.userLoc
  //                         : LatLng(0, 0),
  //                   ),
  //                   child: CardOngoingOrder(
  //                     uid: (userState is UserLoaded) ? userState.user.uid : '',
  //                     orderType: 'Delivery',
  //                   ),
  //                 );
  //               } else if (statusState is ChangeStatusToDone) {
  //                 return GestureDetector(
  //                   onTap: () async => _onPressedOnGoingOrderDeliveryCard(
  //                     (userState is UserLoaded) ? userState.user.uid : '',
  //                     (locState is LoadSelectedOutletLatLng)
  //                         ? locState.outletLatLng
  //                         : LatLng(0, 0),
  //                     (locState is LoadSelectedOutletLatLng)
  //                         ? locState.userLoc
  //                         : LatLng(0, 0),
  //                   ),
  //                   child: CardSuccessOrder(
  //                     uid: (userState is UserLoaded) ? userState.user.uid : '',
  //                     orderType: 'Delivery',
  //                   ),
  //                 );
  //               } else {
  //                 return _noOrder();
  //               }
  //             } else {
  //               return _noOrder();
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _onPressedOnGoingOrderDeliveryCard(
    String id,
    LatLng outletLoc,
    LatLng userLoc,
  ) async {
    context.read<CheckoutSelectedOutletLatlngBloc>().add(
          GetSelectedOutletLatLng(id),
        );

    context.read<ListOrderCheckoutCupBloc>().add(GetListCheckoutOrderCup(id));

    context.read<ListOrderCheckoutBottleBloc>().add(
          GetListCheckoutOrderBottle(id),
        );

    context.read<ListOrderCheckoutHotBloc>().add(GetListCheckoutOrderHot(id));

    context.read<CheckoutDeliveryDataBloc>().add(
          GetCheckoutDeliveryOrderData(id),
        );

    context.read<PageBloc>().add(
          GoToCartCheckoutDeliveryPage(
            outletLoc,
            userLoc,
            GoToHomePage(1, selectedOrder: 'Sedang Diproses'),
          ),
        );
  }

  void _onPressedOnGoingOrderCard(String id) async {
    context.read<ListOrderCheckoutCupBloc>().add(GetListCheckoutOrderCup(id));

    context.read<ListOrderCheckoutBottleBloc>().add(
          GetListCheckoutOrderBottle(id),
        );

    context.read<ListOrderCheckoutHotBloc>().add(GetListCheckoutOrderHot(id));

    context.read<CheckoutPreorderDataBloc>().add(GetCheckoutPreOrderData(id));

    context.read<PageBloc>().add(
          GoToCartCheckoutPage(
            GoToHomePage(1, selectedOrder: 'Sedang Diproses'),
          ),
        );
  }

  void _onPressedHostoryOrderDeliveryCard(
    String id,
    String orderTypeID,
    String? orderID, {
    String? orderType = '',
    String? outlet = '',
    String? address = '',
    String distance = '',
    String? deliveryFee = '',
  }) async {
    context.read<ListHitoryOrderBottleBloc>().add(
          GetHistoryOrderBottleOrder(id, orderID),
        );

    context.read<ListHitoryOrderCupBloc>().add(
          GetHistoryOrderCupOrder(id, orderID),
        );

    context.read<ListHitoryOrderHotBloc>().add(
          GetHistoryOrderHotOrder(id, orderID),
        );

    context.read<PageBloc>().add(GoToHistoryOrderDetailPage(
          'Delivery',
          detailHistoryOrderDeliveryType: DetailHistoryOrderDeliveryType(
            address: address,
            deliveryFee: deliveryFee,
            distance: distance,
            orderType: orderType,
            outlet: outlet,
            orderID: orderTypeID,
          ),
        ));
  }

  void _onPressedHistoryOrderCard(
    String orderTypeID,
    String id,
    String? orderID, {
    String? orderType = '',
    String? outlet = '',
    String? pickupTime = '',
    int? totalPrice = 0,
  }) async {
    context.read<ListHitoryOrderBottleBloc>().add(
          GetHistoryOrderBottleOrder(id, orderID),
        );

    context.read<ListHitoryOrderCupBloc>().add(
          GetHistoryOrderCupOrder(id, orderID),
        );

    context.read<ListHitoryOrderHotBloc>().add(
          GetHistoryOrderHotOrder(id, orderID),
        );

    context.read<HistoryOrderListBloc>().add(GetHistoryOrderList(id));

    context.read<PageBloc>().add(GoToHistoryOrderDetailPage(
          'Pre-Order',
          detailHistoryOrderType: DetailHistoryOrderType(
            orderType: orderType,
            outlet: outlet,
            pickupTime: pickupTime,
            totalPrice: totalPrice,
            orderID: orderTypeID,
          ),
        ));
  }

  Widget _noOrder() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: height * (verticalMargin)),
        AutoSizeText(
          // 'Kamu belum pesan\napapun, nih.',
          '',
          style: mainFontBlackBold.copyWith(
            fontSize: 24,
            color: ThemeColor.accentColor4,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(height: height * (verticalMargin)),
        Container(
          height: height * .3,
          width: height * .3,
          child: Image.asset('assets/no_order.png', fit: BoxFit.contain),
        ),
      ],
    );
  }

  List<Widget> _generateBottomOrderChategory() {
    return widget.orderCathergory
        .map(
          (e) => BlocBuilder<GuestModeBloc, GuestModeState>(
            builder: (_, guestMode) => BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => GlobalButton(
                fontSize: 16,
                isBorder: selectedOrderCathegory == e,
                title: e,
                width: .42,
                onTapFunc: () {
                  if (guestMode is GuestMode) {
                    setState(() {
                      selectedOrderCathegory = e;
                    });
                  } else {
                    if (e == 'Sedang Diproses') {
                      context.read<StatusOrderBloc>().add(SetOnGoingOrder());

                      context.read<HistoryOrderListBloc>().add(
                            SetHistoryOrderToInitial(),
                          );
                    } else if (e == 'Riwayat Pesanan') {
                      context.read<StatusOrderBloc>().add(SetPastOrder());

                      context.read<HistoryOrderListBloc>().add(
                            GetHistoryOrderList(
                              (userState is UserLoaded)
                                  ? userState.user.uid
                                  : '',
                            ),
                          );
                    }

                    setState(() {
                      selectedOrderCathegory = e;
                    });
                  }
                },
              ),
            ),
          ),
        )
        .toList();
  }
}

class CartDummyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * verticalMargin),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    '',
                    style: mainFontBlackBold.copyWith(fontSize: 24),
                    maxLines: 1,
                  ),
                  SizedBox(height: height * verticalMargin),
                  SizedBox(height: height * 0.06),
                ],
              ),
            ),
            SizedBox(height: height * verticalMargin),
          ],
        ),
      ),
    );
  }
}
