part of 'models.dart';

class PreOrderData extends Equatable {
  final String? orderType;
  final String? outlet;
  final String? pickupTime;
  final String? orderID;

  PreOrderData({
    this.orderType = '',
    this.outlet = '',
    this.pickupTime = '',
    this.orderID = '',
  });

  @override
  List<Object?> get props => [orderType, outlet, pickupTime, orderID];
}

class DeliveryOrderData extends Equatable {
  final String? address;
  final String? outlet;
  final String? orderType;
  final String? distance;
  final String? deliveryFee;
  final double? selectedLocationLat;
  final double? selectedLocationLng;
  final String? orderID;

  DeliveryOrderData({
    this.address = '',
    this.orderType = '',
    this.selectedLocationLat = 0,
    this.selectedLocationLng = 0,
    this.distance = '',
    this.deliveryFee = '',
    this.outlet = '',
    this.orderID = '',
  });

  @override
  List<Object?> get props => [
        address,
        outlet,
        distance,
        deliveryFee,
        selectedLocationLat,
        selectedLocationLng,
        orderID,
      ];
}
