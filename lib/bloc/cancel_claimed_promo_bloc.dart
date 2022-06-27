import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class CancelClaimedPromoState extends Equatable {
  const CancelClaimedPromoState();
}

class CancelClaimedPromoInitial extends CancelClaimedPromoState {
  @override
  List<Object?> get props => [];
}

class CancelClaimedPromoExecuted extends CancelClaimedPromoState {
  @override
  List<Object?> get props => [];
}

// event //
abstract class CancelClaimedPromoEvent extends Equatable {
  const CancelClaimedPromoEvent();
}

class CancelClaimedPromo extends CancelClaimedPromoEvent {
  final String? idMember;
  final int? userPromoId;

  CancelClaimedPromo({
    required this.idMember,
    required this.userPromoId,
  });

  @override
  List<Object?> get props => [idMember, userPromoId];
}

class CancelClaimedPromoBloc
    extends Bloc<CancelClaimedPromoEvent, CancelClaimedPromoState> {
  CancelClaimedPromoBloc() : super(CancelClaimedPromoInitial()) {
    on<CancelClaimedPromo>((event, emit) async {
      await PromoService.cancelClaimedPromo(
        idMember: event.idMember!,
        userPromoId: event.userPromoId!,
      );

      emit(CancelClaimedPromoExecuted());
    });
  }
}
