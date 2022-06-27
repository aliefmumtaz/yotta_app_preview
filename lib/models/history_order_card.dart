part of 'models.dart';

class HistoryOrderDelivery extends Equatable {
  final String productName;
  final String? orderDate;
  final String? orderType;
  final String? orderDocID;
  final String? outlet;
  final int? totalPrice;
  final String? address;
  final String? deliveryFee;
  final String? distance;
  final String? orderID;

  HistoryOrderDelivery({
    required this.orderID,
    this.productName = '',
    this.orderDate = '',
    this.orderType = '',
    this.orderDocID = '',
    this.outlet = '',
    this.totalPrice = 0,
    this.address = '',
    this.deliveryFee = '',
    this.distance = '',
  });

  @override
  List<Object> get props => [
        productName,
        orderDate!,
        orderType!,
        orderDocID!,
        outlet!,
        totalPrice!,
        address!,
        deliveryFee!,
        distance!,
        orderID!,
      ];
}

class HistoryOrder extends Equatable {
  final String productName;
  final String? orderDate;
  final String? orderType;
  final String imgUrl;
  final String? orderDocID;
  final String? outlet;
  final int? totalPrice;
  final String? pickupTime;
  final String? orderID;

  HistoryOrder({
    required this.orderID,
    this.imgUrl = '',
    this.orderDate = '',
    this.orderType = '',
    this.productName = '',
    this.orderDocID = '',
    this.outlet = '',
    this.pickupTime = '',
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [
        imgUrl,
        orderDate,
        orderType,
        productName,
        orderDocID,
        outlet,
        totalPrice,
        pickupTime,
        orderID,
      ];
}

class DetailHistoryOrderDeliveryType extends Equatable {
  final String? outlet;
  final String? orderType;
  final String? address;
  final String? distance;
  final String? deliveryFee;
  final String? orderID;

  DetailHistoryOrderDeliveryType({
    required this.orderID,
    this.address,
    this.deliveryFee,
    this.distance,
    this.orderType,
    this.outlet,
  });

  @override
  List<Object?> get props => [
        address,
        orderID,
        deliveryFee,
        distance,
        orderType,
        outlet,
      ];
}

class DetailHistoryOrderType extends Equatable {
  final String? outlet;
  final String? orderType;
  final String? pickupTime;
  final int? totalPrice;
  final String? orderID;

  DetailHistoryOrderType({
    required this.orderID,
    this.orderType,
    this.outlet,
    this.pickupTime,
    this.totalPrice,
  });

  @override
  List<Object?> get props => [
        orderType,
        outlet,
        pickupTime,
        totalPrice,
        orderID,
      ];
}
