part of 'models.dart';

class DetailSpecialOffer extends Equatable {
  final String? imgUrl;
  final String? desc;

  DetailSpecialOffer({required this.imgUrl, required this.desc});

  @override
  List<Object?> get props => [imgUrl, desc];
}
