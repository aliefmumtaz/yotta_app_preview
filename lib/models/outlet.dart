part of 'models.dart';

class Outlet extends Equatable {
  final String? name;
  final String? address;
  final double? lat;
  final double? lang;
  final bool? isOpen;
  final String? city;

  Outlet({
    required this.name,
    required this.address,
    required this.lat,
    required this.lang,
    required this.isOpen,
    required this.city,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        lat,
        lang,
        isOpen,
        city,
      ];

  factory Outlet.fromJson(Map<dynamic, dynamic> map) {
    String latString = map['lat'];
    double lat = double.parse(latString);

    String langString = map['lang'];
    double lang = double.parse(langString);

    return Outlet(
      city: map['kota'],
      name: map['outlet'],
      address: map['alamat'],
      isOpen: map['is_open'],
      lang: lang,
      lat: lat,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'outlet': name,
      'alamat': address,
      'is_open': isOpen,
      'lang': lang,
      'lat': lat,
      'kota': city,
    };
  }
}

class CityOutlet extends Equatable {
  final String? name;

  CityOutlet({required this.name});

  @override
  List<Object?> get props => [name];

  factory CityOutlet.fromJson(Map<dynamic, dynamic> map) {
    return CityOutlet(name: map['kota']);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'kota': name,
    };
  }
}

class LatLngInitialLocation extends Equatable {
  final double? lat;
  final double? lang;

  LatLngInitialLocation({required this.lat, required this.lang});

  @override
  List<Object?> get props => [lat, lang];

  factory LatLngInitialLocation.fromJson(Map<dynamic, dynamic> map) {
    return LatLngInitialLocation(
      lang: map['lang'],
      lat: map['lat'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'lang': lang,
      'lat': lat,
    };
  }
}

class OtherRecommendedOutlet extends Equatable {
  final String? outlet;
  final double? lat;
  final double? long;

  OtherRecommendedOutlet({
    required this.lat,
    required this.long,
    required this.outlet,
  });

  @override
  List<Object?> get props => [lat, long, outlet];
}
