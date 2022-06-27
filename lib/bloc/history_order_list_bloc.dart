import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class HistoryOrderListState extends Equatable {
  const HistoryOrderListState();
}

class HistoryOrderListInitial extends HistoryOrderListState {
  @override
  List<Object> get props => [];
}

class LoadHistoryOrderList extends HistoryOrderListState {
  final List<HistoryOrder> historyOrderList;
  final List<HistoryOrderDelivery> historyOrderDeliveryList;

  LoadHistoryOrderList(this.historyOrderList, this.historyOrderDeliveryList);

  @override
  List<Object> get props => [historyOrderList, historyOrderDeliveryList];
}

//  event //
@immutable
abstract class HistoryOrderListEvent extends Equatable {
  const HistoryOrderListEvent();
}

class GetHistoryOrderList extends HistoryOrderListEvent {
  final String id;

  GetHistoryOrderList(this.id);

  @override
  List<Object> get props => [id];
}

class SetHistoryOrderToInitial extends HistoryOrderListEvent {
  @override
  List<Object> get props => [];
}


class HistoryOrderListBloc
    extends Bloc<HistoryOrderListEvent, HistoryOrderListState> {
  HistoryOrderListBloc() : super(HistoryOrderListInitial()) {
    on<GetHistoryOrderList>((event, emit) async {
      List<HistoryOrder> historyOrder =
          await HistoryOrderServices.getHistoryOrderType(event.id);

      List<HistoryOrderDelivery> historyOrderDelivery =
          await HistoryOrderServices.getHistoryOrderDeliveryType(event.id);

      emit(LoadHistoryOrderList(historyOrder, historyOrderDelivery));
    });
    on<SetHistoryOrderToInitial>(
      (event, emit) => emit(HistoryOrderListInitial()),
    );
  }
}
