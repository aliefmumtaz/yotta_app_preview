import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class CheckoutDeliveryDataState extends Equatable {
  const CheckoutDeliveryDataState();
}

class CheckoutDeliveryDataInitial extends CheckoutDeliveryDataState {
  @override
  List<Object> get props => [];
}

class LoadCheckoutDeliveryOrderData extends CheckoutDeliveryDataState {
  final DeliveryOrderData deliveryOrderData;
  final int? totalPrice;
  final String? status;

  LoadCheckoutDeliveryOrderData(
    this.deliveryOrderData,
    this.status,
    this.totalPrice,
  );

  @override
  List<Object?> get props => [deliveryOrderData, status, totalPrice];
}

// event //
@immutable
abstract class CheckoutDeliveryDataEvent extends Equatable {
  const CheckoutDeliveryDataEvent();
}

class GetCheckoutDeliveryOrderData extends CheckoutDeliveryDataEvent {
  final String id;

  GetCheckoutDeliveryOrderData(this.id);

  @override
  List<Object> get props => [id];
}

class CheckoutDeliveryToInitial extends CheckoutDeliveryDataEvent {
  @override
  List<Object> get props => [];
}


class CheckoutDeliveryDataBloc
    extends Bloc<CheckoutDeliveryDataEvent, CheckoutDeliveryDataState> {
  CheckoutDeliveryDataBloc() : super(CheckoutDeliveryDataInitial()) {
    on<CheckoutDeliveryDataEvent>((event, emit) async* {
      if (event is GetCheckoutDeliveryOrderData) {
        DeliveryOrderData deliveryOrderData =
            await CheckoutOrderService.getDeliveryData(event.id);

        int? totalPrice =
            await CheckoutOrderService.getTotalPriceDataAfterCheckout(event.id);

        String? status =
            await CheckoutOrderService.getStatusCheckoutOrder(event.id);

        yield LoadCheckoutDeliveryOrderData(
          deliveryOrderData,
          status,
          totalPrice,
        );
      } else if (event is CheckoutDeliveryToInitial) {
        yield CheckoutDeliveryDataInitial();
      }
    });
    on<GetCheckoutDeliveryOrderData>((event, emit) {
      
    });
  }
}
