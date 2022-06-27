part of 'models.dart';

class ChoosenColdMenu extends Equatable {
  final String? name;
  final String? varian;
  final int? priceR;
  final int? priceL;

  ChoosenColdMenu({
    this.name = '',
    this.priceL = 0,
    this.priceR = 0,
    this.varian = '',
  });

  @override
  List<Object?> get props => [name, priceL, priceR, varian];
}

class ChoosenHotMenu extends Equatable {
  final String? name;
  final String? varian;
  final int? priceR;

  ChoosenHotMenu({this.name, this.priceR, this.varian});

  @override
  List<Object?> get props => [name, priceR, varian];
}

class ChoosenBottleMenu extends Equatable {
  final String? name;
  final String? varian;
  final int? price500ml;
  final int? price1000ml;

  ChoosenBottleMenu({
    this.name = '',
    this.price1000ml = 0,
    this.price500ml = 0,
    this.varian = '',
  });

  @override
  List<Object?> get props => [
        name,
        varian,
        price1000ml,
        price500ml,
      ];
}
