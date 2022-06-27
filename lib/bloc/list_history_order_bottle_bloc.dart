import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

//  state //
@immutable
abstract class ListHitoryOrderBottleState extends Equatable {
  const ListHitoryOrderBottleState();
}

class ListHitoryOrderBottleInitial extends ListHitoryOrderBottleState {
  @override
  List<Object> get props => [];
}

class LoadListHistoryBottleOrder extends ListHitoryOrderBottleState {
  final List<OrderBottleDetail> orderBottleDetail;

  LoadListHistoryBottleOrder(this.orderBottleDetail);

  @override
  List<Object> get props => [orderBottleDetail];
}

// event //
@immutable
abstract class ListHitoryOrderBottleEvent extends Equatable {
  const ListHitoryOrderBottleEvent();
}

class GetHistoryOrderBottleOrder extends ListHitoryOrderBottleEvent {
  final String id;
  final String? orderID;

  GetHistoryOrderBottleOrder(this.id, this.orderID);

  @override
  List<Object> get props => [id];
}

class HistoryOrderBottleToInitial extends ListHitoryOrderBottleEvent {
  @override
  List<Object> get props => [];
}

class ListHitoryOrderBottleBloc
    extends Bloc<ListHitoryOrderBottleEvent, ListHitoryOrderBottleState> {
  ListHitoryOrderBottleBloc() : super(ListHitoryOrderBottleInitial()) {
    on<GetHistoryOrderBottleOrder>((event, emit) async {
      List<OrderBottleDetail> orderBottleDetail =
          await HistoryOrderServices.getHistoryOrderBottleOrder(
        event.id,
        event.orderID,
      );

      emit(LoadListHistoryBottleOrder(orderBottleDetail));
    });
    on<HistoryOrderBottleToInitial>(
      (event, emit) => emit(ListHitoryOrderBottleInitial()),
    );
  }
}
