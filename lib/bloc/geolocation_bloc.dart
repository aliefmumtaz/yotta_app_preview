import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// state //
@immutable
abstract class GeolocationState extends Equatable {
  const GeolocationState();
}

class GeolocationInitial extends GeolocationState {
  @override
  List<Object> get props => [];
}

class LoadDistance extends GeolocationState {
  // final List<DistanceValue> distanceValue;

  // LoadDistance(this.distanceValue);

  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();
}

class GetDistance extends GeolocationEvent {
  final double latStart, longStart, latDes, longDes;

  GetDistance(this.latStart, this.longStart, this.latDes, this.longDes);

  @override
  List<Object> get props => [latStart, longStart, latDes, longDes];
}

class DistanceToinitial extends GeolocationEvent {
  @override
  List<Object> get props => [];
}

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitial());

  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is GetDistance) {
      // String distance = await LocationServices.getDistance(
      //   event.latStart,
      //   event.longStart,
      //   event.latDes,
      //   event.longDes,
      // );

      // List<DistanceValue> distanceValue = await LocationServices.getDistances(
      //   event.latStart,
      //   event.longStart,
      //   event.latDes,
      //   event.longDes,
      // );

      // yield LoadDistance(distanceValue);
    } else if (event is DistanceToinitial) {
      yield GeolocationInitial();
    }
  }
}
