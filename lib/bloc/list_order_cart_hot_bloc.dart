import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOrderCartHotState extends Equatable {
  const ListOrderCartHotState();
}

class ListOrderCartHotInitial extends ListOrderCartHotState {
  @override
  List<Object> get props => [];
}

class LoadListOrderCartHot extends ListOrderCartHotState {
  final List<OrderHotDetail> orderHotDetail;

  LoadListOrderCartHot(this.orderHotDetail);

  @override
  List<Object> get props => [orderHotDetail];
}

// event //
@immutable
abstract class ListOrderCartHotEvent extends Equatable {
  const ListOrderCartHotEvent();
}

class GetListOrderCartHot extends ListOrderCartHotEvent {
  final String id;

  GetListOrderCartHot(this.id);

  @override
  List<Object> get props => [id];
}

class ListOrderCartHotToInitial extends ListOrderCartHotEvent {
  @override
  List<Object> get props => [];
}

class ListOrderCartHotBloc
    extends Bloc<ListOrderCartHotEvent, ListOrderCartHotState> {
  ListOrderCartHotBloc() : super(ListOrderCartHotInitial()) {
    on<GetListOrderCartHot>((event, emit) async {
      List<OrderHotDetail> _orderHotList =
          await SelectedOrderServices.getSelectedOrderHotList(event.id);

      emit(LoadListOrderCartHot(_orderHotList));
    });
    on<ListOrderCartHotToInitial>(
      (event, emit) => emit(ListOrderCartHotInitial()),
    );
  }
}
