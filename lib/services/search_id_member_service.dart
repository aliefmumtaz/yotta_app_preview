part of 'services.dart';

class SearchIdMemberService {
  static CollectionReference _userIdMember =
      FirebaseFirestore.instance.collection('registered_id_member');

  static Future<IdMemberData> getData(String idMember) async {
    DocumentSnapshot snapshot = await _userIdMember.doc(idMember).get();

    if (!snapshot.exists) {
      var data = IdMemberData(
        name: '',
        yPoin: 0,
        birthday: '',
        email: '',
        gender: '',
        idMember: '',
        phoneNumber: '',
        city: '',
      );

      return data;
    } else {
      var data = IdMemberData(
        name: snapshot['nama'] ?? '',
        yPoin: snapshot['y poin'] ?? 0,
        birthday: snapshot['tanggal lahir'] ?? '',
        email: (!snapshot.exists) ? snapshot['email'] : '',
        gender: snapshot['gender'] ?? '',
        idMember: snapshot['id member'] ?? '',
        phoneNumber: snapshot['nomor hp'] ?? '',
        city: snapshot['kota'] ?? '',
      );

      return data;
    }
  }
}
