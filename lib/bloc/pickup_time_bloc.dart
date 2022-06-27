import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class PickupTimeState extends Equatable {
  const PickupTimeState();
}

class PickupTimeInitial extends PickupTimeState {
  @override
  List<Object> get props => [];
}

class LoadPickUpTime extends PickupTimeState {
  final List<PickupTime> pickUpTime;

  LoadPickUpTime(this.pickUpTime);

  @override
  List<Object> get props => [pickUpTime];
}

// event //
@immutable
abstract class PickupTimeEvent extends Equatable {
  const PickupTimeEvent();
}

class GetPickUpTime extends PickupTimeEvent {
  @override
  List<Object> get props => [];
}

class PickUpTimeToInitial extends PickupTimeEvent {
  @override
  List<Object> get props => [];
}

class PickupTimeBloc extends Bloc<PickupTimeEvent, PickupTimeState> {
  PickupTimeBloc() : super(PickupTimeInitial()) {
    on<GetPickUpTime>((event, emit) async {
      List<PickupTime> pickUpTime =
          await PickupTimeServices.getPickUpTimeList();

      emit(LoadPickUpTime(pickUpTime));
    });
    on<PickUpTimeToInitial>((event, emit) => emit(PickupTimeInitial()));
  }
}
