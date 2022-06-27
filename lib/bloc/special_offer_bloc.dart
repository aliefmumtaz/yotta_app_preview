import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';

@immutable
class SpecialOfferState extends Equatable {
  const SpecialOfferState();

  @override
  List<Object> get props => [];
}

class LoadOfferData extends SpecialOfferState {
  final List<SpecialOffer> specialOfferData;

  const LoadOfferData(this.specialOfferData);

  @override
  List<Object> get props => [specialOfferData];
}

@immutable
abstract class SpecialOfferEvent extends Equatable {
  const SpecialOfferEvent();
}

class GetSpecialOfferData extends SpecialOfferEvent {
  @override
  List<Object> get props => [];
}

class DataLoading extends SpecialOfferEvent {
  @override
  List<Object> get props => [];
}

class SpecialOfferBloc extends Bloc<SpecialOfferEvent, SpecialOfferState> {
  SpecialOfferBloc() : super(SpecialOfferState()) {
    on<GetSpecialOfferData>((event, emit) async {
      List<SpecialOffer> specialOfferDataList =
          await SpecialOfferService.getSpecialOfferData();

      emit(LoadOfferData(specialOfferDataList));
    });
    on<DataLoading>((event, emit) => emit(SpecialOfferState()));
  }
}
