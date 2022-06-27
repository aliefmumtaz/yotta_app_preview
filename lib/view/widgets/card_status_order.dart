part of 'widgets.dart';

class CardStatusOrderSucess extends StatefulWidget {
  final String? orderType;
  final String? pickupTime;
  final String? deliveryOutlet;

  CardStatusOrderSucess({
    required this.orderType,
    required this.pickupTime,
    required this.deliveryOutlet,
  });
  @override
  _CardStatusOrderSucessState createState() => _CardStatusOrderSucessState();
}

class _CardStatusOrderSucessState extends State<CardStatusOrderSucess> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<CheckoutSelectedOutletLatlngBloc,
        CheckoutSelectedOutletLatlngState>(
      builder: (_, locState) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
        builder: (_, orderState) => BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => GestureDetector(
            onTap: () async {
              context.read<ListOrderCheckoutCupBloc>().add(
                    GetListCheckoutOrderCup(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              context.read<ListOrderCheckoutBottleBloc>().add(
                    GetListCheckoutOrderBottle(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              context.read<ListOrderCheckoutHotBloc>().add(
                    GetListCheckoutOrderHot(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              if (orderState is DeliveryType) {
                context.read<CheckoutDeliveryDataBloc>().add(
                      GetCheckoutDeliveryOrderData(
                        (userState is UserLoaded) ? userState.user.uid : '',
                      ),
                    );

                context.read<PageBloc>().add(
                      GoToCartCheckoutDeliveryPage(
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.outletLatLng
                            : LatLng(0, 0),
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.userLoc
                            : LatLng(0, 0),
                        GoToHomePage(0, selectedOrder: 'Sedang Diproses'),
                      ),
                    );
              } else {
                context.read<CheckoutPreorderDataBloc>().add(
                      GetCheckoutPreOrderData(
                        (userState is UserLoaded) ? userState.user.uid : '',
                      ),
                    );

                context.read<PageBloc>().add(
                      GoToCartCheckoutPage(GoToHomePage(0)),
                    );
              }
            },
            child: BlocBuilder<CheckoutDeliveryDataBloc,
                CheckoutDeliveryDataState>(
              builder: (_, deliveryDataState) => BlocBuilder<
                  CheckoutPreorderDataBloc, CheckoutPreorderDataState>(
                builder: (_, preOrderDataState) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                    color: ThemeColor.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height * verticalMargin),
                      StatusText(
                        isHighlight: false,
                        statusText: 'Pesanan kamu sedang diproses',
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      StatusText(
                        isHighlight: true,
                        statusText: (widget.orderType == 'Delivery')
                            ? 'Pesanan kamu lagi diantar'
                            : 'Pesanan kamu siap diambil',
                      ),
                      SizedBox(height: height * verticalMargin),
                      OrderCategory(
                        orderCategory: (widget.orderType == 'Delivery')
                            ? 'Delivery'
                            : 'Pre-Order',
                        isHighlight: true,
                        desc: (widget.orderType == 'Delivery')
                            ? 'Outlet Pengantaran - ${widget.deliveryOutlet}'
                            : 'Waktu pengambilan - ${widget.pickupTime}',
                      ),
                      SizedBox(height: height * verticalMargin),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardStatusOrderOnProcess extends StatefulWidget {
  final String? orderType;
  final String? pickupTime;
  final String? deliveryOutlet;

  CardStatusOrderOnProcess({
    required this.orderType,
    required this.pickupTime,
    required this.deliveryOutlet,
  });

  @override
  _CardStatusOrderOnProcessState createState() =>
      _CardStatusOrderOnProcessState();
}

class _CardStatusOrderOnProcessState extends State<CardStatusOrderOnProcess> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<CheckoutSelectedOutletLatlngBloc,
        CheckoutSelectedOutletLatlngState>(
      builder: (_, locState) => BlocBuilder<OrderTypeBloc, OrderTypeState>(
        builder: (_, orderState) => BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => GestureDetector(
            onTap: () async {
              context.read<ListOrderCheckoutCupBloc>().add(
                    GetListCheckoutOrderCup(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              context.read<ListOrderCheckoutBottleBloc>().add(
                    GetListCheckoutOrderBottle(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              context.read<ListOrderCheckoutHotBloc>().add(
                    GetListCheckoutOrderHot(
                      (userState is UserLoaded) ? userState.user.uid : '',
                    ),
                  );

              if (orderState is DeliveryType) {
                context.read<CheckoutDeliveryDataBloc>().add(
                      GetCheckoutDeliveryOrderData(
                        (userState is UserLoaded) ? userState.user.uid : '',
                      ),
                    );

                context.read<PageBloc>().add(
                      GoToCartCheckoutDeliveryPage(
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.outletLatLng
                            : LatLng(0, 0),
                        (locState is LoadSelectedOutletLatLng)
                            ? locState.userLoc
                            : LatLng(0, 0),
                        GoToHomePage(0, selectedOrder: 'Sedang Diproses'),
                      ),
                    );
              } else {
                context.read<CheckoutPreorderDataBloc>().add(
                      GetCheckoutPreOrderData(
                        (userState is UserLoaded) ? userState.user.uid : '',
                      ),
                    );

                context.read<PageBloc>().add(
                      GoToCartCheckoutPage(GoToHomePage(0)),
                    );
              }
            },
            child: BlocBuilder<CheckoutDeliveryDataBloc,
                CheckoutDeliveryDataState>(
              builder: (_, deliveryDataState) => BlocBuilder<
                  CheckoutPreorderDataBloc, CheckoutPreorderDataState>(
                builder: (_, preOrderDataState) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                    color: ThemeColor.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height * verticalMargin),
                      StatusText(
                        isHighlight: true,
                        statusText: 'Pesanan kamu sedang diproses',
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      StatusText(
                        isHighlight: false,
                        statusText: (widget.orderType == 'Delivery')
                            ? 'Pesanan kamu lagi diantar'
                            : 'Pesanan kamu siap diambil',
                      ),
                      SizedBox(height: height * verticalMargin),
                      OrderCategory(
                        orderCategory: (widget.orderType == 'Delivery')
                            ? 'Delivery'
                            : 'Pre-Order',
                        isHighlight: true,
                        desc: (widget.orderType == 'Delivery')
                            ? 'Outlet Pengantaran - ${widget.deliveryOutlet}'
                            : 'Waktu pengambilan - ${widget.pickupTime}',
                      ),
                      SizedBox(height: height * verticalMargin),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  final bool isHighlight;
  final String statusText;

  StatusText({required this.isHighlight, required this.statusText});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: defaultMargin / 2),
          height: height * .015,
          width: height * .015,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (!isHighlight) ? ThemeColor.mainColorAccent : Colors.white,
          ),
        ),
        Container(
          width: width * .65,
          child: AutoSizeText(
            '$statusText',
            style: mainFontWhiteBold.copyWith(
              fontSize: 16,
              color: (!isHighlight) ? ThemeColor.mainColorAccent : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class OrderCategory extends StatelessWidget {
  final String orderCategory;
  final String desc;
  final bool isHighlight;

  OrderCategory({
    required this.orderCategory,
    required this.desc,
    required this.isHighlight,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          height: height * .07,
          width: height * .07,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: defaultMargin / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (orderCategory == 'Delivery')
                    ? AssetImage('assets/icon_delivery.png')
                    : AssetImage('assets/icon_pre-order.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              orderCategory,
              style: accentFontWhiteBold.copyWith(
                color:
                    (isHighlight) ? Colors.white : ThemeColor.mainColorAccent,
                fontSize: 14,
              ),
            ),
            SizedBox(height: height * verticalMarginHalf / 2),
            AutoSizeText(
              desc,
              style: accentFontWhiteRegular.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
