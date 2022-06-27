part of 'menu_bloc.dart';

@immutable
abstract class MenuState extends Equatable {
  const MenuState();
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuPerVariantLoaded extends MenuState {
  final List<MenuPerVariant> menuPerVariant;

  MenuPerVariantLoaded(this.menuPerVariant);

  @override
  List<Object> get props => [menuPerVariant];
}

class MenuBottlePerVariantLoaded extends MenuState {
  final List<MenuBottlePerVariant> menuBottlePerVariant;

  MenuBottlePerVariantLoaded(this.menuBottlePerVariant);

  @override
  List<Object> get props => [];
}

class HotMenuPerVariantLoaded extends MenuState {
  final List<HotMenuPerVariant> hotMenuPerVariant;

  HotMenuPerVariantLoaded(this.hotMenuPerVariant);

  @override
  List<Object> get props => [hotMenuPerVariant];
}
