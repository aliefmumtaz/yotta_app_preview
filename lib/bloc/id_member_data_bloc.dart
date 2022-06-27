import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state
abstract class IdMemberDataState extends Equatable {
  const IdMemberDataState();
}

class InitialDataState extends IdMemberDataState {
  @override
  List<Object> get props => [];
}

class DataLoaded extends IdMemberDataState {
  final IdMemberData idMemberData;

  DataLoaded(this.idMemberData);

  @override
  List<Object> get props => [idMemberData];
}

// event
class IdMemberDataEvent extends Equatable {
  const IdMemberDataEvent();

  @override
  List<Object> get props => [];
}

class InitialDataEvent extends IdMemberDataEvent {
  @override
  List<Object> get props => [];
}

class GetIdMemberData extends IdMemberDataEvent {
  final String id;

  GetIdMemberData(this.id);

  @override
  List<Object> get props => [id];
}

class IdMemberDataBloc extends Bloc<IdMemberDataEvent, IdMemberDataState> {
  IdMemberDataBloc() : super(InitialDataState()) {
    on<GetIdMemberData>((event, emit) async {
      IdMemberData? idMemberData = await SearchIdMemberService.getData(
        event.id,
      );

      emit(DataLoaded(idMemberData));
    });
    on<InitialDataEvent>((event, emit) => emit(InitialDataState()));
  }
}
