part of 'models.dart';

class UserPoint {
  final int? point;

  UserPoint(this.point);

  factory UserPoint.fromJson(Map<String, dynamic> json) {
    return UserPoint(json['point']);
  }
}
