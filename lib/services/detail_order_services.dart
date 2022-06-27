part of 'services.dart';

class DetailOrderServices {
  static Future<List<Topping>> getToppingLit() async {
    CollectionReference _topping =
        FirebaseFirestore.instance.collection('topping');

    QuerySnapshot _snapshot = await _topping.get();

    var _document = _snapshot.docs;

    List<Topping> _listTopping = [];

    for (var doc in _document) {
      _listTopping.add(Topping(
        name: doc['nama'],
        price: doc['price'],
        img: doc['img'],
      ));
    }

    return _listTopping;
  }

  static Future<List<IceType>> getIceType() async {
    CollectionReference _iceType =
        FirebaseFirestore.instance.collection('ice_type');

    QuerySnapshot _snapshot = await _iceType.get();

    var _document = _snapshot.docs;

    List<IceType> _iceList = [];

    for (var doc in _document) {
      _iceList.add(IceType(name: doc['nama']));
    }

    return _iceList;
  }

  static Future<List<SugarType>> getSugarType() async {
    CollectionReference _sugarType =
        FirebaseFirestore.instance.collection('sugar_type');

    QuerySnapshot _snapshot = await _sugarType.get();

    var _document = _snapshot.docs;

    List<SugarType> _sugarList = [];

    for (var doc in _document) {
      _sugarList.add(SugarType(name: doc['nama']));
    }

    return _sugarList;
  }
}
