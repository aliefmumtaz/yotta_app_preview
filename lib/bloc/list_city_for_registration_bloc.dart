import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

class ListCityForRegistrationState extends Equatable {
  final List<CityForRegistration> cityForRegistration;

  const ListCityForRegistrationState(this.cityForRegistration);

  @override
  List<Object> get props => [cityForRegistration];
}

@immutable
abstract class ListCityForRegistrationEvent extends Equatable {
  const ListCityForRegistrationEvent();
}

class GetCityList extends ListCityForRegistrationEvent {
  @override
  List<Object> get props => [];
}

class ListCityForRegistrationBloc
    extends Bloc<ListCityForRegistrationEvent, ListCityForRegistrationState> {
  ListCityForRegistrationBloc() : super(ListCityForRegistrationState([])) {
    on<GetCityList>((event, emit) async {
      List<CityForRegistration> listCity =
          await ChooseCityForRegistration.getCity();

      emit(ListCityForRegistrationState(listCity));
    });
  }
}
