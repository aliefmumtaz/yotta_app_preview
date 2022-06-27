import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
@immutable
abstract class ListOrderTypeState extends Equatable {
  const ListOrderTypeState();
}

class LoadListOrderType extends ListOrderTypeState {
  final List<String> listOrderType;

  LoadListOrderType(this.listOrderType);

  @override
  List<Object> get props => [listOrderType];
}

class ListOrderTypeInitial extends ListOrderTypeState {
  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class ListOrderTypeEvent extends Equatable {
  const ListOrderTypeEvent();
}

class GetListOrderType extends ListOrderTypeEvent {
  final String id;

  GetListOrderType(this.id);

  @override
  List<Object> get props => [id];
}

class ListOrderTypeBloc extends Bloc<ListOrderTypeEvent, ListOrderTypeState> {
  ListOrderTypeBloc() : super(ListOrderTypeInitial());

  Stream<ListOrderTypeState> mapEventToState(
    ListOrderTypeEvent event,
  ) async* {
    // if (event is GetListOrderType) {
    //   List<String> listOrderType =
    //       await HistoryOrderServices.getAllOrderTypeList(event.id);

    //   yield LoadListOrderType(listOrderType);
    // }
  }
}
