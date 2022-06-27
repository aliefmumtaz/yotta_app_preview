import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class TotalPriceState extends Equatable {
  const TotalPriceState();
}

class TotalPriceInitial extends TotalPriceState {
  @override
  List<Object> get props => [];
}

class LoadTotalPrice extends TotalPriceState {
  final int totalPrice;

  LoadTotalPrice(this.totalPrice);

  @override
  List<Object> get props => [totalPrice];
}

class LoadTotalPriceDelivery extends TotalPriceState {
  final int totalPriceDelivery;
  final int deliveryFee;

  LoadTotalPriceDelivery(this.totalPriceDelivery, this.deliveryFee);

  @override
  List<Object> get props => [totalPriceDelivery];
}

// event
@immutable
abstract class TotalPriceEvent extends Equatable {
  const TotalPriceEvent();
}

class GetTotalPrice extends TotalPriceEvent {
  final String id;

  GetTotalPrice(this.id);

  @override
  List<Object> get props => [id];
}

class GetTotalPriceDelivery extends TotalPriceEvent {
  final String id;
  final double distance;
  final int deliveryFee;

  GetTotalPriceDelivery(this.id, this.distance, this.deliveryFee);

  @override
  List<Object> get props => [id, distance, deliveryFee];
}

class TotalPriceToInitial extends TotalPriceEvent {
  @override
  List<Object> get props => [];
}

class TotalPriceBloc extends Bloc<TotalPriceEvent, TotalPriceState> {
  TotalPriceBloc() : super(TotalPriceInitial()) {
    on<GetTotalPrice>((event, emit) async {
      int totalPrice = await SelectedOrderServices.getTotalPrice(event.id);

      emit(LoadTotalPrice(totalPrice));
    });
    on<GetTotalPriceDelivery>((event, emit) async {
      int totalPrice = await SelectedOrderServices.getTotalPriceWithDeliveryFee(
        event.id,
        event.distance,
        event.deliveryFee,
      );

      int deliveryFee = await SelectedOrderServices.getDeliveryFee(
        event.id,
        event.distance,
        event.deliveryFee,
      );

      emit(LoadTotalPriceDelivery(totalPrice, deliveryFee));
    });
    on<TotalPriceToInitial>((event, emit) => emit(TotalPriceInitial()));
  }
}
