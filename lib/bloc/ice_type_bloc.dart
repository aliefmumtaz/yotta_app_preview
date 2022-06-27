import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class IceTypeState extends Equatable {
  const IceTypeState();
}

class IceTypeInitial extends IceTypeState {
  @override
  List<Object> get props => [];
}

class LoadIceTypeData extends IceTypeState {
  final List<IceType> iceType;

  LoadIceTypeData(this.iceType);

  @override
  List<Object> get props => [iceType];
}

// event //
@immutable
abstract class IceTypeEvent extends Equatable {
  const IceTypeEvent();
}

class GetIceTypeData extends IceTypeEvent {
  @override
  List<Object> get props => [];
}

class IceTypeBloc extends Bloc<IceTypeEvent, IceTypeState> {
  IceTypeBloc() : super(IceTypeInitial()) {
    on<GetIceTypeData>((event, emit) async {
      List<IceType> iceType = await DetailOrderServices.getIceType();

      emit(LoadIceTypeData(iceType));
    });
  }
}
