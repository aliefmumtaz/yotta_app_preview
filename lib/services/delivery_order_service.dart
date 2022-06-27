part of 'services.dart';

class DeliveryService {
  static Future<bool> checkingDeliveryQueueOrder(String? outlet) async {
    CollectionReference _deliveryOrderCollection =
        FirebaseFirestore.instance.collection('transaksi_delivery');

    QuerySnapshot _deliverySnapshot =
        await _deliveryOrderCollection.where('outlet', isEqualTo: outlet).get();

    var _document = _deliverySnapshot.docs;

    if (_document.length >= 3) {
      print('penuh');

      return false;
    } else {
      print('tidak penuh');

      return true;
    }
  }

  static Future<List<String>> chekingFullQueueListOutlet() async {
    CollectionReference _deliveryOrderCollection =
        FirebaseFirestore.instance.collection('transaksi_delivery');

    CollectionReference _listAvaiableOutletDelivery =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _listAvaiableOutletDeliverySnapshot =
        await _listAvaiableOutletDelivery
            .where(
              'isDeliveryAvailable',
              isEqualTo: true,
            )
            .get();

    List<String> listOfOutletFullOrder = [];

    var _docAvailOutletDelivery = _listAvaiableOutletDeliverySnapshot.docs;

    for (var doc in _docAvailOutletDelivery) {
      QuerySnapshot _deliverySnapshot = await _deliveryOrderCollection
          .where('outlet', isEqualTo: doc['outlet'])
          .get();

      var _listOrder = _deliverySnapshot.docs;

      if (_listOrder.length >= 3) {
        listOfOutletFullOrder.add(doc['outlet']);
      }
    }

    return listOfOutletFullOrder;
  }

  static Future<OtherRecommendedOutlet> getRecommendedOutetData(
      String? outlet) async {
    CollectionReference _outletLocation =
        FirebaseFirestore.instance.collection('list_outlet');

    // QuerySnapshot _outletSnapshot = await _outletLocation.where('outlet', isEqualTo: outlet).get();
    QuerySnapshot _outletSnapshot =
        await _outletLocation.where('outlet', isEqualTo: outlet).get();

    var _document = _outletSnapshot.docs;

    List<OtherRecommendedOutlet> _otherRecommendedOutlet = [];

    for (var doc in _document) {
      _otherRecommendedOutlet.add(OtherRecommendedOutlet(
        lat: doc['lat'],
        long: doc['lang'],
        outlet: doc['outlet'],
      ));
    }

    return _otherRecommendedOutlet[0];
  }
}
