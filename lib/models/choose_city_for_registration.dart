part of 'models.dart';

class CityForRegistration extends Equatable {
  final String? name;

  CityForRegistration(this.name);

  @override
  List<Object?> get props => [];

  factory CityForRegistration.fromJson(Map<dynamic, dynamic> map) {
    return CityForRegistration(
      map['value'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'value': name,
    };
  }
}
