part of 'models.dart';

class Variant {
  final String? variantName;

  Variant({this.variantName});
}

class BottleVariant {
  final String? variantName;

  BottleVariant({this.variantName});
}

class HotVariant {
  final String? variantName;

  HotVariant({this.variantName});
}

class Menu extends Equatable {
  @required
  final String? name;
  @required
  final int? priceR;
  @required
  final int? priceL;
  @required
  final String? varian;
  @required
  final bool? isAvailable;
  @required
  final bool? isRecommended;
  final String? imgUrl;

  Menu({
    this.name,
    this.priceL,
    this.priceR,
    this.varian,
    this.isAvailable,
    this.isRecommended,
    this.imgUrl,
  });

  @override
  List<Object?> get props => [
        name,
        priceL,
        priceR,
        varian,
        isAvailable,
        isRecommended,
        imgUrl,
      ];
}

class MenuPerVariant {
  final Menu? listMenu;

  MenuPerVariant({this.listMenu});
}

class AllMenu {
  final String? name;
  final List<MenuPerVariant>? allMenuList;

  AllMenu({this.allMenuList, this.name});
}

class BottleMenu extends Equatable {
  @required
  final String? name;
  @required
  final int? ml500;
  @required
  final int? ml1000;
  @required
  final String? varian;
  @required
  final bool? isAvailable;

  BottleMenu({
    this.name,
    this.ml1000,
    this.ml500,
    this.varian,
    this.isAvailable,
  });

  @override
  List<Object?> get props => [name, ml1000, ml500, varian, isAvailable];
}

class MenuBottlePerVariant {
  final BottleMenu? bottleMenu;

  MenuBottlePerVariant({this.bottleMenu});
}

class AllMenuBottle {
  final String? name;
  final List<MenuBottlePerVariant>? allMenuBottleList;

  AllMenuBottle({this.allMenuBottleList, this.name});
}

class HotMenu extends Equatable {
  @required
  final String? name;
  @required
  final String? varian;
  @required
  final int? priceR;
  @required
  final bool? isAvailable;

  HotMenu({
    this.name,
    this.priceR,
    this.varian,
    this.isAvailable,
  });

  @override
  List<Object?> get props => [
        name,
        priceR,
        varian,
        isAvailable,
      ];
}

class HotMenuPerVariant {
  final HotMenu? hotMenu;

  HotMenuPerVariant({this.hotMenu});
}

class AllHotMenu {
  final List<HotMenuPerVariant>? hotMenuPerVariant;
  final String? name;

  AllHotMenu({this.hotMenuPerVariant, this.name});
}
