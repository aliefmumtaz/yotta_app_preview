import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class YottaOfTheWeekState extends Equatable {
  const YottaOfTheWeekState();
}

class YottaOfTheWeekInitial extends YottaOfTheWeekState {
  @override
  List<Object> get props => [];
}

class LoadYottaOfTheWeek extends YottaOfTheWeekState {
  final List<YottaOfTheWeek> yottaOfTheWeek;

  LoadYottaOfTheWeek(this.yottaOfTheWeek);

  @override
  List<Object> get props => [yottaOfTheWeek];
}

// event //
@immutable
abstract class YottaOfTheWeekEvent extends Equatable {
  const YottaOfTheWeekEvent();
}

class GetYottaOfTheWeek extends YottaOfTheWeekEvent {
  @override
  List<Object> get props => [];
}


class YottaOfTheWeekBloc
    extends Bloc<YottaOfTheWeekEvent, YottaOfTheWeekState> {
  YottaOfTheWeekBloc() : super(YottaOfTheWeekInitial()) {
    on<GetYottaOfTheWeek>((event, emit) async {
      List<YottaOfTheWeek> yottaOfTheWeek =
          await YottaOfTheWeekServices.getYottaOfTheWeekData();

      emit(LoadYottaOfTheWeek(yottaOfTheWeek));
    });
  }
}
