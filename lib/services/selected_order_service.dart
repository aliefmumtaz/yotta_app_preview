part of 'services.dart';

class SelectedOrderServices {
  static Future<void> setSelectedOrderCup(
    OrderCupDetail orderCupDetail,
    String id,
  ) async {
    CollectionReference _userCupOrderList = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    _userCupOrderList.doc().set({
      'nama produk': orderCupDetail.productName,
      'img': orderCupDetail.imgUrl,
      'jumlah': orderCupDetail.amount,
      'tipe': orderCupDetail.type,
      'ukuran harga': orderCupDetail.typePrice,
      'nama topping': orderCupDetail.topping,
      'harga topping': orderCupDetail.toppingPrice,
      'level ice': orderCupDetail.iceLevel,
      'level gula': orderCupDetail.sugarLevel,
      'total harga': orderCupDetail.totalPrice,
      'tipe produk': orderCupDetail.cupType,
    });
  }

  static Future<void> setSelectedOrderHot(
    OrderHotDetail orderHotDetail,
    String id,
  ) async {
    CollectionReference _userHotOrderList = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    _userHotOrderList.doc().set({
      'nama produk': orderHotDetail.productName,
      'jumlah': orderHotDetail.amount,
      'level gula': orderHotDetail.sugar,
      'tipe': orderHotDetail.type,
      'total harga': orderHotDetail.totalPrice,
    });
  }

  static Future<void> setSelectedOrderBottle(
    OrderBottleDetail orderBottleDetail,
    String id,
  ) async {
    CollectionReference _userBottleOrderList = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    _userBottleOrderList.doc().set({
      'nama produk': orderBottleDetail.productName,
      'jumlah': orderBottleDetail.amount,
      'ukuran': orderBottleDetail.size,
      'harga ukuran': orderBottleDetail.sizePrice,
      'level gula': orderBottleDetail.sugar,
      'total harga': orderBottleDetail.totalPrice,
      'tipe': orderBottleDetail.type,
    });
  }

  static Future<List<OrderHotDetail>> getSelectedOrderHotList(String id) async {
    CollectionReference _userOrderHotCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot =
        await _userOrderHotCollection.where('tipe', isEqualTo: 'Panas').get();

    var _document = _snapshot.docs;

    List<OrderHotDetail> _orderHotDetailList = [];

    for (var doc in _document) {
      _orderHotDetailList.add(
        OrderHotDetail(
          productName: doc['nama produk'],
          amount: doc['jumlah'],
          sugar: doc['level gula'],
          totalPrice: doc['total harga'],
          type: doc['tipe'],
        ),
      );
    }

    return _orderHotDetailList;
  }

  static Future<List<OrderCupDetail>> getSelectedOrderCupList(String id) async {
    CollectionReference _userOrderCupCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot =
        await _userOrderCupCollection.where('tipe', isEqualTo: 'Dingin').get();

    var _document = _snapshot.docs;

    List<OrderCupDetail> _orderCupDetailList = [];

    for (var doc in _document) {
      _orderCupDetailList.add(
        OrderCupDetail(
          productName: doc['nama produk'],
          amount: doc['jumlah'],
          cupType: doc['tipe produk'],
          iceLevel: doc['level ice'],
          imgUrl: doc['img'],
          sugarLevel: doc['level gula'],
          topping: doc['nama topping'],
          toppingPrice: doc['harga topping'],
          totalPrice: doc['total harga'],
          type: doc['tipe'],
          typePrice: doc['ukuran harga'],
        ),
      );
    }

    return _orderCupDetailList;
  }

  static Future<List<OrderBottleDetail>> getSelectedOrderBottleList(
    String id,
  ) async {
    CollectionReference _userOrderBottleCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot = await _userOrderBottleCollection
        .where('tipe', isEqualTo: 'Botol')
        .get();

    var _document = _snapshot.docs;

    List<OrderBottleDetail> _orderBottleDetail = [];

    for (var doc in _document) {
      _orderBottleDetail.add(
        OrderBottleDetail(
          productName: doc['nama produk'],
          amount: doc['jumlah'],
          size: doc['ukuran'],
          sugar: doc['level gula'],
          sizePrice: doc['harga ukuran'],
          type: doc['tipe'],
          totalPrice: doc['total harga'],
        ),
      );
    }

    return _orderBottleDetail;
  }

  static Future<int> getTotalPrice(String id) async {
    CollectionReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot = await _userOrderCollection.get();

    List<int?> _listOfPrice = [];
    int total = 0;

    var _document = _snapshot.docs;

    for (var doc in _document) {
      _listOfPrice.add(doc['total harga']);
    }

    for (var i = 0; i < _listOfPrice.length; i++) {
      total += _listOfPrice[i]!;
    }

    return total;
  }

  static Future<int> getTotalPriceWithDeliveryFee(
    String id,
    double distance,
    int deliveryFee,
  ) async {
    CollectionReference _totalPriceCol = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshotTotalPrice = await _totalPriceCol.get();

    List<int?> _listOfPrice = [];
    int total = 0;

    var _document = _snapshotTotalPrice.docs;

    for (var doc in _document) {
      _listOfPrice.add(doc['total harga']);
    }

    for (var i = 0; i < _listOfPrice.length; i++) {
      total += _listOfPrice[i]!;
    }

    int totalPrice = total + deliveryFee;

    if (total >= 60) {
      totalPrice -= 6;
    }
    // if (distance >= 3 && total >= 50) {
    //   totalPrice -= 20;
    // }

    return totalPrice;
  }

  static Future<int> getDeliveryFee(
    String id,
    double distance,
    int deliveryFee,
  ) async {
    CollectionReference _totalPriceCol = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshotTotalPrice = await _totalPriceCol.get();

    List<int?> _listOfPrice = [];
    int total = 0;

    var _document = _snapshotTotalPrice.docs;

    for (var doc in _document) {
      _listOfPrice.add(doc['total harga']);
    }

    for (var i = 0; i < _listOfPrice.length; i++) {
      total += _listOfPrice[i]!;
    }

    int deliveryFees = deliveryFee;

    // if (distance <= 3 && total >= 60) {
    //   deliveryFees = 0;
    // } else if (distance >= 3.5 && total >= 50) {
    //   deliveryFees = deliveryFee - 20;
    // }
    if (total >= 60) {
      deliveryFees = deliveryFee - 6;

      if (deliveryFees < 0 && deliveryFees < 1) {
        deliveryFees = 0;
      }
    }

    return deliveryFees;
  }

  static Future<void> deleteOrderList(String id) async {
    CollectionReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot = await _userOrderCollection.get();

    var _document = _snapshot.docs;

    for (var doc in _document) {
      doc.reference.delete();
    }
  }
}
