part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class MenuToInitial extends MenuEvent {
  @override
  List<Object> get props => [];
}

class LoadMenuPerVariant extends MenuEvent {
  final String? varianName;
  final String? outlet;

  LoadMenuPerVariant(this.varianName, this.outlet);

  @override
  List<Object?> get props => [varianName, outlet];
}

class LoadMenuBottlePerVariant extends MenuEvent {
  final String? varianName;
  final String? outlet;

  LoadMenuBottlePerVariant(this.varianName, this.outlet);

  @override
  List<Object?> get props => [varianName, outlet];
}

class LoadHotMenuPerVariant extends MenuEvent {
  final String? variantName;
  final String? outlet;

  LoadHotMenuPerVariant(this.variantName, this.outlet);

  @override
  List<Object?> get props => [variantName, outlet];
}
