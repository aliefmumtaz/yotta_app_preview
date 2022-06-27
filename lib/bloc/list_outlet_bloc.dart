import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ListOutletState extends Equatable {
  const ListOutletState();
}

class ListOutletInitial extends ListOutletState {
  @override
  List<Object> get props => [];
}

class LoadListOutlet extends ListOutletState {
  final List<Outlet> outlet;
  final LatLngInitialLocation latLngInitialLocation;

  LoadListOutlet(this.outlet, this.latLngInitialLocation);

  @override
  List<Object> get props => [outlet, latLngInitialLocation];
}

class LoadListNearestOutletForDelivery extends ListOutletState {
  final List<Outlet> listOutlet;

  LoadListNearestOutletForDelivery(this.listOutlet);

  @override
  List<Object> get props => [listOutlet];
}

// event //
@immutable
abstract class ListOutletEvent extends Equatable {
  const ListOutletEvent();
}

class GetListOutlet extends ListOutletEvent {
  final String? city;

  GetListOutlet(this.city);

  @override
  List<Object?> get props => [city];
}

class OutletListToInitial extends ListOutletEvent {
  @override
  List<Object> get props => [];
}

class GetListNearestOutletForDelivery extends ListOutletEvent {
  final String city;

  GetListNearestOutletForDelivery(this.city);

  @override
  List<Object> get props => [city];
}

class ListOutletBloc extends Bloc<ListOutletEvent, ListOutletState> {
  ListOutletBloc() : super(ListOutletInitial()) {
    on<GetListOutlet>((event, emit) async {
      final List<Outlet> listOutlet =
          await OutletServices.getOutletListPerCity(city: event.city!);

      LatLngInitialLocation latLngInitialLocation =
          await OutletServices.getFirstOutletOnSelectedCity(event.city);

      emit(LoadListOutlet(listOutlet, latLngInitialLocation));
    });
    on<OutletListToInitial>((event, emit) => emit(ListOutletInitial()));
    on<GetListNearestOutletForDelivery>((event, emit) async {
      List<Outlet> listNearestOutlet =
          await OutletServices.getOutletListPerCity(city: event.city);

      emit(LoadListNearestOutletForDelivery(listNearestOutlet));
    });
  }
}
