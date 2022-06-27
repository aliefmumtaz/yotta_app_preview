import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
@immutable
abstract class SelectedLocationState extends Equatable {
  const SelectedLocationState();
}

class SelectedLocationInitial extends SelectedLocationState {
  @override
  List<Object> get props => [];
}

class LoadSelectedLocation extends SelectedLocationState {
  final String? address;
  final String? city;

  LoadSelectedLocation(this.address, this.city);

  @override
  List<Object?> get props => [address, city];
}

// event //
@immutable
abstract class SelectedLocationEvent extends Equatable {
  const SelectedLocationEvent();
}

class SetSelectedLocation extends SelectedLocationEvent {
  final String? address;
  final String? city;

  SetSelectedLocation({this.address, this.city});

  @override
  List<Object?> get props => [address, city];
}

class SelectedLocationToInitial extends SelectedLocationEvent {
  @override
  List<Object> get props => [];
}

class SelectedLocationBloc
    extends Bloc<SelectedLocationEvent, SelectedLocationState> {
  SelectedLocationBloc() : super(SelectedLocationInitial()) {
    on<SelectedLocationEvent>((event, emit) async* {
      if (event is SetSelectedLocation) {
        yield LoadSelectedLocation(event.address, event.city);
      } else if (event is SelectedLocationToInitial) {
        yield SelectedLocationInitial();
      }
    });
  }
}
