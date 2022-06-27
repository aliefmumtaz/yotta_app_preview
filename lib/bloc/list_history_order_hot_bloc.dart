import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

//  state //
@immutable
abstract class ListHitoryOrderHotState extends Equatable {
  const ListHitoryOrderHotState();
}

class ListHitoryOrderHotInitial extends ListHitoryOrderHotState {
  @override
  List<Object> get props => [];
}

class LoadListHistoryHotOrder extends ListHitoryOrderHotState {
  final List<OrderHotDetail> orderHotDetail;

  LoadListHistoryHotOrder(this.orderHotDetail);

  @override
  List<Object> get props => [orderHotDetail];
}

// event //
@immutable
abstract class ListHitoryOrderHotEvent extends Equatable {
  const ListHitoryOrderHotEvent();
}

class GetHistoryOrderHotOrder extends ListHitoryOrderHotEvent {
  final String id;
  final String? orderID;

  GetHistoryOrderHotOrder(this.id, this.orderID);

  @override
  List<Object> get props => [id];
}

class HistoryOrderHotToInitial extends ListHitoryOrderHotEvent {
  @override
  List<Object> get props => [];
}

class ListHitoryOrderHotBloc
    extends Bloc<ListHitoryOrderHotEvent, ListHitoryOrderHotState> {
  ListHitoryOrderHotBloc() : super(ListHitoryOrderHotInitial()) {
    on<GetHistoryOrderHotOrder>((event, emit) async {
      List<OrderHotDetail> orderHotDetail =
          await HistoryOrderServices.getHistoryOrderHotOrder(
        event.id,
        event.orderID,
      );

      emit(LoadListHistoryHotOrder(orderHotDetail));
    });
    on<HistoryOrderHotToInitial>(
      (event, emit) => emit(ListHitoryOrderHotInitial()),
    );
  }
}
