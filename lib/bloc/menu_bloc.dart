import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<LoadMenuPerVariant>((event, emit) async {
      List<MenuPerVariant> menuPerVariantList =
          await MenuServices.getMenuPerVariant(
        event.varianName,
        event.outlet,
      );

      emit(MenuPerVariantLoaded(menuPerVariantList));
    });
    on<MenuToInitial>((event, emit) => emit(MenuInitial()));
    on<LoadMenuBottlePerVariant>((event, emit) async {
      List<MenuBottlePerVariant> menuPerVariant =
          await MenuServices.getMenuBottlePerVariant(
        event.varianName,
        event.outlet,
      );

      emit(MenuBottlePerVariantLoaded(menuPerVariant));
    });
    on<LoadHotMenuPerVariant>((event, emit) async {
      List<HotMenuPerVariant> menuPerVariant =
          await MenuServices.getHotMenuPerVariant(
        event.variantName,
        event.outlet,
      );

      emit(HotMenuPerVariantLoaded(menuPerVariant));
    });
  }
}
