import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
@immutable
abstract class PasswordTempState extends Equatable {
  const PasswordTempState();
}

class PasswordTempInitial extends PasswordTempState {
  @override
  List<Object> get props => [];
}

class LoadPasswordTemp extends PasswordTempState {
  final String password;

  LoadPasswordTemp(this.password);

  @override
  List<Object> get props => [password];
}

// event //
@immutable
abstract class PasswordTempEvent extends Equatable {
  const PasswordTempEvent();
}

class SetPasswordTemp extends PasswordTempEvent {
  final String password;

  SetPasswordTemp(this.password);

  @override
  List<Object> get props => [password];
}

class PassowrdToinitial extends PasswordTempEvent {
  @override
  List<Object> get props => [];
}

class PasswordTempBloc extends Bloc<PasswordTempEvent, PasswordTempState> {
  PasswordTempBloc() : super(PasswordTempInitial()) {
    on<SetPasswordTemp>((event, emit) {
      String password = event.password;

      emit(LoadPasswordTemp(password));
    });
    on<PassowrdToinitial>((event, emit) => emit(PasswordTempInitial()));
  }
}
 