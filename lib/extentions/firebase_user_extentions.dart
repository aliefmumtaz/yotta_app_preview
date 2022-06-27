part of 'extentions.dart';

extension FirebaseUserExtentions on auth.User {
  User convertToUser({
    final String? phoneNumber = 'no phone number input',
    final String? name = "",
    final String email = "",
    final String? city = '',
    final String? gender = '',
    final String? birthday = '',
    final String? nickName = '',
    final String? idMember = '',
    final String tokenId = '',
    final bool isEmailVerified = false,
  }) =>
      User(
        this.uid,
        phoneNumber: phoneNumber,
        name: name,
        email: email,
        city: city,
        gender: gender,
        birthday: birthday,
        nickName: nickName,
        idMember: idMember,
        tokenId: tokenId,
        isEmailVerified: isEmailVerified,
      );

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
