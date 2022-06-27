import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
@immutable
abstract class StatusOrderState extends Equatable {
  const StatusOrderState();
}

class StatusOrderInitial extends StatusOrderState {
  @override
  List<Object> get props => [];
}

class OnGoingOrder extends StatusOrderState {
  @override
  List<Object> get props => [];
}

class PastOrder extends StatusOrderState {
  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class StatusOrderEvent extends Equatable {
  const StatusOrderEvent();
}

class SetOnGoingOrder extends StatusOrderEvent {
  @override
  List<Object> get props => [];
}

class SetPastOrder extends StatusOrderEvent {
  @override
  List<Object> get props => [];
}

class StatusOrderBloc extends Bloc<StatusOrderEvent, StatusOrderState> {
  StatusOrderBloc() : super(StatusOrderInitial()) {
    on<SetOnGoingOrder>((event, emit) => emit(OnGoingOrder()));
    on<SetPastOrder>((event, emit) => emit(PastOrder()));
  }
}
