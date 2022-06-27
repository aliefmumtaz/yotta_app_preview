import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// STATE //
@immutable
abstract class SugarTypeState extends Equatable {
  const SugarTypeState();
}

class SugarTypeInitial extends SugarTypeState {
  @override
  List<Object> get props => [];
}

class LoadSugarTypeData extends SugarTypeState {
  final List<SugarType> sugarType;

  LoadSugarTypeData(this.sugarType);

  @override
  List<Object> get props => [sugarType];
}

// EVENT //
@immutable
abstract class SugarTypeEvent extends Equatable {
  const SugarTypeEvent();
}

class GetSugarTypeData extends SugarTypeEvent {
  @override
  List<Object> get props => [];
}

class SugarTypeBloc extends Bloc<SugarTypeEvent, SugarTypeState> {
  SugarTypeBloc() : super(SugarTypeInitial()) {
    on<SugarTypeEvent>((event, emit) async* {
      if (event is GetSugarTypeData) {
        List<SugarType> sugarType = await DetailOrderServices.getSugarType();

        yield LoadSugarTypeData(sugarType);
      }
    });
  }
}
