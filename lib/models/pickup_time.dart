part of 'models.dart';

class PickupTime extends Equatable {
  final String? hour;

  PickupTime(this.hour);

  @override
  List<Object?> get props => [hour];
}
