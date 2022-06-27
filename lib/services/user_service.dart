part of 'services.dart';

class UserErorData {
  final String name;
  final String email;
  final String phoneNumber;
  final String idMember;
  final String city;

  UserErorData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.idMember,
    required this.city,
  });
}

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('demo');

  static Future<void> updateUser(User user) async {
    var status = await OneSignal.shared.getDeviceState();

    String? tokenId = status!.userId;

    print('token id = $tokenId');

    _userCollection.doc(user.uid).set({
      'nomor handphone': user.phoneNumber,
      'nama': user.name,
      'email': user.email,
      'kota': user.city,
      'gender': user.gender,
      'tanggal lahir': user.birthday,
      'panggilan': user.nickName,
      'id member': user.idMember,
      'token id': tokenId,
      'isEmailVerified': user.isEmailVerified,
    });
  }

  static Future<void> getUserDataByIdMember(String id) async {
    QuerySnapshot _snap =
        await _userCollection.where('demo', isEqualTo: id).get();

    var document = _snap.docs;

    List<UserErorData> listMember = [];

    for (var doc in document) {
      listMember.add(UserErorData(
        city: doc['kota'],
        email: doc['email'],
        idMember: doc['id member'],
        name: doc['nama'],
        phoneNumber: doc['nomor handphone'],
      ));
    }
  }

  static Future<User> getUser(String id) async {
    var status = await OneSignal.shared.getDeviceState();

    String? tokenId = status!.userId;

    print(tokenId);

    print('token id = $tokenId');

    _userCollection.doc(id).update({'token id': tokenId});

    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(
      id,
      email: snapshot['demo'],
      gender: snapshot['demo'],
      city: snapshot['demo'],
      name: snapshot['demo'],
      phoneNumber: snapshot['demo'],
      nickName: snapshot['demo'],
      birthday: snapshot['demo'],
      idMember: snapshot['demo'],
      tokenId: snapshot['demo'],
      isEmailVerified: snapshot['demo'],
    );
  }

  static Future<void> editUserProfile(
    String id, {
    String? name,
    String? nickName,
    String? email,
    String? city,
    String? phoneNumber,
    String? date,
    required String? idMember,
    http.Client? client,
  }) async {
    _userCollection.doc(id).update({
      'demo': 'demo', 
    });

    if (client == null) {
      client = http.Client();
    }

    String url = baseURL + 'demo';

    var response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'token': staticToken,
          'kode_customer': idMember,
          'nama': name,
          'telp': phoneNumber,
          'email': email,
          'kota': city,
          'alamat': '',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('koneksi gagal');
    }
  }
}
