part of 'services.dart';
class YottaOfTheWeekServices {
  static Future<List<YottaOfTheWeek>> getYottaOfTheWeekData({http.Client? client}) async {
    var url = yottaServerUrl + '/v1/yotta-of-the-week/';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }
    
    var response =  await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print('data yotta of the week berhasil diambil');

      List data = jsonDecode(response.body);
      List<YottaOfTheWeek> yottaOfTheWeek = [];

      for (var doc in data) {
        yottaOfTheWeek.add(YottaOfTheWeek.fromJson(doc));
      }

      return yottaOfTheWeek;
    } else {
      throw Exception('gagal mengambil data yotta of the week');
    }
  }
}
