import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCheckoutCupState extends Equatable {
  const ListOrderCheckoutCupState();
}

class ListOrderCheckoutCupInitial extends ListOrderCheckoutCupState {
  @override
  List<Object> get props => [];
}

class LoadListCheckoutOrderCup extends ListOrderCheckoutCupState {
  final List<OrderCupDetail> orderCupDetail;

  LoadListCheckoutOrderCup(this.orderCupDetail);

  @override
  List<Object> get props => [orderCupDetail];
}

// event //
@immutable
abstract class ListOrderCheckoutCupEvent extends Equatable {
  const ListOrderCheckoutCupEvent();
}

class GetListCheckoutOrderCup extends ListOrderCheckoutCupEvent {
  final String id;

  GetListCheckoutOrderCup(this.id);

  @override
  List<Object> get props => [id];
}

class ListCheckoutOrderCupToInitial extends ListOrderCheckoutCupEvent {
  @override
  List<Object> get props => [];
}

class ListOrderCheckoutCupBloc
    extends Bloc<ListOrderCheckoutCupEvent, ListOrderCheckoutCupState> {
  ListOrderCheckoutCupBloc() : super(ListOrderCheckoutCupInitial()) {
    on<GetListCheckoutOrderCup>((event, emit) async {
      List<OrderCupDetail> orderCupDetail =
          await CheckoutOrderService.getCheckoutedOrderCup(event.id);

      emit(LoadListCheckoutOrderCup(orderCupDetail));
    });
    on<ListCheckoutOrderCupToInitial>(
      (event, emit) => emit(ListOrderCheckoutCupInitial()),
    );
  }
}
