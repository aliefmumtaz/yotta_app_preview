part of 'models.dart';

class OngoingOrder extends Equatable {
  final OrderCupDetail? orderCupDetail;
  final OrderBottleDetail? orderBottleDetail;
  final OrderHotDetail? orderHotDetail;
  final PreOrderData? preOrderData;

  OngoingOrder({
    this.orderBottleDetail,
    this.orderCupDetail,
    this.orderHotDetail,
    this.preOrderData,
  });

  @override
  List<Object?> get props => [
        orderBottleDetail,
        orderCupDetail,
        orderHotDetail,
        preOrderData,
      ];
}
