part of 'services.dart';

class OutletServices {
  static Future<List<Outlet>> getOutletListPerCity({
    http.Client? client,
    required String city,
  }) async {
    // CollectionReference _outlet = FirebaseFirestore.instance.collection(
    //   'list_outlet',
    // );

    // QuerySnapshot _snapshot =
    //     await _outlet.where('kota', isEqualTo: city).get();

    // var _document = _snapshot.docs;

    // List<Outlet> _listOfOutlet = [];

    // for (var doc in _document) {
    //   _listOfOutlet.add(
    //     Outlet(
    //       name: doc['outlet'] ?? '',
    //       address: doc['alamat'] ?? '',
    //       lat: doc['lat'] ?? -5.161782056064433,
    //       lang: doc['lang'] ?? 119.39518237444452,
    //       isOpen: doc['isOpen'],
    //     ),
    //   );
    // }

    // return _listOfOutlet;
    var url = yottaServerUrl + '/v1/outlet';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      print('data = $data');

      List<Outlet> outlets = [];
      List<Outlet> outletsByCity = [];

      for (var doc in data) {
        outlets.add(Outlet.fromJson(doc));
      }

      print('berhasil mengambil data outlet . . . . . ');

      for (var doc in outlets) {
        if (doc.city == city) {
          outletsByCity.add(Outlet(
            address: doc.address,
            city: doc.city,
            isOpen: doc.isOpen,
            lang: doc.lang,
            lat: doc.lat,
            name: doc.name,
          ));
        }
      }

      return outletsByCity;
    } else {
      throw Exception('gagal mengambil data outlet');
    }
  }

  static Future<LatLngInitialLocation> getFirstOutletOnSelectedCity(
      String? city,
      {http.Client? client}) async {
    // CollectionReference _firstOutlet =
    //     FirebaseFirestore.instance.collection('list_outlet');

    // QuerySnapshot _snapshot =
    //     await _firstOutlet.where('kota', isEqualTo: city).get();

    // var _document = _snapshot.docs;

    // List<LatLngInitialLocation> _allOutletLatLng = [];

    // for (var doc in _document) {
    //   _allOutletLatLng.add(
    //     LatLngInitialLocation(
    //       lat: doc['lat'],
    //       lang: doc['lang'],
    //     ),
    //   );
    // }

    // return _allOutletLatLng.first;
    var url = yottaServerUrl + '/v1/outlet';
    var headers = {'Content-Type': 'application/json'};

    if (client == null) {
      client = http.Client();
    }

    var response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<Outlet> outlets = [];

      for (var doc in data) {
        outlets.add(Outlet.fromJson(doc));
      }

      List<Outlet> outletByCity = [];

      for (var doc in outlets) {
        if (doc.city == city) {
          outletByCity.add(Outlet(
            address: doc.address,
            city: doc.city,
            isOpen: doc.isOpen,
            lang: doc.lang,
            lat: doc.lat,
            name: doc.name,
          ));
        }
      }

      Outlet firstOutlet = outletByCity.first;

      var latLngInitialLocation = LatLngInitialLocation(
        lang: firstOutlet.lang,
        lat: firstOutlet.lat,
      );

      return latLngInitialLocation;
    } else {
      throw Exception('gagal mengambil data outlet . . . . . ');
    }
  }
}
