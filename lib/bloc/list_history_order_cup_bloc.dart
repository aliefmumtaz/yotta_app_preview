import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

//  state //
@immutable
abstract class ListHitoryOrderCupState extends Equatable {
  const ListHitoryOrderCupState();
}

class ListHitoryOrderCupInitial extends ListHitoryOrderCupState {
  @override
  List<Object> get props => [];
}

class LoadListHistoryCupOrder extends ListHitoryOrderCupState {
  final List<OrderCupDetail> orderCupDetail;

  LoadListHistoryCupOrder(this.orderCupDetail);

  @override
  List<Object> get props => [orderCupDetail];
}

// event //
@immutable
abstract class ListHitoryOrderCupEvent extends Equatable {
  const ListHitoryOrderCupEvent();
}

class GetHistoryOrderCupOrder extends ListHitoryOrderCupEvent {
  final String id;
  final String? orderID;

  GetHistoryOrderCupOrder(this.id, this.orderID);

  @override
  List<Object> get props => [id];
}

class HistoryOrderCupToInitial extends ListHitoryOrderCupEvent {
  @override
  List<Object> get props => [];
}

class ListHitoryOrderCupBloc
    extends Bloc<ListHitoryOrderCupEvent, ListHitoryOrderCupState> {
  ListHitoryOrderCupBloc() : super(ListHitoryOrderCupInitial()) {
    on<GetHistoryOrderCupOrder>((event, emit) async {
      List<OrderCupDetail> orderCupDetail =
          await HistoryOrderServices.getHistoryOrderCupOrder(
        event.id,
        event.orderID,
      );

      emit(LoadListHistoryCupOrder(orderCupDetail));
    });
    on<HistoryOrderCupToInitial>(
      (event, emit) => emit(ListHitoryOrderCupInitial()),
    );
  }
}
