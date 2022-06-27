import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

import '../models/models.dart';

abstract class BirthdayCheckingEvent extends Equatable {
  const BirthdayCheckingEvent();

  @override
  List<Object?> get props => [];
}

class CheckBirthday extends BirthdayCheckingEvent {
  final String todayDate, birthday, idMember;

  CheckBirthday({
    required this.todayDate,
    required this.birthday,
    required this.idMember,
  });

  @override
  List<Object?> get props => [todayDate, birthday, idMember];
}

class BirthdayCheckingBloc extends Bloc<BirthdayCheckingEvent, bool> {
  BirthdayCheckingBloc() : super(false) {
    on<CheckBirthday>((event, emit) async {
      String todayDate = event.todayDate.split(' ')[0];
      String birthdayDate = event.birthday.split(' ')[0];

      String todayMonth = event.todayDate.split(' ')[1];
      String birthdayMonth = event.birthday.split(' ')[1];

      String todayRemoveYear = '$todayDate $todayMonth';
      String birthdayRemoveYear = '$birthdayDate $birthdayMonth';

      if (todayRemoveYear == birthdayRemoveYear) {
        print('is birthday 1');
        emit(true);
      } else {
        print('is not birthday 1');
        List<ClaimedUserPromo> claimedPromo =
            await PromoService.getAllClaimedPromo(
          idMember: event.idMember,
        );

        if (claimedPromo.isEmpty) {
          emit(false);
        } else {
          ClaimedUserPromo birthdayPromo = claimedPromo
              .where(
                (element) => element.claimedPromo!.promoCategory == 'birthday',
              )
              .first;

          await PromoService.cancelClaimedPromo(
            idMember: event.idMember,
            userPromoId: birthdayPromo.userPromoId!,
          );

          emit(false);
        }
      }
    });
  }
}
