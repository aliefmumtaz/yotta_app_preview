import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCartColdState extends Equatable {
  const ListOrderCartColdState();
}

class ListOrderCartColdInitial extends ListOrderCartColdState {
  @override
  List<Object> get props => [];
}

class LoadListOrderCartColdDrink extends ListOrderCartColdState {
  final List<OrderCupDetail> orderCupDetail;

  LoadListOrderCartColdDrink(this.orderCupDetail);

  @override
  List<Object> get props => [orderCupDetail];
}

// event //
@immutable
abstract class ListOrderCartColdEvent extends Equatable {
  const ListOrderCartColdEvent();
}

class GetListOrderCartColdDrink extends ListOrderCartColdEvent {
  final String id;

  GetListOrderCartColdDrink(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteListOrderCartColdDrink extends ListOrderCartColdEvent {
  final String id;

  DeleteListOrderCartColdDrink(this.id);

  @override
  List<Object> get props => throw UnimplementedError();
}

class ListOrderCartColdDrinkToInitial extends ListOrderCartColdEvent {
  @override
  List<Object> get props => [];
}

class ListOrderCartColdBloc
    extends Bloc<ListOrderCartColdEvent, ListOrderCartColdState> {
  ListOrderCartColdBloc() : super(ListOrderCartColdInitial()) {
    on<GetListOrderCartColdDrink>((event, emit) async {
      List<OrderCupDetail> orderCupDetailList =
          await SelectedOrderServices.getSelectedOrderCupList(event.id);

      emit(LoadListOrderCartColdDrink(orderCupDetailList));
    });
    on<DeleteListOrderCartColdDrink>((event, emit) async {
      await SelectedOrderServices.deleteOrderList(event.id);

      emit(ListOrderCartColdInitial());
    });
    on<ListOrderCartColdDrinkToInitial>(
      (event, emit) => emit(ListOrderCartColdInitial()),
    );
  }
}
