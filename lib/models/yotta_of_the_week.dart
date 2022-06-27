part of 'models.dart';

class YottaOfTheWeek extends Equatable {
  final String? imgUrl;
  final String? name;
  final String? varian;
  final int? priceR;
  final int? priceL;

  YottaOfTheWeek({
    required this.imgUrl,
    required this.name,
    required this.varian,
    required this.priceR,
    required this.priceL,
  });

  @override
  List<Object?> get props => [imgUrl, name, varian, priceR, priceL];

  factory YottaOfTheWeek.fromJson(Map<dynamic, dynamic> map) {
    return YottaOfTheWeek(
      imgUrl: map['img'],
      name: map['nama'],
      priceL: map['harga_l'],
      priceR: map['harga_r'],
      varian: map['varian'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'img': imgUrl,
      'nama': name,
      'harga_l': priceL,
      'harga_r': priceR,
      'varian': varian,
    };
  }
}
