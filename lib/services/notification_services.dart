part of 'services.dart';

class NotificationServices {
  static Future<String?> getOutletToken(String? outlet) async {
    CollectionReference _outletCol =
        FirebaseFirestore.instance.collection('user_outlet');

    QuerySnapshot _snapshot =
        await _outletCol.where('nama', isEqualTo: outlet).get();

    var _doc = _snapshot.docs;

    List<String?> probToken = [];

    for (var doc in _doc) {
      probToken.add(doc['tokenID']);
    }

    String? token = probToken[0];

    print('token outlet = $token');

    return token;
  }

  static Future<void> sendNotification({
    required String? tokenId,
    required String? contents,
    required String? heading,
    http.Client? client,
  }) async {
    if (client == null) {
      client = http.Client();
    }

    String url = 'https://onesignal.com/api/v1/notifications';

    print('seding notification . . . . . . .');

    var response = await client
        .post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id": oneSignalAppId,
        "include_player_ids": [tokenId],
        "android_accent_color": "FF9976D2",
        "large_icon": imgNotifUrl,
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    )
        .then((value) {
      print('notification result = ${value.body}');
    });

    print(response.body);

    // return await post(
    //   Uri.parse('https://onesignal.com/api/v1/notifications'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     "app_id": oneSignalAppId,
    //     "include_player_ids": tokenId,
    //     "android_accent_color": "FF9976D2",
    //     "large_icon": imgNotifUrl,
    //     "headings": {"en": heading},
    //     "contents": {"en": contents},
    //   }),
    // );
  }
}
