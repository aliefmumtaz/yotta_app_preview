part of 'services.dart';

class SpecialOfferService {
  static Future<List<SpecialOffer>> getSpecialOfferData({http.Client? client}) async {
    var url = yottaServerUrl + 'demo';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print('berhasil mengambil data . . . . . . . .');

      List data = jsonDecode(response.body);
      List<SpecialOffer> specialOffers = [];

      for (var doc in data) {
        specialOffers.add(SpecialOffer.fromJson(doc));
      }

      return specialOffers;
    } else {

      throw Exception('gagal mengambil data . . . . ');
    }
  }
}
