part of 'models.dart';

class SpecialOffer extends Equatable {
  final String? imgUrl;
  final String? desc;

  SpecialOffer({required this.imgUrl, required this.desc});

  @override
  List<Object?> get props => [imgUrl, desc];

  factory SpecialOffer.fromJson(Map<dynamic, dynamic> map) {
    return SpecialOffer(
      imgUrl: map['img'],
      desc: map['deskripsi'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'img': imgUrl,
      'deskripsi': desc,
    };
  }
}
