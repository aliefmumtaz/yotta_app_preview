import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class ClaimedPromoState extends Equatable {
  const ClaimedPromoState();
}

class ClaimedPromoInitial extends ClaimedPromoState {
  @override
  List<Object?> get props => [];
}

class LoadAllClaimedPromo extends ClaimedPromoState {
  final List<ClaimedUserPromo> claimedPromo;

  LoadAllClaimedPromo(this.claimedPromo);

  @override
  List<Object?> get props => [claimedPromo];
}

// event //
abstract class ClaimedPromoEvent extends Equatable {
  const ClaimedPromoEvent();
}

class GetAllClaimedPromo extends ClaimedPromoEvent {
  final String idMember;

  GetAllClaimedPromo(this.idMember);

  @override
  List<Object?> get props => [idMember];
}

class ClaimedPromoBloc extends Bloc<ClaimedPromoEvent, ClaimedPromoState> {
  ClaimedPromoBloc() : super(ClaimedPromoInitial()) {
    on<GetAllClaimedPromo>((event, emit) async {
      List<ClaimedUserPromo> claimedPromo = await PromoService.getAllClaimedPromo(
        idMember: event.idMember,
      );

      emit(LoadAllClaimedPromo(claimedPromo));
    });
  }
}
