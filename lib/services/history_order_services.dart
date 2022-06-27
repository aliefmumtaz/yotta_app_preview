part of 'services.dart';

class HistoryOrderServices {
  static Future<void> checkoutDrinkListToHistoryOrder(
    String id,
    bool isDelivery,
    User user,
    String orderID,
  ) async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String randomDoc() => String.fromCharCodes(
          Iterable.generate(
            5,
            (_) => _chars.codeUnitAt(
              _rnd.nextInt(_chars.length),
            ),
          ),
        );

    String doc = randomDoc();

    // get drink data
    CollectionReference _allSelectedCheckoutOrderList = FirebaseFirestore
        .instance
        .collection('user')
        .doc(id)
        .collection('checkout_order');

    QuerySnapshot _snapshot = await _allSelectedCheckoutOrderList.get();

    var _document = _snapshot.docs;

    print(_document);

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

    // store to history order collection
    CollectionReference _historyOrderCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order')
        .doc(doc)
        .collection('order_list');

    // store to all history order collection
    CollectionReference _historyOrderToAllOrderCollection = FirebaseFirestore
        .instance
        .collection('semua_transaksi_pre_order')
        .doc('${user.idMember} - $orderID - $id')
        .collection('order_list');

    // insert user data to all order collection
    // DocumentReference _userDataCollection = FirebaseFirestore.instance
    //     .collection('semua_transaksi_pre_order')
    //     .doc('${user.idMember} - $orderID - $id');

    // await _userDataCollection.set({
    //   'email': user.email,
    //   'nama': user.name,
    //   'id member': user.idMember,
    //   'nomor handphone': user.phoneNumber,
    //   'kota': user.city,
    // });

    // menyimpan di database user
    if (_orderCupDetailList.isNotEmpty) {
      for (var doc in _orderCupDetailList) {
        _historyOrderCollection.doc().set({
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

    if (_orderBottleDetailList.isNotEmpty) {
      for (var doc in _orderBottleDetailList) {
        _historyOrderCollection.doc().set({
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

    if (_orderHotDetailList.isNotEmpty) {
      for (var doc in _orderHotDetailList) {
        _historyOrderCollection.doc().set({
          'nama produk': doc.productName,
          'jumlah': doc.amount,
          'level gula': doc.sugar,
          'tipe': doc.type,
          'total harga': doc.totalPrice,
        });
      }
    }

    // menyimpan di database semua transaksi
    if (_orderCupDetailList.isNotEmpty) {
      for (var doc in _orderCupDetailList) {
        _historyOrderToAllOrderCollection.doc().set({
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

    if (_orderBottleDetailList.isNotEmpty) {
      for (var doc in _orderBottleDetailList) {
        _historyOrderToAllOrderCollection.doc().set({
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

    if (_orderHotDetailList.isNotEmpty) {
      for (var doc in _orderHotDetailList) {
        _historyOrderToAllOrderCollection.doc().set({
          'nama produk': doc.productName,
          'jumlah': doc.amount,
          'level gula': doc.sugar,
          'tipe': doc.type,
          'total harga': doc.totalPrice,
        });
      }
    }

    // get order type data
    late PreOrderData _orderTypeData;
    late DeliveryOrderData _deliveryOrderData;
    String? _status = '';
    String? _orderDate = '';
    int? _totalPrice = 0;

    DocumentReference _orderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('checkout_order')
        .doc('order_type');

    DocumentSnapshot _orderTypeSnapshot = await _orderType.get();

    if (isDelivery == false) {
      _orderTypeData = PreOrderData(
        orderType: _orderTypeSnapshot['tipe order'],
        outlet: _orderTypeSnapshot['outlet'],
        pickupTime: _orderTypeSnapshot['waktu pickup'],
        orderID: _orderTypeSnapshot['kode order'],
      );

      _status = _orderTypeSnapshot['status'];
      _orderDate = _orderTypeSnapshot['tanggal order'];
      _totalPrice = _orderTypeSnapshot['total harga'];
    } else {
      _deliveryOrderData = DeliveryOrderData(
        orderID: _orderTypeSnapshot['kode order'],
        address: _orderTypeSnapshot['alamat tujuan'],
        deliveryFee: _orderTypeSnapshot['ongkir'],
        distance: _orderTypeSnapshot['jarak'],
        orderType: _orderTypeSnapshot['tipe order'],
        outlet: _orderTypeSnapshot['outlet'],
        selectedLocationLat: _orderTypeSnapshot['latitude'],
        selectedLocationLng: _orderTypeSnapshot['longitude'],
      );

      _status = _orderTypeSnapshot['status'];
      _orderDate = _orderTypeSnapshot['tanggal order'];
      _totalPrice = _orderTypeSnapshot['total harga'];
    }

    //  get all list product name
    List<String?> _productName = [];

    if (_orderHotDetailList.isNotEmpty) {
      for (var doc in _orderHotDetailList) {
        _productName.add(
          doc.productName,
        );
      }
    }

    if (_orderCupDetailList.isNotEmpty) {
      for (var doc in _orderCupDetailList) {
        _productName.add(
          doc.productName,
        );
      }
    }

    if (_orderBottleDetailList.isNotEmpty) {
      for (var doc in _orderBottleDetailList) {
        _productName.add(
          doc.productName,
        );
      }
    }

    // generate sequence number
    int? _sequence;

    CollectionReference _orderSequence = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order');

    QuerySnapshot _sequenceSnapshot = await _orderSequence.get();

    if (_sequenceSnapshot.docs.isEmpty) {
      _sequence = 1;
    } else if (_sequenceSnapshot.docs.isNotEmpty) {
      var _sequenceDoc = _sequenceSnapshot.docs;

      List<int?> _allSequenceList = [];

      for (var doc in _sequenceDoc) {
        _allSequenceList.add(doc['urutan order']);
      }

      _allSequenceList.sort();
      _sequence = _allSequenceList.last! + 1;
    }

    // set order type to history order
    DocumentReference _orderTypeCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order')
        .doc(doc);

    DocumentReference _orderTypeOnAllOrderCollection = FirebaseFirestore
        .instance
        .collection('semua_transaksi_pre_order')
        .doc('${user.idMember} - $orderID - $id');

    if (isDelivery == false) {
      // to databse user
      _orderTypeCollection.set({
        'outlet': _orderTypeData.outlet,
        'tipe order': _orderTypeData.orderType,
        'waktu pickup': _orderTypeData.pickupTime,
        'total harga': _totalPrice,
        'status': _status,
        'tanggal order': _orderDate,
        'docID': doc,
        'list semua pesanan': _productName,
        'urutan order': _sequence,
        'kode order': _orderTypeData.orderID,
      });

      // to database all order
      _orderTypeOnAllOrderCollection.set({
        'outlet': _orderTypeData.outlet,
        'tipe order': _orderTypeData.orderType,
        'waktu pickup': _orderTypeData.pickupTime,
        'total harga': _totalPrice,
        'status': _status,
        'tanggal order': _orderDate,
        'docID': doc,
        'list semua pesanan': _productName,
        'urutan order': _sequence,
        'kode order': _orderTypeData.orderID,
        'email': user.email,
        'nama': user.name,
        'id member': user.idMember,
        'nomor handphone': user.phoneNumber,
        'kota': user.city,
      });
    } else {
      // to database user
      _orderTypeCollection.set({
        'alamat tujuan': _deliveryOrderData.address,
        'ongkir': _deliveryOrderData.deliveryFee,
        'jarak': _deliveryOrderData.distance,
        'outlet': _deliveryOrderData.outlet,
        'latitude': _deliveryOrderData.selectedLocationLat,
        'longitude': _deliveryOrderData.selectedLocationLng,
        'tipe order': _deliveryOrderData.orderType,
        'total harga': _totalPrice,
        'status': _status,
        'tanggal order': _orderDate,
        'docID': doc,
        'list semua pesanan': _productName,
        'urutan order': _sequence,
        'kode order': _deliveryOrderData.orderID,
      });

      // to database all order
      _orderTypeOnAllOrderCollection.set({
        'alamat tujuan': _deliveryOrderData.address,
        'ongkir': _deliveryOrderData.deliveryFee,
        'jarak': _deliveryOrderData.distance,
        'outlet': _deliveryOrderData.outlet,
        'latitude': _deliveryOrderData.selectedLocationLat,
        'longitude': _deliveryOrderData.selectedLocationLng,
        'tipe order': _deliveryOrderData.orderType,
        'total harga': _totalPrice,
        'status': _status,
        'tanggal order': _orderDate,
        'docID': doc,
        'list semua pesanan': _productName,
        'urutan order': _sequence,
        'kode order': _deliveryOrderData.orderID,
        'email': user.email,
        'nama': user.name,
        'id member': user.idMember,
        'nomor handphone': user.phoneNumber,
        'kota': user.city,
      });
    }
  }

  static Future<List<OrderBottleDetail>> getHistoryOrderBottleOrder(
    String id,
    String? orderID,
  ) async {
    CollectionReference _historyOrderBottleCollection = FirebaseFirestore
        .instance
        .collection('user')
        .doc(id)
        .collection('history_order')
        .doc(orderID)
        .collection('order_list');

    QuerySnapshot _snapshot = await _historyOrderBottleCollection
        .where('tipe', isEqualTo: 'Botol')
        .get();

    var _document = _snapshot.docs;

    List<OrderBottleDetail> _orderBottleList = [];

    for (var doc in _document) {
      _orderBottleList.add(
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

    return _orderBottleList;
  }

  static Future<List<OrderCupDetail>> getHistoryOrderCupOrder(
    String id,
    String? orderID,
  ) async {
    CollectionReference _historyOrderCupCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order')
        .doc(orderID)
        .collection('order_list');

    QuerySnapshot _snapshot = await _historyOrderCupCollection
        .where('tipe', isEqualTo: 'Dingin')
        .get();

    var _document = _snapshot.docs;

    List<OrderCupDetail> _orderCupList = [];

    for (var doc in _document) {
      _orderCupList.add(
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

    return _orderCupList;
  }

  static Future<List<OrderHotDetail>> getHistoryOrderHotOrder(
    String id,
    String? orderID,
  ) async {
    CollectionReference _historyOrderHotCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order')
        .doc(orderID)
        .collection('order_list');

    QuerySnapshot _snapshot = await _historyOrderHotCollection
        .where('tipe', isEqualTo: 'Panas')
        .get();

    var _document = _snapshot.docs;

    List<OrderHotDetail> _orderHotList = [];

    for (var doc in _document) {
      _orderHotList.add(
        OrderHotDetail(
          productName: doc['nama produk'],
          amount: doc['jumlah'],
          sugar: doc['level gula'],
          totalPrice: doc['total harga'],
          type: doc['tipe'],
        ),
      );
    }

    return _orderHotList;
  }

  static Future<List<HistoryOrder>> getHistoryOrderType(String id) async {
    CollectionReference _historyOrderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order');

    QuerySnapshot _snapshot = await _historyOrderType
        .orderBy(
          'urutan order',
          descending: true,
        )
        // .where('tipe order', isEqualTo: 'Pre-Order')
        .get();

    var _document = _snapshot.docs;

    List<HistoryOrder> _historyOrderList = [];

    for (var doc in _document) {
      if (doc['tipe order'] == 'Pre-Order') {
        List<String?> _productNameList = [];

        for (var doc in doc['list semua pesanan']) {
          _productNameList.add(doc + ', ');
        }

        String _productNameMerged = _productNameList.join();

        _historyOrderList.add(
          HistoryOrder(
            orderID: doc['kode order'] ?? '',
            imgUrl: '',
            orderDate: doc['tanggal order'],
            orderDocID: doc['docID'],
            orderType: doc['tipe order'],
            productName: _productNameMerged.substring(
              0,
              _productNameMerged.length - 2,
            ),
            outlet: doc['outlet'],
            pickupTime: doc['waktu pickup'],
            totalPrice: doc['total harga'],
          ),
        );
      }
    }

    return _historyOrderList;
  }

  static Future<List<HistoryOrderDelivery>> getHistoryOrderDeliveryType(
    String id,
  ) async {
    CollectionReference _historyOrderType = FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('history_order');

    QuerySnapshot _snapshot = await _historyOrderType
        .orderBy(
          'urutan order',
          descending: true,
        )
        .get();

    var _document = _snapshot.docs;

    List<HistoryOrderDelivery> _historyOrderDeliveryList = [];

    for (var doc in _document) {
      if (doc['tipe order'] == 'Delivery') {
        List<String?> _productNameList = [];

        for (var doc in doc['list semua pesanan']) {
          _productNameList.add(doc + ', ');
        }

        String _productNameMerged = _productNameList.join();

        _historyOrderDeliveryList.add(
          HistoryOrderDelivery(
            orderID: doc['kode order'],
            distance: doc['jarak'],
            address: doc['alamat tujuan'],
            deliveryFee: doc['ongkir'],
            orderDate: doc['tanggal order'],
            orderDocID: doc['docID'],
            orderType: doc['tipe order'],
            outlet: doc['outlet'],
            productName: _productNameMerged.substring(
              0,
              _productNameMerged.length - 2,
            ),
            totalPrice: doc['total harga'],
          ),
        );
      }
    }

    return _historyOrderDeliveryList;
  }
}
