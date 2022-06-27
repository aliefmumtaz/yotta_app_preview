import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class CheckoutPreorderDataState extends Equatable {
  const CheckoutPreorderDataState();
}

class CheckoutPreorderDataInitial extends CheckoutPreorderDataState {
  @override
  List<Object> get props => [];
}

class LoadCheckoutPreOrderData extends CheckoutPreorderDataState {
  final PreOrderData preOrderdata;
  final int? totalPrice;
  final String? status;

  LoadCheckoutPreOrderData(this.preOrderdata, this.totalPrice, this.status);

  @override
  List<Object?> get props => [preOrderdata, totalPrice];
}

// event //
@immutable
abstract class CheckoutPreorderDataEvent extends Equatable {
  const CheckoutPreorderDataEvent();
}

class GetCheckoutPreOrderData extends CheckoutPreorderDataEvent {
  final String id;

  GetCheckoutPreOrderData(this.id);

  @override
  List<Object> get props => [id];
}

class CheckoutPreOrderDataToInitial extends CheckoutPreorderDataEvent {
  @override
  List<Object> get props => [];
}


class CheckoutPreorderDataBloc
    extends Bloc<CheckoutPreorderDataEvent, CheckoutPreorderDataState> {
  CheckoutPreorderDataBloc() : super(CheckoutPreorderDataInitial()) {
    on<GetCheckoutPreOrderData>((event, emit) async {
      PreOrderData preOrderData =
          await CheckoutOrderService.getPreOrderData(event.id);

      int? totalPrice =
          await CheckoutOrderService.getTotalPriceDataAfterCheckout(
        event.id,
      );

      String? status = await CheckoutOrderService.getStatusCheckoutOrder(
        event.id,
      );

      emit(LoadCheckoutPreOrderData(preOrderData, totalPrice, status));
    });
    on<CheckoutPreOrderDataToInitial>(
      (event, emit) => emit(CheckoutPreorderDataInitial()),
    );
  }
}
