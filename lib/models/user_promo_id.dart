part of 'models.dart';

class UserPromoId extends Equatable {
  final int? userPromoId;
  final String promoId;

  UserPromoId({
    required this.userPromoId,
    required this.promoId,
  });

  @override
  List<Object?> get props => [userPromoId];

  factory UserPromoId.fromJson(Map<dynamic, dynamic> map) {
    return UserPromoId(
      userPromoId: map['id'],
      promoId: map['promo_id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {'id': userPromoId, 'promo_id': promoId};
  }
}
