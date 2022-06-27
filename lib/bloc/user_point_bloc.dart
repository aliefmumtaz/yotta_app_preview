import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class UserPointState extends Equatable {
  const UserPointState();
}

class UserPointInitial extends UserPointState {
  @override
  List<Object> get props => [];
}

class LoadUserPoint extends UserPointState {
  final int? point;

  LoadUserPoint(this.point);

  @override
  List<Object?> get props => [point];
}

// event //
@immutable
abstract class UserPointEvent extends Equatable {
  const UserPointEvent();
}

class GetUserPoint extends UserPointEvent {
  final String? id;

  GetUserPoint(this.id);

  @override
  List<Object?> get props => [id];
}

class UserPointBloc extends Bloc<UserPointEvent, UserPointState> {
  UserPointBloc() : super(UserPointInitial()) {
    on<GetUserPoint>((event, emit) async {
      UserPoint userPoint = await AuthServices.getUserPointFromAPI(
        idMember: event.id,
      );

      emit(LoadUserPoint(userPoint.point));
    });
  }
}
