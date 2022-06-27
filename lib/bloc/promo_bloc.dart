import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class PromoState extends Equatable {
  const PromoState();
}

class PromoInitial extends PromoState {
  @override
  List<Object?> get props => [];
}

class LoadAllPromoList extends PromoState {
  final List<Promo> promos;

  LoadAllPromoList(this.promos);

  @override
  List<Object?> get props => [promos];
}

// event //
abstract class PromoEvent extends Equatable {
  const PromoEvent();
}

class GetAllPromoList extends PromoEvent {
  final String idMember;
  final String userCity;

  GetAllPromoList({
    required this.idMember,
    required this.userCity,
  });

  @override
  List<Object?> get props => [
        idMember,
        userCity,
      ];
}

class PromoBloc extends Bloc<PromoEvent, PromoState> {
  PromoBloc() : super(PromoInitial()) {
    on<GetAllPromoList>((event, emit) async {
      List<Promo> promos = await PromoService.getAllPromo(
        idMember: event.idMember,
        userCity: event.userCity,
      );

      emit(LoadAllPromoList(promos));
    });
  }
}
