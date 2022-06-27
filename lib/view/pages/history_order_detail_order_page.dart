part of 'pages.dart';

class HistoryOrderDetailPage extends StatefulWidget {
  final DetailHistoryOrderType? detailHistoryOrderType;
  final DetailHistoryOrderDeliveryType? detailHistoryOrderDeliveryType;
  final String orderType;

  HistoryOrderDetailPage(
    this.orderType, {
    this.detailHistoryOrderType,
    this.detailHistoryOrderDeliveryType,
  });

  @override
  _HistoryOrderDetailPageState createState() => _HistoryOrderDetailPageState();
}

class _HistoryOrderDetailPageState extends State<HistoryOrderDetailPage> {
  void _backButtOnPressed() async {
    context.read<PageBloc>().add(
          GoToHomePage(
            1,
            selectedOrder: 'Riwayat Pesanan',
          ),
        );

    context.read<ListHitoryOrderCupBloc>().add(HistoryOrderCupToInitial());
    context
        .read<ListHitoryOrderBottleBloc>()
        .add(HistoryOrderBottleToInitial());
    context.read<ListHitoryOrderHotBloc>().add(HistoryOrderHotToInitial());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backButtOnPressed();

        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeColor.whiteBackColor,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ThemeColor.whiteBackColor,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  pinned: true,
                  title: _buildAppbar(),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _buildContentList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          BackButtonWidget(
            name: 'Detail Order',
            onTapFunc: () => _backButtOnPressed(),
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          BlocBuilder<ListHitoryOrderCupBloc, ListHitoryOrderCupState>(
              builder: (_, historyCupOrder) {
            if (historyCupOrder is LoadListHistoryCupOrder) {
              return Column(
                children: [
                  Column(
                    children: historyCupOrder.orderCupDetail
                        .map(
                          (e) => CardDetailOrderColdDrink(
                            amount: e.amount,
                            drinkSize: e.cupType,
                            drinkType: e.type,
                            iceLevel: e.iceLevel,
                            productName: e.productName,
                            sizeCupPrice: e.typePrice,
                            sugarLevel: e.sugarLevel,
                            toppingName: e.topping,
                            toppingPrice: e.toppingPrice,
                            totalPrice: e.totalPrice,
                            imgUrl: e.imgUrl,
                          ),
                        )
                        .toList(),
                  ),
                  _buildListOrderHot(),
                  _buildListOrderBottle(),
                  (widget.orderType == 'Pre-Order')
                      ? CardHistoryOrderType(
                          orderID: widget.detailHistoryOrderType!.orderID,
                          orderType: widget.detailHistoryOrderType!.orderType,
                          outlet: widget.detailHistoryOrderType!.outlet,
                          pickupTime: widget.detailHistoryOrderType!.pickupTime,
                          totalPrice: widget.detailHistoryOrderType!.totalPrice,
                        )
                      : CardDeliveryOrderType(
                          orderID:
                              widget.detailHistoryOrderDeliveryType!.orderID,
                          address:
                              widget.detailHistoryOrderDeliveryType!.address,
                          deliveryFee: widget
                              .detailHistoryOrderDeliveryType!.deliveryFee,
                          distance:
                              widget.detailHistoryOrderDeliveryType!.distance,
                          orderType:
                              widget.detailHistoryOrderDeliveryType!.orderType,
                          outlet: widget.detailHistoryOrderDeliveryType!.outlet,
                        ),
                  SizedBox(height: height * verticalMargin),
                  GlobalButton(
                    title: 'Kembali',
                    onTapFunc: () async {
                      _backButtOnPressed();
                    },
                  ),
                  SizedBox(height: defaultMargin),
                ],
              );
            } else {
              return Container(
                height: height * .5,
                child: SpinKitRing(color: ThemeColor.accentColor2, size: 34),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildListOrderHot() {
    return BlocBuilder<ListHitoryOrderHotBloc, ListHitoryOrderHotState>(
      builder: (_, historyHotOrder) {
        if (historyHotOrder is LoadListHistoryHotOrder) {
          return Column(
            children: historyHotOrder.orderHotDetail
                .map(
                  (e) => CardDetailOrderHotDrink(
                    amount: e.amount,
                    drinkType: e.type,
                    productName: e.productName,
                    sugar: e.sugar,
                    totalPrice: e.totalPrice,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildListOrderBottle() {
    return BlocBuilder<ListHitoryOrderBottleBloc, ListHitoryOrderBottleState>(
      builder: (_, historyBottleOrder) {
        if (historyBottleOrder is LoadListHistoryBottleOrder) {
          return Column(
            children: historyBottleOrder.orderBottleDetail
                .map(
                  (e) => CardDetailOrderBottleDrink(
                    amount: e.amount,
                    drinkSize: e.size,
                    drinkType: e.type,
                    productName: e.productName,
                    sizeCupPrice: e.sizePrice,
                    totalPrice: e.totalPrice,
                    sugarLevel: e.sugar,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
