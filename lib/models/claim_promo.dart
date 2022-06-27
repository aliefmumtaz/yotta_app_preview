part of 'models.dart';

class ClaimPromoData extends Equatable {
  final String promoId;
  final String name;
  final String idMember;
  final String phoneNumber;

  ClaimPromoData({
    required this.promoId,
    required this.name,
    required this.idMember,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [promoId, name, idMember, phoneNumber];
}
