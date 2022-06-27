part of 'models.dart';

class ClaimedPromo extends Equatable {
  final String? provision;
  final String? img;
  final String? promoCategory;
  final String? promoEndDate;
  final String? promoId;
  final String? promoStartDate;
  final String? termCondition;

  ClaimedPromo({
    required this.provision,
    required this.img,
    required this.promoCategory,
    required this.promoEndDate,
    required this.promoId,
    required this.promoStartDate,
    required this.termCondition,
  });

  @override
  List<Object?> get props => [
        provision,
        img,
        promoCategory,
        promoEndDate,
        promoId,
        promoStartDate,
        termCondition,
      ];

  factory ClaimedPromo.fromJson(Map<dynamic, dynamic> map) {
    return ClaimedPromo(
      provision: map['caption'],
      img: map['img'],
      promoCategory: map['promo_category'],
      promoEndDate: map['promo_end'],
      promoId: map['id'],
      promoStartDate: map['promo_start'],
      termCondition: map['term_condition'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'caption': provision,
      'img': img,
      'promo_category': promoCategory,
      'promo_end': promoEndDate,
      'promo_id': promoId,
      'promo_start': promoStartDate,
      'term_condition': termCondition,
    };
  }
}

class ClaimedUserPromo extends Equatable {
  final String? name;
  final String? idMember;
  final String? phoneNumber;
  // final String? promoId;
  final ClaimedPromo? claimedPromo;
  final int? userPromoId;

  ClaimedUserPromo({
    required this.name,
    required this.idMember,
    required this.phoneNumber,
    // required this.promoId,
    required this.claimedPromo,
    required this.userPromoId,
  });

  @override
  List<Object?> get props => [
        name,
        idMember,
        phoneNumber,
        // promoId,
        claimedPromo,
        userPromoId,
      ];

  factory ClaimedUserPromo.fromJson(Map<dynamic, dynamic> map) {
    return ClaimedUserPromo(
      // promoId: map['promo_id'],
      idMember: map['member_id'],
      name: map['name'],
      phoneNumber: map['phone_number'],
      claimedPromo: ClaimedPromo.fromJson(map['promo']),
      userPromoId: map['id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      // 'promo_id': promoId,
      'member_id': idMember,
      'name': name,
      'phone_number': phoneNumber,
      'promo': claimedPromo,
      'id': userPromoId,
    };
  }
}
