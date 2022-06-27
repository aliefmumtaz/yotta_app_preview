import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/extentions/extentions.dart';

abstract class DateCreationState extends Equatable {
  const DateCreationState();
}

// state
class DateCreationInitial extends DateCreationState {
  @override
  List<Object?> get props => [];
}

class LoadDateCreation extends DateCreationState {
  final String validUntil;

  LoadDateCreation(this.validUntil);

  @override
  List<Object?> get props => [validUntil];
}

// event
abstract class DateCreationEvent extends Equatable {
  const DateCreationEvent();
}

class GetDateCreation extends DateCreationEvent {
  final String dateCreation;

  GetDateCreation(this.dateCreation);

  @override
  List<Object?> get props => [dateCreation];
}

class DateCreationBloc extends Bloc<DateCreationEvent, DateCreationState> {
  DateCreationBloc() : super(DateCreationInitial()) {
    on<GetDateCreation>(
      (event, emit) => emit(
        LoadDateCreation(event.dateCreation.userPointValidUntil),
      ),
    );
  }
}
