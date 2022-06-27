import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class HistoryOrderState extends Equatable {
  const HistoryOrderState();
}

class HistoryOrderInitial extends HistoryOrderState {
  @override
  List<Object> get props => [];
}

class StoreDataSuccessOrder extends HistoryOrderState {
  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class HistoryOrderEvent extends Equatable {
  const HistoryOrderEvent();
}

class SetDataOrderToHistory extends HistoryOrderEvent {
  final String id;
  final bool isDelivery;
  final User? user;
  final String orderID;

  SetDataOrderToHistory(this.id, this.isDelivery, this.user, this.orderID);

  @override
  List<Object> get props => [id, isDelivery, user!, orderID];
}


class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  HistoryOrderBloc() : super(HistoryOrderInitial()) {
    on<SetDataOrderToHistory>((event, emit) async {
      await HistoryOrderServices.checkoutDrinkListToHistoryOrder(
        event.id,
        event.isDelivery,
        event.user!,
        event.orderID,
      );

      await CheckoutOrderService.deleteCheckoutListOrder(event.id);

      emit(StoreDataSuccessOrder());
    });
  }
}
