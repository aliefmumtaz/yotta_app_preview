part of 'services.dart';

class PromoService {
  static Future<List<Promo>> getAllPromo({
    http.Client? client,
    required String idMember,
    required String userCity,
  }) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<Promo> promos = [];
      List<Promo> promosDependOnCity = [];

      for (var doc in data) {
        promos.add(Promo.fromJson(doc));
      }

      for (var doc in promos) {
        List<String> availableCities = [];

        for (var doc in doc.availableCity) {
          availableCities.add(doc.city!);
        }

        if (availableCities.contains(userCity)) {
          promosDependOnCity.add(doc);
        }
      }

      print('sukses mengambil data all promo user . . . . ');

      return promosDependOnCity;
    } else {
      throw Exception('gagal mengambil data');
    }
  }

  static Future<void> claimPromoOnce({
    http.Client? client,
    required ClaimPromoData claimPromoData,
  }) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'promo_id': claimPromoData.promoId,
        'name': claimPromoData.name,
        'member_id': claimPromoData.idMember,
        'phone_number': claimPromoData.phoneNumber,
      }),
    );

    print('suskes claim promo user. . . . .');
  }

  static Future<List<ClaimedUserPromo>> getAllClaimedPromo(
      {http.Client? client, required String idMember}) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<ClaimedUserPromo> claimedPromos = [];

      for (var doc in data) {
        claimedPromos.add(ClaimedUserPromo.fromJson(doc));
      }

      print('sukses mengambil claimed promo user . . . .');

      return claimedPromos;
    } else {
      throw Exception('gagal mengambil data');
    }
  }

  static Future<void> cancelClaimedPromo({
    http.Client? client,
    required String idMember,
    required int userPromoId,
  }) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    await client.delete(Uri.parse(url), headers: headers);

    print('berhasil membatalkan promo user');
  }

  static Future<int> getUserPromoId({
    http.Client? client,
    required String idMember,
    required String promoId,
  }) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body[0]);

      List<UserPromoId> userPromoId = [];

      for (var doc in data) {
        userPromoId.add(UserPromoId.fromJson(doc));
      }

      print('getting all promo list = $userPromoId . . . . . .');

      List<UserPromoId> userAfterFilter = [];

      print('filtering promo based on promo id . . . . .');

      for (var doc in userPromoId) {
        if (doc.promoId == promoId) {
          userAfterFilter.add(UserPromoId(
            promoId: doc.promoId,
            userPromoId: doc.userPromoId,
          ));
        }
      }

      print(
        'user promo id after filter = ${userAfterFilter[0].userPromoId!} . . . . .',
      );

      return userAfterFilter[0].userPromoId!;
    } else {
      throw Exception('Gagal mengambil data . . . . . . `');
    }
  }

  static Future<ApiReturnValue> getDetailNextPurchasePromo(
      {http.Client? client, required String idMember}) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<ClaimedUserPromo> claimedPromos = [];

      for (var doc in data) {
        claimedPromos.add(ClaimedUserPromo.fromJson(doc));
      }

      print('sukses mengambil claimed next purchase promo user . . . .');

      if (claimedPromos.isEmpty) {
        var promos = ClaimedUserPromo(
          claimedPromo: ClaimedPromo(
            img: '',
            promoCategory: '',
            promoEndDate: '',
            promoId: '',
            promoStartDate: '',
            provision: '',
            termCondition: '',
          ),
          idMember: '',
          name: '',
          phoneNumber: '',
          // promoId: '',
          userPromoId: 0,
        );

        var value = ApiReturnValue(
          message: 'data kosong',
          value: promos,
        );

        return value;
      } else {
        var value = ApiReturnValue(
          message: 'data tidak kosong',
          value: claimedPromos[0],
        );

        return value;
      }
    } else {
      throw Exception('gagal mengambil data');
    }
  }
}
