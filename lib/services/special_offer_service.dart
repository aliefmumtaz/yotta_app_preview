part of 'services.dart';

// class SpecialOfferService {
//   static CollectionReference _specialOffer =
//       FirebaseFirestore.instance.collection('special_offer');

//   static Future<List<SpecialOffer>> getSpecialOfferData() async {
//     QuerySnapshot snapshot = await _specialOffer.get();

//     var document = snapshot.docs;

//     List<SpecialOffer> listSpecialOfferData = [];

//     for (var doc in document) {
//       listSpecialOfferData.add(
//         SpecialOffer(imgUrl: doc['imgUrl'], desc: doc['desc']),
//       );
//     }

//     return listSpecialOfferData;
//   }
// }

class SpecialOfferService {
  static Future<List<SpecialOffer>> getSpecialOfferData({http.Client? client}) async {
    var url = yottaServerUrl + '/v1/whats-new';
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