part of 'models.dart';

class RegistrationData {
  String phoneNumber;
  String name;
  String email;
  String? city;
  String? gender;
  String? birthday;
  String nickName;

  RegistrationData({
    this.phoneNumber = '',
    this.name = '',
    this.email = '',
    this.city = '',
    this.gender = '',
    this.birthday = '',
    this.nickName = '',
  });
}

class DataForRegisteredIdMember {
  String idMember;
  String phoneNumber;
  String name;
  String email;
  String? city;
  String? gender;
  String? birthday;
  int yPoin;
  String nickName;

  DataForRegisteredIdMember({
    this.phoneNumber = '',
    this.name = '',
    this.email = '',
    this.city = '',
    this.gender = '',
    this.birthday = '',
    this.yPoin = 0,
    this.nickName = '',
    this.idMember = '',
  });
}
