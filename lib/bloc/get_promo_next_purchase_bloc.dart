import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class GetPromoNextPurchaseState extends Equatable {
  const GetPromoNextPurchaseState();
}

class GetPromoNextPurchaseInitial extends GetPromoNextPurchaseState {
  @override
  List<Object?> get props => [];
}

class LoadPromoNextPurchaseData extends GetPromoNextPurchaseState {
  final ClaimedUserPromo promo;
  final String message;

  LoadPromoNextPurchaseData({
    required this.promo,
    required this.message,
  });

  @override
  List<Object?> get props => [promo];
}

// event //
abstract class GetPromoNextPurchaseEvent extends Equatable {
  const GetPromoNextPurchaseEvent();
}

class GetPromoNextPurchase extends GetPromoNextPurchaseEvent {
  final String idMember;

  GetPromoNextPurchase(this.idMember);

  @override
  List<Object?> get props => [idMember];
}
class GetPromoNextPurchaseBloc
    extends Bloc<GetPromoNextPurchaseEvent, GetPromoNextPurchaseState> {
  GetPromoNextPurchaseBloc() : super(GetPromoNextPurchaseInitial()) {
    on<GetPromoNextPurchaseEvent>((event, emit) {});
    on<GetPromoNextPurchase>((event, emit) async {
      var value = await PromoService.getDetailNextPurchasePromo(
        idMember: event.idMember,
      );

      if (value.message == 'data kosong') {
        emit(LoadPromoNextPurchaseData(
          message: 'data kosong',
          promo: value.value,
        ));
      } else if (value.message == 'data tidak kosong') {
        emit(LoadPromoNextPurchaseData(
          message: 'data tidak kosong',
          promo: value.value!,
        ));
      }
    });
  }
}
