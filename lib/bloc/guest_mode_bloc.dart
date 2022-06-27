import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// state //
abstract class GuestModeState extends Equatable {
  const GuestModeState();
}

class GuestModeInitial extends GuestModeState {
  @override
  List<Object?> get props => [];
}

class GuestMode extends GuestModeState {
  @override
  List<Object?> get props => [];
}

// event //
abstract class GuestModeEvent extends Equatable {
  const GuestModeEvent();
}

class SetGuestMode extends GuestModeEvent {
  @override
  List<Object?> get props => [];
}

class SetGuestModeToInitial extends GuestModeEvent {
  @override
  List<Object?> get props => [];
}


class GuestModeBloc extends Bloc<GuestModeEvent, GuestModeState> {
  GuestModeBloc() : super(GuestModeInitial()) {
    on<SetGuestMode>((event, emit) => emit(GuestMode()));
    on<SetGuestModeToInitial>((event, emit) => emit(GuestModeInitial()));
  }
}
