import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class ToppingState extends Equatable {
  const ToppingState();
}

class ToppingInitial extends ToppingState {
  @override
  List<Object> get props => [];
}

class LoadToppingData extends ToppingState {
  final List<Topping> topping;

  LoadToppingData(this.topping);

  @override
  List<Object> get props => [topping];
}

// event //
@immutable
abstract class ToppingEvent extends Equatable {
  const ToppingEvent();
}

class GetToppingData extends ToppingEvent {
  @override
  List<Object> get props => [];
}

class ToppingBloc extends Bloc<ToppingEvent, ToppingState> {
  ToppingBloc() : super(ToppingInitial()) {
    on<GetToppingData>((event, emit) async {
      List<Topping> topping = await DetailOrderServices.getToppingLit();

      emit(LoadToppingData(topping));
    });
  }
}
