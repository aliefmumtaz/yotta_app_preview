part of 'models.dart';

class User extends Equatable {
  final String uid;
  final String? phoneNumber;
  final String? name;
  final String? email;
  final String? city;
  final String? gender;
  final String? birthday;
  final String? nickName;
  final String? idMember;
  final String? tokenId;
  final bool? isEmailVerified;

  User(
    this.uid, {
    this.phoneNumber = '',
    this.name = '',
    this.email = '',
    this.city = '',
    this.gender = '',
    this.birthday = '',
    this.nickName = '',
    this.idMember = '',
    required this.tokenId,
    required this.isEmailVerified,
  });
  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        email,
        city,
        gender,
        birthday,
        nickName,
        idMember,
        tokenId,
        isEmailVerified,
      ];
}
