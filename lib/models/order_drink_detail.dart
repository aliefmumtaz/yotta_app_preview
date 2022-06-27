part of 'models.dart';

class OrderCupDetail extends Equatable {
  final String? productName;
  final String? imgUrl;
  final int? amount;
  final String? type;
  final int? typePrice;
  final String? topping;
  final int? toppingPrice;
  final String? iceLevel;
  final String? sugarLevel;
  final int? totalPrice;
  final String? cupType;

  OrderCupDetail({
    this.amount = 0,
    this.iceLevel = '',
    this.imgUrl = '',
    this.productName = '',
    this.sugarLevel = '',
    this.topping = '',
    this.type = '',
    this.toppingPrice = 0,
    this.typePrice = 0,
    this.totalPrice = 0,
    this.cupType = '',
  });

  @override
  List<Object?> get props => [
        totalPrice,
        typePrice,
        toppingPrice,
        productName,
        imgUrl,
        amount,
        type,
        topping,
        iceLevel,
        sugarLevel,
        cupType,
      ];
}

class OrderBottleDetail extends Equatable {
  final String? productName;
  final int? amount;
  final String? size;
  final int? sizePrice;
  final String? sugar;
  final int? totalPrice;
  final String? type;

  OrderBottleDetail({
    this.amount,
    this.productName,
    this.size,
    this.sizePrice,
    this.sugar,
    this.totalPrice,
    this.type,
  });

  @override
  List<Object?> get props => [
        amount,
        productName,
        size,
        sugar,
        totalPrice,
        type,
      ];
}

class OrderHotDetail extends Equatable {
  final String? productName;
  final int? amount;
  final String? sugar;
  final String? type;
  final int? totalPrice;

  OrderHotDetail({
    this.amount,
    this.productName,
    this.sugar,
    this.totalPrice,
    this.type,
  });

  @override
  List<Object?> get props => [
        amount,
        productName,
        sugar,
        totalPrice,
        type,
      ];
}
