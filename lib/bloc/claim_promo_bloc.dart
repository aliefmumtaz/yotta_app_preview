import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class ClaimPromoState extends Equatable {
  const ClaimPromoState();
}

class ClaimPromoInitial extends ClaimPromoState {
  @override
  List<Object?> get props => [];
}

class ClaimPromoOnceState extends ClaimPromoState {
  @override
  List<Object?> get props => [];
}

// event //
abstract class ClaimPromoEvent extends Equatable {
  const ClaimPromoEvent();
}

class ClaimPromoOnce extends ClaimPromoEvent {
  final ClaimPromoData claimPromoData;

  ClaimPromoOnce({required this.claimPromoData});

  @override
  List<Object?> get props => [claimPromoData];
}

class ClaimPromoBloc extends Bloc<ClaimPromoEvent, ClaimPromoState> {
  ClaimPromoBloc() : super(ClaimPromoInitial()) {
    on<ClaimPromoOnce>((event, emit) async {
      await PromoService.claimPromoOnce(claimPromoData: event.claimPromoData);

      emit(ClaimPromoOnceState());
    });
  }
}
