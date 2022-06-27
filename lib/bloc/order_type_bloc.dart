import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class OrderTypeState extends Equatable {
  const OrderTypeState();
}

class OrderTypeInitial extends OrderTypeState {
  @override
  List<Object> get props => [];
}

class DeliveryType extends OrderTypeState {
  @override
  List<Object> get props => [];
}

class PreOrderType extends OrderTypeState {
  @override
  List<Object> get props => [];
}

@immutable
abstract class OrderTypeEvent extends Equatable {
  const OrderTypeEvent();
}

class OrderTypeToInitial extends OrderTypeEvent {
  @override
  List<Object> get props => [];
}

class DeliveryOrder extends OrderTypeEvent {
  @override
  List<Object> get props => [];
}

class PreOrder extends OrderTypeEvent {
  @override
  List<Object> get props => [];
}

class OrderTypeBloc extends Bloc<OrderTypeEvent, OrderTypeState> {
  OrderTypeBloc() : super(OrderTypeInitial()) {
    on<DeliveryOrder>((event, emit) => emit(DeliveryType()));
    on<PreOrder>((event, emit) => emit(PreOrderType()));
    on<OrderTypeToInitial>((event, emit) => emit(OrderTypeInitial()));
  }
}
