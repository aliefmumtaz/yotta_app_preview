part of 'services.dart';

class CheckoutOrderService {
  static Future<void> selectedDrinkListToCheckoutListOrder(
    String id,
    int totalPrice,
    String status,
    String orderDate,
    String? userName,
    // jika true maka delivery
    bool isDataType, {
    String? phoneNumber,
    PreOrderData? preOrderData,
    DeliveryOrderData? deliveryOrderData,
    required String? tokenId,
  }) async {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random _rnd = Random();

    String randomDoc() => String.fromCharCodes(
          Iterable.generate(
            5,
            (_) => _chars.codeUnitAt(
              _rnd.nextInt(_chars.length),
            ),
          ),
        );

    // get drink data
    CollectionReference _allSelectedOrderList = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('selected_drink');

    QuerySnapshot _snapshot = await _allSelectedOrderList.get();

    var _document = _snapshot.docs;

    List<OrderCupDetail> _orderCupDetailList = [];
    List<OrderBottleDetail> _orderBottleDetailList = [];
    List<OrderHotDetail> _orderHotDetailList = [];

    for (var doc in _document) {
      if (doc['tipe'] == 'Dingin') {
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
      } else if (doc['tipe'] == 'Panas') {
        _orderHotDetailList.add(
          OrderHotDetail(
            productName: doc['nama produk'],
            amount: doc['jumlah'],
            sugar: doc['level gula'],
            totalPrice: doc['total harga'],
            type: doc['tipe'],
          ),
        );
      } else if (doc['tipe'] == 'Botol') {
        _orderBottleDetailList.add(
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
    }

    // store to checkout order list
    CollectionReference _checkoutOrderList = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    CollectionReference _checkoutOrderListToAllTransactionDelivery =
        FirebaseFirestore.instance
            .collection('transaksi_delivery')
            .doc('$userName - $id')
            .collection('order_list');

    CollectionReference _checkoutOrderListToAllTransactionPreOrder =
        FirebaseFirestore.instance
            .collection('transaksi_preorder')
            .doc('$userName - $id')
            .collection('order_list');

    if (_orderCupDetailList != []) {
      for (var doc in _orderCupDetailList) {
        _checkoutOrderList.doc().set({
          'nama produk': doc.productName,
          'img': doc.imgUrl,
          'jumlah': doc.amount,
          'tipe': doc.type,
          'ukuran harga': doc.typePrice,
          'nama topping': doc.topping,
          'harga topping': doc.toppingPrice,
          'level ice': doc.iceLevel,
          'level gula': doc.sugarLevel,
          'total harga': doc.totalPrice,
          'tipe produk': doc.cupType,
        });

        // checkout order to collection all transaction
        if (isDataType == true) {
          _checkoutOrderListToAllTransactionDelivery.doc().set({
            'nama produk': doc.productName,
            'img': doc.imgUrl,
            'jumlah': doc.amount,
            'tipe': doc.type,
            'ukuran harga': doc.typePrice,
            'nama topping': doc.topping,
            'harga topping': doc.toppingPrice,
            'level ice': doc.iceLevel,
            'level gula': doc.sugarLevel,
            'total harga': doc.totalPrice,
            'tipe produk': doc.cupType,
          });
        } else {
          _checkoutOrderListToAllTransactionPreOrder.doc().set({
            'nama produk': doc.productName,
            'img': doc.imgUrl,
            'jumlah': doc.amount,
            'tipe': doc.type,
            'ukuran harga': doc.typePrice,
            'nama topping': doc.topping,
            'harga topping': doc.toppingPrice,
            'level ice': doc.iceLevel,
            'level gula': doc.sugarLevel,
            'total harga': doc.totalPrice,
            'tipe produk': doc.cupType,
          });
        }
      }
    }

    if (_orderBottleDetailList != []) {
      for (var doc in _orderBottleDetailList) {
        _checkoutOrderList.doc().set({
          'nama produk': doc.productName,
          'jumlah': doc.amount,
          'ukuran': doc.size,
          'harga ukuran': doc.sizePrice,
          'level gula': doc.sugar,
          'total harga': doc.totalPrice,
          'tipe': doc.type,
        });

        if (isDataType == true) {
          _checkoutOrderListToAllTransactionDelivery.doc().set({
            'nama produk': doc.productName,
            'jumlah': doc.amount,
            'ukuran': doc.size,
            'harga ukuran': doc.sizePrice,
            'level gula': doc.sugar,
            'total harga': doc.totalPrice,
            'tipe': doc.type,
          });
        } else {
          _checkoutOrderListToAllTransactionPreOrder.doc().set({
            'nama produk': doc.productName,
            'jumlah': doc.amount,
            'ukuran': doc.size,
            'harga ukuran': doc.sizePrice,
            'level gula': doc.sugar,
            'total harga': doc.totalPrice,
            'tipe': doc.type,
          });
        }
      }
    }

    if (_orderHotDetailList != []) {
      for (var doc in _orderHotDetailList) {
        _checkoutOrderList.doc().set({
          'nama produk': doc.productName,
          'jumlah': doc.amount,
          'level gula': doc.sugar,
          'tipe': doc.type,
          'total harga': doc.totalPrice,
        });

        if (isDataType == true) {
          _checkoutOrderListToAllTransactionDelivery.doc().set({
            'nama produk': doc.productName,
            'jumlah': doc.amount,
            'level gula': doc.sugar,
            'tipe': doc.type,
            'total harga': doc.totalPrice,
          });
        } else {
          _checkoutOrderListToAllTransactionPreOrder.doc().set({
            'nama produk': doc.productName,
            'jumlah': doc.amount,
            'level gula': doc.sugar,
            'tipe': doc.type,
            'total harga': doc.totalPrice,
          });
        }
      }
    }

    CollectionReference _orderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    CollectionReference _allOrderDelivery =
        FirebaseFirestore.instance.collection('transaksi_delivery');

    CollectionReference _allOrderPreOrder =
        FirebaseFirestore.instance.collection('transaksi_preorder');

    // sort the order based on outlet
    int? _orderSortDelivery;
    int? _orderSortPreOrder;

    if (!isDataType) {
      String? _selectedOutlet = preOrderData!.outlet;

      QuerySnapshot _orderSortPreOrderSnapshot = await _allOrderPreOrder
          .where('outlet', isEqualTo: _selectedOutlet)
          .get();

      // fungsi untuk memberikan nomor antrian
      if (_orderSortPreOrderSnapshot.docs.isEmpty) {
        _orderSortPreOrder = 1;
      } else if (_orderSortPreOrderSnapshot.docs.isNotEmpty) {
        var _sequencOrder = _orderSortPreOrderSnapshot.docs;

        List<int?> _allOrderSort = [];

        for (var doc in _sequencOrder) {
          _allOrderSort.add(doc['urutan order']);
        }

        _allOrderSort.sort();
        _orderSortPreOrder = _allOrderSort.last! + 1;
      }
    } else {
      String? _selectedOutlet = deliveryOrderData!.outlet;

      QuerySnapshot _orderSortDeliveryOrderSnapshot = await _allOrderDelivery
          .where('outlet', isEqualTo: _selectedOutlet)
          .get();

      if (_orderSortDeliveryOrderSnapshot.docs.isEmpty) {
        _orderSortDelivery = 1;
      } else if (_orderSortDeliveryOrderSnapshot.docs.isNotEmpty) {
        var _sequenceOrder = _orderSortDeliveryOrderSnapshot.docs;

        List<int?> _allOrderSort = [];

        for (var doc in _sequenceOrder) {
          _allOrderSort.add(doc['urutan order']);
        }

        _allOrderSort.sort();
        _orderSortDelivery = _allOrderSort.last! + 1;
      }
    }

    // fungsi untuk membuat kode order
    String orderCode = randomDoc();

    // order type
    if (isDataType == true) {
      // data => database user
      _orderType.doc('order_type').set({
        'alamat tujuan': deliveryOrderData!.address,
        'ongkir': deliveryOrderData.deliveryFee,
        'jarak': deliveryOrderData.distance,
        'outlet': deliveryOrderData.outlet,
        'latitude': deliveryOrderData.selectedLocationLat,
        'longitude': deliveryOrderData.selectedLocationLng,
        'tipe order': deliveryOrderData.orderType,
        'total harga': totalPrice,
        'status': status,
        'tanggal order': orderDate,
        'token id': tokenId,
        'tipe': 'a',
        'kode order': orderCode,
      });

      // data => all transaction list
      _allOrderDelivery.doc('$userName - $id').set({
        'alamat tujuan': deliveryOrderData.address,
        'ongkir': deliveryOrderData.deliveryFee,
        'jarak': deliveryOrderData.distance,
        'outlet': deliveryOrderData.outlet,
        'latitude': deliveryOrderData.selectedLocationLat,
        'longitude': deliveryOrderData.selectedLocationLng,
        'tipe order': deliveryOrderData.orderType,
        'total harga': totalPrice,
        'status': status,
        'tanggal order': orderDate,
        'nama user': userName,
        'id user': id,
        'nomor handphone': phoneNumber,
        'token id': tokenId,
        'urutan order': _orderSortDelivery,
        'kode order': orderCode,
      });
    } else {
      // data => database user
      _orderType.doc('order_type').set({
        'outlet': preOrderData!.outlet,
        'tipe order': preOrderData.orderType,
        'waktu pickup': preOrderData.pickupTime,
        'total harga': totalPrice,
        'status': status,
        'tanggal order': orderDate,
        'tipe': 'a',
        'kode order': orderCode,
      });

      // data => all transaction list
      _allOrderPreOrder.doc('$userName - $id').set({
        'outlet': preOrderData.outlet,
        'tipe order': preOrderData.orderType,
        'waktu pickup': preOrderData.pickupTime,
        'total harga': totalPrice,
        'status': status,
        'tanggal order': orderDate,
        'nama user': userName,
        'id user': id,
        'nomor handphone': phoneNumber,
        'token id': tokenId,
        'urutan order': _orderSortPreOrder,
        'kode order': orderCode,
      });
    }
  }

  static Future<List<OrderCupDetail>> getCheckoutedOrderCup(String id) async {
    CollectionReference _userOrderCupCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

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

  static Future<List<OrderBottleDetail>> getCheckoutOrderBottle(
    String id,
  ) async {
    CollectionReference _userOrderBottleCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

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

  static Future<List<OrderHotDetail>> getCheckoutedOrderHot(String id) async {
    CollectionReference _userOrderHotCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

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

  static Future<PreOrderData> getPreOrderData(String id) async {
    CollectionReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    DocumentSnapshot _snapshot =
        await _userOrderCollection.doc('order_type').get();

    PreOrderData _preOrderData = PreOrderData(
      orderType: _snapshot['tipe order'],
      outlet: _snapshot['outlet'],
      pickupTime: _snapshot['waktu pickup'],
      orderID: _snapshot['kode order'],
    );

    return _preOrderData;
  }

  static Future<DeliveryOrderData> getDeliveryData(String id) async {
    CollectionReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    DocumentSnapshot _snapshot =
        await _userOrderCollection.doc('order_type').get();

    var _deliveryOrderData = DeliveryOrderData(
      address: _snapshot['alamat tujuan'],
      deliveryFee: _snapshot['ongkir'],
      distance: _snapshot['jarak'],
      orderType: _snapshot['tipe order'],
      outlet: _snapshot['outlet'],
      selectedLocationLat: _snapshot['latitude'],
      selectedLocationLng: _snapshot['longitude'],
      orderID: _snapshot['kode order'],
    );

    return _deliveryOrderData;
  }

  static Future<int?> getTotalPriceDataAfterCheckout(String id) async {
    DocumentReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order')
        .doc('order_type');

    DocumentSnapshot _snapshot = await _userOrderCollection.get();

    int? total = _snapshot['total harga'];

    return total;
  }

  static Future<String?> getStatusCheckoutOrder(String id) async {
    DocumentReference _userOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order')
        .doc('order_type');

    DocumentSnapshot _snapshot = await _userOrderCollection.get();

    String? status = _snapshot['status'];

    return status;
  }

  static Future<void> deleteCheckoutListOrder(String id) async {
    CollectionReference _userOrderCheckout = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    QuerySnapshot _snapshot = await _userOrderCheckout.get();

    var _document = _snapshot.docs;

    for (var doc in _document) {
      doc.reference.delete();
    }
  }

  static Future<LatLng> getUserLatLng(String id) async {
    CollectionReference _checkoutCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    DocumentSnapshot _outletDoc =
        await _checkoutCollection.doc('order_type').get();

    double lat = _outletDoc['latitude'];
    double lng = _outletDoc['longitude'];

    LatLng userLoc = LatLng(lat, lng);

    return userLoc;
  }

  static Future<LatLng> getOutletLatLng(String id) async {
    CollectionReference _checkoutCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    DocumentSnapshot _outletDoc =
        await _checkoutCollection.doc('order_type').get();

    String? outlet = _outletDoc['outlet'];

    CollectionReference _outletCollection =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _snapshot = await _outletCollection
        .where(
          'outlet',
          isEqualTo: outlet,
        )
        .get();

    var _document = _snapshot.docs;

    double? _lat = 0;
    double? _lng = 0;

    List<double?> _listLat = [];
    List<double?> _listLng = [];

    for (var doc in _document) {
      _listLat.add(doc['lat']);
    }

    for (var doc in _document) {
      _listLng.add(doc['lang']);
    }

    _lat = _listLat[0];
    _lng = _listLng[0];

    var _latLng = LatLng(_lat!, _lng!);

    return _latLng;
  }

  static Future<bool> isCheckouted(String id) async {
    CollectionReference _checkoutOrderCheck = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    QuerySnapshot _snapshot = await _checkoutOrderCheck.get();

    bool _isCheckout = true;

    if (_snapshot.docs.isEmpty) {
      _isCheckout = false;
    }

    return _isCheckout;
  }

  static Future<String> orderTypeCheck(String id) async {
    DocumentReference _checkoutOrderCheck = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order')
        .doc('order_type');

    DocumentSnapshot _snapshot = await _checkoutOrderCheck.get();

    String isType = 'No Data';

    if (_snapshot.exists) {
      if (_snapshot['tipe order'] == 'Delivery') {
        isType = 'Delivery';
      } else if (_snapshot['tipe order'] == 'Pre-Order') {
        isType = 'Pre-Order';
      }
    }

    return isType;
  }

  static Future<String> orderStatusCheck(String id) async {
    DocumentReference _checkoutOrderCheck = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order')
        .doc('order_type');

    DocumentSnapshot _snapshot = await _checkoutOrderCheck.get();

    String _status = 'Dalam Proses';

    if (_snapshot.exists) {
      if (_snapshot['status'] == 'Dalam Proses') {
        _status = 'Dalam Proses';
      } else if (_snapshot['status'] == 'Siap Diambil') {
        _status = 'Siap Diambil';
      }
    }

    return _status;
  }
}
