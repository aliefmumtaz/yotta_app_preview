import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
abstract class UserPromoIdState extends Equatable {
  const UserPromoIdState();
}

class UserPromoIdInitial extends UserPromoIdState {
  @override
  List<Object?> get props => [];
}

class LoadUserPromoId extends UserPromoIdState {
  final int userPromoId;

  LoadUserPromoId(this.userPromoId);

  @override
  List<Object?> get props => [userPromoId];
}

// event //
abstract class UserPromoIdEvent extends Equatable {
  const UserPromoIdEvent();
}

class GetUserPromoId extends UserPromoIdEvent {
  final String idMember;
  final String promoId;

  GetUserPromoId({required this.idMember, required this.promoId});

  @override
  List<Object?> get props => [idMember, promoId];
}

class UserPromoIdBloc extends Bloc<UserPromoIdEvent, UserPromoIdState> {
  UserPromoIdBloc() : super(UserPromoIdInitial()) {
    on<GetUserPromoId>((event, emit) async {
      int userPromoId = await PromoService.getUserPromoId(
        idMember: event.idMember,
        promoId: event.promoId,
      );

      emit(LoadUserPromoId(userPromoId));
    });
  }
}
