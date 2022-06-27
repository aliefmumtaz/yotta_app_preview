import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCartBottleState extends Equatable {
  const ListOrderCartBottleState();
}

class ListOrderCartBottleInitial extends ListOrderCartBottleState {
  @override
  List<Object> get props => [];
}

class LoadListOrderCartBottleDrink extends ListOrderCartBottleState {
  final List<OrderBottleDetail> orderBottleDetail;

  LoadListOrderCartBottleDrink(this.orderBottleDetail);

  @override
  List<Object> get props => [orderBottleDetail];
}

// event //
@immutable
abstract class ListOrderCartBottleEvent extends Equatable {
  const ListOrderCartBottleEvent();
}

class GetListOrderCartBottleDrink extends ListOrderCartBottleEvent {
  final String id;

  GetListOrderCartBottleDrink(this.id);

  @override
  List<Object> get props => [id];
}

class ListOrderCartBottleDrinkToInitial extends ListOrderCartBottleEvent {
  @override
  List<Object> get props => [];
}

class ListOrderCartBottleBloc
    extends Bloc<ListOrderCartBottleEvent, ListOrderCartBottleState> {
  ListOrderCartBottleBloc() : super(ListOrderCartBottleInitial()) {
    on<GetListOrderCartBottleDrink>((event, emit) async {
      List<OrderBottleDetail> orderBottleDetail =
          await SelectedOrderServices.getSelectedOrderBottleList(event.id);

      emit(LoadListOrderCartBottleDrink(orderBottleDetail));
    });
    on<ListOrderCartBottleDrinkToInitial>(
      (event, emit) => emit(ListOrderCartBottleInitial()),
    );
  }
}
