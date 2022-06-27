import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCheckoutBottleState extends Equatable {
  const ListOrderCheckoutBottleState();
}

class ListOrderCheckoutBottleInitial extends ListOrderCheckoutBottleState {
  @override
  List<Object> get props => [];
}

class LoadListCheckoutOrderBottle extends ListOrderCheckoutBottleState {
  final List<OrderBottleDetail> orderBottleDetail;

  LoadListCheckoutOrderBottle(this.orderBottleDetail);

  @override
  List<Object> get props => [orderBottleDetail];
}

// event //
@immutable
abstract class ListOrderCheckoutBottleEvent extends Equatable {
  const ListOrderCheckoutBottleEvent();
}

class ListCheckoutOrerBottleToInitial extends ListOrderCheckoutBottleEvent {
  @override
  List<Object> get props => [];
}

class GetListCheckoutOrderBottle extends ListOrderCheckoutBottleEvent {
  final String id;

  GetListCheckoutOrderBottle(this.id);

  @override
  List<Object> get props => [id];
}

class ListOrderCheckoutBottleBloc
    extends Bloc<ListOrderCheckoutBottleEvent, ListOrderCheckoutBottleState> {
  ListOrderCheckoutBottleBloc() : super(ListOrderCheckoutBottleInitial()) {
    on<GetListCheckoutOrderBottle>((event, emit) async {
      List<OrderBottleDetail> orderBottleDetail =
          await CheckoutOrderService.getCheckoutOrderBottle(event.id);

      emit(LoadListCheckoutOrderBottle(orderBottleDetail));
    });
    on<ListCheckoutOrerBottleToInitial>(
      (event, emit) => emit(ListOrderCheckoutBottleInitial()),
    );
  }
}
