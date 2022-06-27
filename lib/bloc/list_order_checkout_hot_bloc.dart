import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCheckoutHotState extends Equatable {
  const ListOrderCheckoutHotState();
}

class ListOrderCheckoutHotInitial extends ListOrderCheckoutHotState {
  @override
  List<Object> get props => [];
}

class LoadListCheckoutOrderHot extends ListOrderCheckoutHotState {
  final List<OrderHotDetail> orderHotDetail;

  LoadListCheckoutOrderHot(this.orderHotDetail);

  @override
  List<Object> get props => [orderHotDetail];
}

// event //
@immutable
abstract class ListOrderCheckoutHotEvent extends Equatable {
  const ListOrderCheckoutHotEvent();
}

class GetListCheckoutOrderHot extends ListOrderCheckoutHotEvent {
  final String id;

  GetListCheckoutOrderHot(this.id);

  @override
  List<Object> get props => [id];
}

class ListCheckoutOrderHotToInitial extends ListOrderCheckoutHotEvent {
  @override
  List<Object> get props => [];
}

class ListOrderCheckoutHotBloc
    extends Bloc<ListOrderCheckoutHotEvent, ListOrderCheckoutHotState> {
  ListOrderCheckoutHotBloc() : super(ListOrderCheckoutHotInitial()) {
    on<GetListCheckoutOrderHot>((event, emit) async {
      List<OrderHotDetail> orderHotDetail =
          await CheckoutOrderService.getCheckoutedOrderHot(event.id);

      emit(LoadListCheckoutOrderHot(orderHotDetail));
    });
    on<ListCheckoutOrderHotToInitial>(
      (event, emit) => emit(ListOrderCheckoutHotInitial()),
    );
  }
}
