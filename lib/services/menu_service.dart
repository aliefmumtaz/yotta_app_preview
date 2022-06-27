part of 'services.dart';

class MenuServices {
  static Future<List<Variant>> getVariantList() async {
    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter');

    QuerySnapshot snapshot = await _variantNameList.get();

    var document = snapshot.docs;

    List<Variant> _listVariantName = [];

    for (var doc in document) {
      _listVariantName.add(Variant(variantName: doc['varian']));
    }

    return _listVariantName;
  }

  static Future<List<BottleVariant>> getBottleVariantList() async {
    CollectionReference _variantBottleNameList =
        FirebaseFirestore.instance.collection('menu_filter_botol');

    QuerySnapshot _snapshot = await _variantBottleNameList.get();

    var document = _snapshot.docs;

    List<BottleVariant> _listBottleVariantName = [];

    for (var doc in document) {
      _listBottleVariantName.add(
        BottleVariant(variantName: doc['varian']),
      );
    }

    return _listBottleVariantName;
  }

  static Future<List<HotVariant>> getHotMenuVariantList() async {
    CollectionReference _variantHotNameList =
        FirebaseFirestore.instance.collection('menu_filter_hot');

    QuerySnapshot _snapshot = await _variantHotNameList.get();

    var documents = _snapshot.docs;

    List<HotVariant> _listHotVariantname = [];

    for (var doc in documents) {
      _listHotVariantname.add(HotVariant(variantName: doc['varian']));
    }

    return _listHotVariantname;
  }

  static Future<List<MenuPerVariant>> getMenuPerVariant(
    String? varian,
    String? outlet,
  ) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _menuPerVariant = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    QuerySnapshot snapshot =
        await _menuPerVariant.where('varian', isEqualTo: varian).get();

    var document = snapshot.docs;

    List<MenuPerVariant> _listMenuPerVariant = [];

    for (var doc in document) {
      _listMenuPerVariant.add(
        MenuPerVariant(
          listMenu: Menu(
            varian: doc['varian'],
            name: doc['nama'],
            priceL: doc['harga L'],
            priceR: doc['harga R'],
            isAvailable: doc['ketersediaan'],
            imgUrl: doc['img'],
          ),
        ),
      );
    }

    return _listMenuPerVariant;
  }

  static Future<List<AllMenu>> getAllMenu(String? outlet) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _allMenu = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_temp');

    QuerySnapshot variantSnapshot = await _variantNameList.get();

    var variantDocument = variantSnapshot.docs;

    List<String?> variantName = [];
    List<AllMenu> allMenuList = [];

    for (var doc in variantDocument) {
      variantName.add(doc['varian']);
    }

    for (var i = 0; i < variantName.length; i++) {
      QuerySnapshot snap =
          await _allMenu.where('varian', isEqualTo: variantName[i]).get();

      var document = snap.docs;

      List<MenuPerVariant> menuPerVariantList = [];

      for (var doc in document) {
        menuPerVariantList.add(
          MenuPerVariant(
            listMenu: Menu(
              varian: doc['varian'],
              name: doc['nama'],
              priceL: doc['harga L'],
              priceR: doc['harga R'],
              isAvailable: doc['ketersediaan'],
              imgUrl: doc['img'],
            ),
          ),
        );
      }

      allMenuList.add(
        AllMenu(
          name: variantName[i],
          allMenuList: menuPerVariantList,
        ),
      );
    }

    return allMenuList;
  }

  static Future<List<MenuBottlePerVariant>> getMenuBottlePerVariant(
    String? varian,
    String? outlet,
  ) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _menuBottle = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    QuerySnapshot snaphot =
        await _menuBottle.where('varian botol', isEqualTo: varian).get();

    var document = snaphot.docs;

    List<MenuBottlePerVariant> _listMenuBottlePerVariant = [];

    for (var doc in document) {
      _listMenuBottlePerVariant.add(
        MenuBottlePerVariant(
          bottleMenu: BottleMenu(
            varian: doc['varian botol'],
            name: doc['nama'],
            ml500: doc['500ml'],
            ml1000: doc['1000ml'],
            isAvailable: doc['ketersediaan'],
          ),
        ),
      );
    }

    return _listMenuBottlePerVariant;
  }

  static Future<List<AllMenuBottle>> getAllMenuBottle(String? outlet) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _allMenuBottle = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_botol_temp');

    QuerySnapshot _variantSnapshot = await _variantNameList.get();

    var _variantDocument = _variantSnapshot.docs;

    List<String?> _variantName = [];
    List<AllMenuBottle> _allMenuBottleList = [];

    for (var doc in _variantDocument) {
      _variantName.add(doc['varian']);
    }

    for (var i = 0; i < _variantName.length; i++) {
      QuerySnapshot _snap = await _allMenuBottle
          .where('varian botol', isEqualTo: _variantName[i])
          .get();

      var _document = _snap.docs;

      List<MenuBottlePerVariant> menuBottlePerVariantList = [];

      for (var doc in _document) {
        menuBottlePerVariantList.add(
          MenuBottlePerVariant(
            bottleMenu: BottleMenu(
              varian: doc['varian botol'],
              ml1000: doc['1000ml'],
              ml500: doc['500ml'],
              name: doc['nama'],
              isAvailable: doc['ketersediaan'],
            ),
          ),
        );
      }

      _allMenuBottleList.add(
        AllMenuBottle(
          allMenuBottleList: menuBottlePerVariantList,
          name: _variantName[i],
        ),
      );
    }

    return _allMenuBottleList;
  }

  static Future<List<HotMenuPerVariant>> getHotMenuPerVariant(
    String? varian,
    String? outlet,
  ) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _menuHot = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    QuerySnapshot _snapshot =
        await _menuHot.where('varian hot', isEqualTo: varian).get();

    var document = _snapshot.docs;

    List<HotMenuPerVariant> _listHotMenuPerVariant = [];

    for (var doc in document) {
      _listHotMenuPerVariant.add(
        HotMenuPerVariant(
          hotMenu: HotMenu(
            name: doc['nama'],
            varian: doc['varian hot'],
            priceR: doc['R'],
            isAvailable: doc['ketersediaan'],
          ),
        ),
      );
    }

    return _listHotMenuPerVariant;
  }

  static Future<List<AllHotMenu>> getAllHotMenu(String? outlet) async {
    CollectionReference _docCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _docQuery =
        await _docCol.where('outlet', isEqualTo: outlet).get();

    List<DocumentSnapshot> _docList = _docQuery.docs;

    String docName = _docList[0].id;

    CollectionReference _allHotMenu = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc(docName)
        .collection('menu_stock');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_hot_temp');

    QuerySnapshot _variantSnaphot = await _variantNameList.get();

    var variantDoc = _variantSnaphot.docs;

    List<String?> _variantName = [];
    List<AllHotMenu> _allHotMenuList = [];

    for (var doc in variantDoc) {
      _variantName.add(doc['varian']);
    }

    for (var i = 0; i < _variantName.length; i++) {
      QuerySnapshot _snap = await _allHotMenu
          .where('varian hot', isEqualTo: _variantName[i])
          .get();

      var _document = _snap.docs;

      List<HotMenuPerVariant> _hotMenuPerVariantList = [];

      for (var doc in _document) {
        _hotMenuPerVariantList.add(
          HotMenuPerVariant(
            hotMenu: HotMenu(
              name: doc['nama'],
              priceR: doc['R'],
              varian: doc['varian hot'],
              isAvailable: doc['ketersediaan'],
            ),
          ),
        );
      }

      _allHotMenuList.add(
        AllHotMenu(
          hotMenuPerVariant: _hotMenuPerVariantList,
          name: _variantName[i],
        ),
      );
    }

    return _allHotMenuList;
  }

  // static String outlet = 'makassar01';

  static Future<void> tesMenu() async {
    CollectionReference _allMenu =
        FirebaseFirestore.instance.collection('menu');

    DocumentSnapshot _docSnap = await _allMenu.doc('boba_brown_sugar_01').get();

    print(_docSnap['img']);
  }

  static Future<void> setNewDatabase(String outlet) async {
    // String outlet = 'parepare01';
    print('== memulai import produk ke $outlet ==');
    // Get All Menu
    CollectionReference _allMenu =
        FirebaseFirestore.instance.collection('menu');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_temp');

    QuerySnapshot variantSnapshot = await _variantNameList.get();

    var variantDocument = variantSnapshot.docs;

    List<String?> variantName = [];
    List<AllMenu> allMenuList = [];

    List<DocumentSnapshot> _listDocName = [];
    List<String> docNameList = [];

    for (var doc in variantDocument) {
      variantName.add(doc['varian']);
    }

    for (var i = 0; i < variantName.length; i++) {
      QuerySnapshot snap =
          await _allMenu.where('varian', isEqualTo: variantName[i]).get();

      _listDocName = snap.docs;

      for (var doc in _listDocName) {
        print(doc['img']);
        docNameList.add(doc.id);
      }

      var document = snap.docs;

      List<MenuPerVariant> menuPerVariantList = [];

      for (var doc in document) {
        menuPerVariantList.add(
          MenuPerVariant(
            listMenu: Menu(
              isRecommended: false,
              isAvailable: true,
              varian: doc['varian'] ?? '',
              name: doc['nama'] ?? '',
              priceL: doc['harga L'] ?? '',
              priceR: doc['harga R'] ?? '',
              imgUrl: doc['img'] ?? '',
            ),
          ),
        );
      }

      allMenuList.add(
        AllMenu(
          name: variantName[i],
          allMenuList: menuPerVariantList,
        ),
      );
    }

    print('');
    print('total produk = ${docNameList.length}');
    print('');

    // set data
    CollectionReference _setCol = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc('$outlet')
        .collection('menu_stock');

    for (var i = 0; i < allMenuList.length; i++) {
      for (var doc in allMenuList[i].allMenuList!) {
        await _setCol.doc().set({
          'harga L': doc.listMenu!.priceL ?? '',
          'harga R': doc.listMenu!.priceR ?? '',
          'nama': doc.listMenu!.name ?? '',
          'varian': doc.listMenu!.varian ?? '',
          'recomendation': false,
          'ketersediaan': true,
          'img': doc.listMenu!.imgUrl ?? '',
        });

        print(
          '- nama produk: ${doc.listMenu!.name} / varian: ${doc.listMenu!.varian} / harga L:  ${doc.listMenu!.priceL} / harga R: ${doc.listMenu!.priceR} - sukses',
        );
      }
    }

    // get total after import
    QuerySnapshot _querCol = await _setCol.get();

    List<DocumentSnapshot> _listSnapAfterImport = _querCol.docs;

    print('');
    print('total produk setelah import = ${_listSnapAfterImport.length}');

    print('');
    print('== fungsi selesai ==');
  }

  static Future<void> setNewDatabaseHotMenu(String outlet) async {
    // String outlet = 'gowa01';
    print('== memulai import produk hot ke $outlet ==');

    CollectionReference _allMenu =
        FirebaseFirestore.instance.collection('menu');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_hot_temp');

    QuerySnapshot variantSnapshot = await _variantNameList.get();

    var variantDocument = variantSnapshot.docs;

    List<String?> variantName = [];
    List<AllHotMenu> allMenuList = [];

    List<DocumentSnapshot> _listDocName = [];
    List<String> docNameList = [];

    for (var doc in variantDocument) {
      variantName.add(doc['varian']);
    }

    for (var i = 0; i < variantName.length; i++) {
      QuerySnapshot snap =
          await _allMenu.where('varian hot', isEqualTo: variantName[i]).get();

      _listDocName = snap.docs;

      for (var doc in _listDocName) {
        docNameList.add(doc.id);
      }

      var document = snap.docs;

      List<HotMenuPerVariant> hotMenuPerVariantList = [];

      for (var doc in document) {
        hotMenuPerVariantList.add(
          HotMenuPerVariant(
            hotMenu: HotMenu(
              name: doc['nama'],
              priceR: doc['R'],
              varian: doc['varian hot'],
            ),
          ),
        );
      }

      allMenuList.add(
        AllHotMenu(
          hotMenuPerVariant: hotMenuPerVariantList,
          name: variantName[i],
        ),
      );
    }

    print('');
    print('total produk = ${docNameList.length}');
    print('');

    CollectionReference _setCol = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc('$outlet')
        .collection('menu_stock');

    for (var i = 0; i < allMenuList.length; i++) {
      for (var doc in allMenuList[i].hotMenuPerVariant!) {
        await _setCol.doc().set({
          'R': doc.hotMenu!.priceR,
          'nama': doc.hotMenu!.name,
          'varian hot': doc.hotMenu!.varian,
          'ketersediaan': true,
        });

        print(
          '- nama produk: ${doc.hotMenu!.name} / varian: ${doc.hotMenu!.varian} / harga: ${doc.hotMenu!.priceR} - sukses',
        );
      }
    }

    QuerySnapshot _querCol = await _setCol.get();

    List<DocumentSnapshot> _listSnapAfterImport = _querCol.docs;

    print('');
    print('total produk setelah import = ${_listSnapAfterImport.length}');

    print('');
    print('== fungsi selesai ==');
  }

  static Future<void> setNewDatabaseBottleMenu(String outlet) async {
    // String outlet = 'parepare01';
    print('== memulai import produk bottle ke $outlet ==');

    CollectionReference _allMenu =
        FirebaseFirestore.instance.collection('menu');

    CollectionReference _variantNameList =
        FirebaseFirestore.instance.collection('menu_filter_botol_temp');

    QuerySnapshot variantSnapshot = await _variantNameList.get();

    var variantDocument = variantSnapshot.docs;

    List<String?> variantName = [];
    List<AllMenuBottle> allMenuList = [];

    List<DocumentSnapshot> _listDocName = [];
    List<String> docNameList = [];

    for (var doc in variantDocument) {
      variantName.add(doc['varian']);
    }

    for (var i = 0; i < variantName.length; i++) {
      QuerySnapshot snap =
          await _allMenu.where('varian botol', isEqualTo: variantName[i]).get();

      _listDocName = snap.docs;

      for (var doc in _listDocName) {
        docNameList.add(doc.id);
      }

      var document = snap.docs;

      List<MenuBottlePerVariant> bottleMenuPerVariant = [];

      for (var doc in document) {
        bottleMenuPerVariant.add(
          MenuBottlePerVariant(
            bottleMenu: BottleMenu(
              ml1000: doc['1000ml'],
              ml500: doc['500ml'],
              name: doc['nama'],
              varian: doc['varian botol'],
            ),
          ),
        );
      }

      allMenuList.add(
        AllMenuBottle(
          allMenuBottleList: bottleMenuPerVariant,
          name: variantName[i],
        ),
      );
    }

    print('');
    print('total produk = ${docNameList.length}');
    print('');

    CollectionReference _setCol = FirebaseFirestore.instance
        .collection('list_outlet')
        .doc('$outlet')
        .collection('menu_stock');

    for (var i = 0; i < allMenuList.length; i++) {
      for (var doc in allMenuList[i].allMenuBottleList!) {
        await _setCol.doc().set({
          '1000ml': doc.bottleMenu!.ml1000,
          '500ml': doc.bottleMenu!.ml500,
          'nama': doc.bottleMenu!.name,
          'varian botol': doc.bottleMenu!.varian,
          'ketersediaan': true,
        });

        print(
          '- nama produk: ${doc.bottleMenu!.name} / varian: ${doc.bottleMenu!.varian} / 1000ml: ${doc.bottleMenu!.ml1000} / 500ml: ${doc.bottleMenu!.ml500} - sukses',
        );
      }
    }

    QuerySnapshot _querCol = await _setCol.get();

    List<DocumentSnapshot> _listSnapAfterImport = _querCol.docs;

    print('');
    print('total produk setelah import = ${_listSnapAfterImport.length}');

    print('');
    print('== fungsi selesai ==');
  }

  static Future<void> setDatabase() async {
    CollectionReference _listOutletCol =
        FirebaseFirestore.instance.collection('list_outlet');

    QuerySnapshot _querSnap = await _listOutletCol.get();

    var _listOfOutlet = _querSnap.docs;

    List<String> _docList = [];

    for (var doc in _listOfOutlet) {
      _docList.add(doc.id);
    }

    List<String> _docToStr = [];

    for (var doc in _docList) {
      _docToStr.add(doc);
    }

    for (var i = 0; i < _docToStr.length; i++) {
      await setNewDatabase(_docToStr[i]);
      await setNewDatabaseBottleMenu(_docToStr[i]);
      await setNewDatabaseHotMenu(_docToStr[i]);
    }
    // await setNewDatabase('bone01');
    // await setNewDatabaseBottleMenu('bone01');
    // await setNewDatabaseHotMenu('bone01');

    print('- program success -');
  }
}
