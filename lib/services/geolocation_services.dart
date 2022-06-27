part of 'services.dart';

class LocationServices {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  final Dio _dio;

  LocationServices({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': mapAPI,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }

    return null;
  }

  static Future<bool> outletCityAvailableCheck(String city) async {
    CollectionReference _positionCollection =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _snapshot = await _positionCollection
        .where(
          'kota',
          isEqualTo: city,
        )
        .get();

    var _document = _snapshot.docs;

    if (_document.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<List<NearestOutlet>> getListOfNearestOutlet(String city) async {
    CollectionReference _positionCollection =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _snapshot = await _positionCollection
        .where(
          'kota',
          isEqualTo: city,
        )
        .get();

    var _document = _snapshot.docs;

    List<NearestOutlet> _listOutlet = [];

    for (var doc in _document) {
      if (doc['isDeliveryAvailable'] == true) {
        _listOutlet.add(NearestOutlet(
          latitude: doc['lat'],
          longitude: doc['lang'],
          outletName: doc['outlet'],
        ));
      }
    }

    return _listOutlet;
  }
}
