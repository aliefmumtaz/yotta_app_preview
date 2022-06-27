part of 'services.dart';

class ChooseCityForRegistration {
  static Future<List<CityForRegistration>> getCity({
    http.Client? client,
  }) async {
    var url = yottaServerUrl + '/v1/option/type/pilih_kota';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers); 

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<CityForRegistration> cities = [];

      for (var doc in data) {
        cities.add(CityForRegistration.fromJson(doc));
      }

      return cities;
    } else {
      throw Exception('gagal mengambil data kota . . . . ');
    }
  }
}
