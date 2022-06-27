import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class QueueOrderCheckState extends Equatable {
  const QueueOrderCheckState();
}

class QueueOrderCheckInitial extends QueueOrderCheckState {
  @override
  List<Object?> get props => [];
}

class QueueDeliveryOrderStatus extends QueueOrderCheckState {
  final bool isFull;
  final List<String> listOfFullOutletOrder;

  QueueDeliveryOrderStatus(this.isFull, this.listOfFullOutletOrder);

  @override
  List<Object?> get props => [isFull, listOfFullOutletOrder];
}

// event //
abstract class QueueOrderCheckEvent extends Equatable {
  const QueueOrderCheckEvent();
}

class CheckQueueOrder extends QueueOrderCheckEvent {
  final String? outlet;

  CheckQueueOrder(this.outlet);

  @override
  List<Object?> get props => [outlet];
}

class CheckQeueOrderToInitial extends QueueOrderCheckEvent {
  @override
  List<Object?> get props => [];
}

class QueueOrderCheckBloc
    extends Bloc<QueueOrderCheckEvent, QueueOrderCheckState> {
  QueueOrderCheckBloc() : super(QueueOrderCheckInitial()) {
    on<CheckQueueOrder>((event, emit) async {
      bool isFull =
          await DeliveryService.checkingDeliveryQueueOrder(event.outlet);

      List<String> listOfFullOutletOrder =
          await DeliveryService.chekingFullQueueListOutlet();

      emit(QueueDeliveryOrderStatus(isFull, listOfFullOutletOrder));
    });
    on<CheckQeueOrderToInitial>(
      (event, emit) => emit(QueueOrderCheckInitial()),
    );
  }
}
