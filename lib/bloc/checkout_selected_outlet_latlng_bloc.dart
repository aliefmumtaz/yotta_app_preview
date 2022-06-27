import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class CheckoutSelectedOutletLatlngState extends Equatable {
  const CheckoutSelectedOutletLatlngState();
}

class CheckoutSelectedOutletLatlngInitial
    extends CheckoutSelectedOutletLatlngState {
  @override
  List<Object> get props => [];
}

class LoadSelectedOutletLatLng extends CheckoutSelectedOutletLatlngState {
  final LatLng outletLatLng;
  final LatLng userLoc;

  LoadSelectedOutletLatLng(this.outletLatLng, this.userLoc);

  @override
  List<Object> get props => [outletLatLng, userLoc];
}

// event //
@immutable
abstract class CheckoutSelectedOutletLatlngEvent extends Equatable {
  const CheckoutSelectedOutletLatlngEvent();
}

class GetSelectedOutletLatLng extends CheckoutSelectedOutletLatlngEvent {
  final String id;

  GetSelectedOutletLatLng(this.id);

  @override
  List<Object> get props => [id];
}


class CheckoutSelectedOutletLatlngBloc extends Bloc<
    CheckoutSelectedOutletLatlngEvent, CheckoutSelectedOutletLatlngState> {
  CheckoutSelectedOutletLatlngBloc()
      : super(CheckoutSelectedOutletLatlngInitial()) {
    on<GetSelectedOutletLatLng>((event, emit) async {
      LatLng outletLatLng = await CheckoutOrderService.getOutletLatLng(
        event.id,
      );

      LatLng userLoc = await CheckoutOrderService.getUserLatLng(event.id);

      emit(LoadSelectedOutletLatLng(outletLatLng, userLoc));
    });
  }
}

