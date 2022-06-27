part of 'models.dart';

class AvailableCityPromo extends Equatable {
  final String? city;

  AvailableCityPromo({required this.city});

  @override
  List<Object?> get props => [city];

  factory AvailableCityPromo.fromJson(Map<dynamic, dynamic> map) {
    return AvailableCityPromo(city: map['city']);
  }

  Map<dynamic, dynamic> toJson() {
    return {'city': city};
  }
}

class Promo extends Equatable {
  final String? img;
  final String? provision;
  final String? promoCategory;
  final String? promoStartDate;
  final String? promoEndDate;
  final String? termCondition;
  final String? promoId;
  final List<AvailableCityPromo> availableCity;

  Promo({
    required this.img,
    required this.provision,
    required this.promoCategory,
    required this.promoStartDate,
    required this.promoEndDate,
    required this.termCondition,
    required this.availableCity,
    required this.promoId,
  });

  @override
  List<Object?> get props => [
        img,
        provision,
        promoCategory,
        promoStartDate,
        promoEndDate,
        termCondition,
        availableCity,
        promoId,
      ];

  factory Promo.fromJson(Map<dynamic, dynamic> map) {
    return Promo(
      img: map['img'],
      provision: map['caption'],
      promoCategory: map['promo_category'],
      promoStartDate: map['promo_start'],
      promoEndDate: map['promo_end'],
      termCondition: map['term_condition'],
      availableCity: List<AvailableCityPromo>.from(
        map["city"].map((x) => AvailableCityPromo.fromJson(x)),
      ),
      promoId: map['id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'img': img,
      'caption': provision,
      'promo_category': promoCategory,
      'promo_start': promoStartDate,
      'promo_end': promoEndDate,
      'term_condition': termCondition,
      'city': availableCity,
      'id': promoId,
    };
  }
}
