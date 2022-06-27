part of 'models.dart';

class IceType extends Equatable {
  final String? name;

  IceType({this.name});

  @override
  List<Object?> get props => [name];
}

class Topping extends Equatable {
  final String? name;
  final int? price;
  final String? img;

  Topping({this.name, this.price = 0, this.img = '-'});

  @override
  List<Object?> get props => [name, price, img];
}

class SugarType extends Equatable {
  final String? name;

  SugarType({this.name});

  @override
  List<Object?> get props => [name];
}
