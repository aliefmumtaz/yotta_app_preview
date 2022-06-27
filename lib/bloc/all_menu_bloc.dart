import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

// state
@immutable
class AllMenuState extends Equatable {
  const AllMenuState();

  @override
  List<Object> get props => [];
}

class AllMenuLoad extends AllMenuState {
  final List<AllMenu> allMenu;

  AllMenuLoad(this.allMenu);
}

class AllMenuBottleLoaded extends AllMenuState {
  final List<AllMenuBottle> allMenuBottle;

  AllMenuBottleLoaded(this.allMenuBottle);
}

class AllHotMenuLoaded extends AllMenuState {
  final List<AllHotMenu> allHotMenu;

  AllHotMenuLoaded(this.allHotMenu);
}

// event
@immutable
class AllMenuEvent extends Equatable {
  const AllMenuEvent();

  @override
  List<Object> get props => [];
}

class GetAllMenu extends AllMenuEvent {
  final String? outlet;

  GetAllMenu(this.outlet);
}

class GetAllMenuBottle extends AllMenuEvent {
  final String? outlet;

  GetAllMenuBottle(this.outlet);
}

class GetAllHotMenu extends AllMenuEvent {
  final String? outlet;

  GetAllHotMenu(this.outlet);
}

class AllMenuToInitial extends AllMenuEvent {}

class AllMenuBloc extends Bloc<AllMenuEvent, AllMenuState> {
  AllMenuBloc() : super(AllMenuState()) {
    on<GetAllMenu>((event, emit) async {
      List<AllMenu> allMenuList = await MenuServices.getAllMenu(event.outlet);

      emit(AllMenuLoad(allMenuList));
    });

    on<AllMenuToInitial>((event, emit) => emit(AllMenuState()));

    on<GetAllMenuBottle>((event, emit) async {
      List<AllMenuBottle> allMenuBottle =
          await MenuServices.getAllMenuBottle(event.outlet);

      emit(AllMenuBottleLoaded(allMenuBottle));
    });

    on<GetAllHotMenu>((event, emit) async {
      List<AllHotMenu> allHotMenu =
          await MenuServices.getAllHotMenu(event.outlet);

      emit(AllHotMenuLoaded(allHotMenu));
    });
  }
}
