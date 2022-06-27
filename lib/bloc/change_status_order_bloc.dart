import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
class ChangeStatusOrderState extends Equatable {
  const ChangeStatusOrderState();

  @override
  List<Object?> get props => [];
}

class ChangeStatusOrderInitial extends ChangeStatusOrderState {
  @override
  List<Object> get props => [];
}

class ChangeStatusToDone extends ChangeStatusOrderState {
  ChangeStatusToDone();

  @override
  List<Object> get props => [];
}

class ChangeStatusToProcess extends ChangeStatusOrderState {
  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class ChangeStatusOrderEvent extends Equatable {
  const ChangeStatusOrderEvent();
}

class SetNewStatusToDone extends ChangeStatusOrderEvent {
  @override
  List<Object> get props => [];
}

class SetNewStatusToProcess extends ChangeStatusOrderEvent {
  @override
  List<Object> get props => [];
}

class SetNewStatusToInitial extends ChangeStatusOrderEvent {
  @override
  List<Object> get props => [];
}

class ChangeStatusOrderBloc
    extends Bloc<ChangeStatusOrderEvent, ChangeStatusOrderState> {
  ChangeStatusOrderBloc() : super(ChangeStatusOrderState()) {
    on<SetNewStatusToDone>((event, emit) => emit(ChangeStatusToDone()));
    on<SetNewStatusToInitial>(
      (event, emit) => emit(ChangeStatusOrderInitial()),
    );
    on<SetNewStatusToProcess>((event, emit) => emit(ChangeStatusToProcess()));
  }
}
