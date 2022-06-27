part of 'models.dart';

class IdMemberData extends Equatable {
  final String name;
  final int yPoin;
  final String birthday;
  final String gender;
  final String email;
  final String idMember;
  final String phoneNumber;
  final String city;

  IdMemberData({
    this.city = '-',
    this.name = '-',
    this.yPoin = 0,
    this.birthday = '-',
    this.email = '-',
    this.gender = '-',
    this.idMember = '-',
    this.phoneNumber = '-',
  });

  IdMemberData copyWith({
    final String? name,
    final int? yPoin,
    final String? birthday,
    final String? gender,
    final String? email,
    final String? idMember,
    final String? phoneNumber,
  }) =>
      IdMemberData(
        name: name ?? this.name,
        yPoin: yPoin ?? this.yPoin,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        idMember: idMember ?? this.idMember,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  @override
  List<Object> get props => [
        name,
        yPoin,
        birthday,
        gender,
        email,
        idMember,
        phoneNumber,
      ];
}
