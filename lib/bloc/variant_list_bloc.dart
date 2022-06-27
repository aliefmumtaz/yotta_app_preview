import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state
@immutable
class VariantListState extends Equatable {
  const VariantListState();

  @override
  List<Object> get props => [];
}

class LoadVariantData extends VariantListState {
  final List<Variant> variant;

  LoadVariantData(this.variant);
}

class LoadVariantBottleData extends VariantListState {
  final List<BottleVariant> variant;

  LoadVariantBottleData(this.variant);
}

class LoadVariantHotData extends VariantListState {
  final List<HotVariant> variant;

  LoadVariantHotData(this.variant);
}

// event
@immutable
class VariantListEvent extends Equatable {
  const VariantListEvent();

  @override
  List<Object> get props => [];
}

class GetVariantList extends VariantListEvent {
  @override
  List<Object> get props => [];
}

class GetVariantBottleList extends VariantListEvent {
  @override
  List<Object> get props => [];
}

class GetVariantHotList extends VariantListEvent {
  @override
  List<Object> get props => [];
}

class VariantListBloc extends Bloc<VariantListEvent, VariantListState> {
  VariantListBloc() : super(VariantListState()) {
    on<GetVariantList>((event, emit) async {
      List<Variant> listVariant = await MenuServices.getVariantList();

      emit(LoadVariantData(listVariant));
    });
    on<GetVariantBottleList>((event, emit) async {
      List<BottleVariant> listBottleVariant =
          await MenuServices.getBottleVariantList();

      emit(LoadVariantBottleData(listBottleVariant));
    });
    on<GetVariantHotList>((event, emit) async {
      List<HotVariant> listHotVariant =
          await MenuServices.getHotMenuVariantList();

      emit(LoadVariantHotData(listHotVariant));
    });
    on<VariantListEvent>((event, emit) => emit(VariantListState()));
  }
}
