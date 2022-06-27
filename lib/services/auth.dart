part of 'services.dart';

class SignInSignUpResult {
  final User? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<String> resetPassowrd(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());

      return 'Sukses';
    } catch (e) {
      print('erornya = ' + e.toString());
      return 'Eror';
    }
  }

  static Future<void> changeStatusToVerifiedEmail(String id) async {
    CollectionReference _user = FirebaseFirestore.instance.collection('user');

    _user.doc(id).update({'isEmailVerified': true});
  }

  static Future<void> deleteCurrentUser({
    required String email,
    required String password,
    required String userId,
    required String? idMember,
    http.Client? client,
  }) async {
    // delete registered user
    auth.User user = _auth.currentUser!;

    auth.AuthCredential credential =
        auth.EmailAuthProvider.credential(email: email.trim(), password: password);

    auth.UserCredential result =
        await user.reauthenticateWithCredential(credential);

    await result.user!.delete();

    // delete user in database
    DocumentReference _user =
        FirebaseFirestore.instance.collection('user').doc(userId);

    await _user.delete();

    // delete user in API
    if (client == null) {
      client = http.Client();
    }

    String url = baseURL + 'penjualan/hapus_customer_yotta';

    var response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'token': staticToken,
        'kode_customer': idMember,
      }),
    );

    print(response.body);
  }

  static Future<ApiReturnValue<SignInSignUpResult>> signUpWithEmail({
    String? registeredIdMember,
    String? phoneNumber,
    String? name,
    required bool isUserRegistered,
    required String email,
    required String password,
    String? city,
    String? gender,
    String? birthday,
    String? nickName,
    int? yPoin,
    http.Client? client,
    required bool isEmailVerified,
  }) async {
    const _charsIdMember = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    Random _rnd = Random();

    String randomDocIdMember() => String.fromCharCodes(
          Iterable.generate(
            6,
            (_) => _charsIdMember.codeUnitAt(
              _rnd.nextInt(_charsIdMember.length),
            ),
          ),
        );

    String generatedIdMember = randomDocIdMember();

    // check if id member exsist
    CollectionReference _user = FirebaseFirestore.instance.collection('user');

    QuerySnapshot snapshotPhoneNumber =
        await _user.where('id member', isEqualTo: generatedIdMember).get();

    var docIdMember = snapshotPhoneNumber.docs;

    List<String?> listIdMember = [];

    for (var doc in docIdMember) {
      listIdMember.add(doc['id member']);
    }

    String _checkeIdMember = listIdMember.join().trim();
    String idMember = generatedIdMember;

    print('id member = $idMember');

    try {
      if (_checkeIdMember != idMember) {
        // set data registration to API
        if (client == null) {
          client = http.Client();
        }

        String url = baseURL + 'penjualan/tambah_customer';

        var response = await client.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            'token': staticToken,
            'kode_customer': (isUserRegistered) ? registeredIdMember : idMember,
            // 'kode_customer':
            //     ((isUserRegistered) ? registeredIdMember : generatedIdMember)
            //         .toString(),
            'nama': name,
            'telp': phoneNumber,
            'email': email.trim(),
            'kota': city,
            'alamat': '',
            'point': (isUserRegistered) ? yPoin : 0,
          }),
        );

        print(response.body.toString());

        // set data to yotta database
        // {"status":false,"message":"Email sudah terdaftar..","data":{}}
        if (response.body.toString() ==
            '{"status":false,"message":"Email sudah terdaftar..","data":{}}') {
          print('email sudah terdaftar di booble');
          return ApiReturnValue(message: 'Email sudah terdaftar');
        } else if (response.body.toString() ==
            '{"status":false,"message":"Nomor telepon sudah terdaftar..","data":{}}') {
          print('nomor telepon sudah terdaftar di booble');
          return ApiReturnValue(message: 'nomor telepon sudah terdaftar');
        } else if (response.body.toString() ==
            '{"status":false,"message":"Kode customer sudah terdaftar..","data":{}}') {
          print('id member sudah terdaftar di booble');
          return ApiReturnValue(message: 'id member sudah terdaftar');
        } else {
          final auth.UserCredential result =
              await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

          User user = result.user!.convertToUser(
            phoneNumber: phoneNumber,
            name: name,
            email: email.trim(),
            city: city,
            birthday: birthday,
            gender: gender,
            nickName: nickName,
            idMember: (isUserRegistered) ? registeredIdMember : idMember,
          );

          await UserServices.updateUser(user);

          if (response.statusCode != 200) {
            print('gagal menyimpan, coba lagi');
            return ApiReturnValue(message: 'Gagal Menyimpan, Coba Lagi');
          } else {
            print('berhasil menyimpan');
            return ApiReturnValue(message: 'Berhasil menyimpan');
          }
        }
      } else {
        print('id member sama');
        return ApiReturnValue(message: 'Id member sama');
      }
    } on auth.FirebaseAuthException catch (e) {
      print('gagal menyimpan, coba lagi, error: $e');

      if (client == null) {
        client = http.Client();
      }

      String url = baseURL + 'penjualan/hapus_customer_yotta';

      var response = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'token': staticToken,
          'kode_customer':
              ((isUserRegistered) ? registeredIdMember : generatedIdMember)
                  .toString(),
        }),
      );

      print(response.body);

      return ApiReturnValue(message: 'Gagal Menyimpan, Coba Lagi');
    }
  }

  static Future<SignInSignUpResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User user = result.user!.convertToUser();

      return SignInSignUpResult(user: user);
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      return SignInSignUpResult(message: 'terjadi kesalahan');
    }
  }

  static Future<UserPoint> getUserPointFromAPI({
    required String? idMember,
    http.Client? client,
  }) async {
    print('procesing...');
    if (client == null) {
      client = http.Client();
    }

    String url = baseURL + 'penjualan/detail_customer';

    var respone = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String?>{
        'token': staticToken,
        'kode_customer': idMember,
      }),
    );

    var data = jsonDecode(respone.body);

    List<UserPoint> userPoint =
        (data['data'] as Iterable).map((e) => UserPoint.fromJson(e)).toList();

    return userPoint[0];
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
