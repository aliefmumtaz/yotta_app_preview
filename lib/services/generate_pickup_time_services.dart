part of 'services.dart';

class PickupTimeServices {
  static Future<List<PickupTime>> getPickUpTimeList() async {
    int currentHour = 17;
    // int currentHour = DateTime.now().hour;
    int currentMinute = 20;
    // int currentMinute = DateTime.now().minute;

    String? updatedMinutes;
    String hours;
    if (currentMinute == 0) {
      updatedMinutes = '30';
    } else if (currentMinute > 0 && currentMinute <= 10) {
      updatedMinutes = '30';
    } else if (currentMinute > 10 && currentMinute <= 40) {
      updatedMinutes = '00';
      currentHour += 1;
    } else if (currentMinute > 40 && currentMinute < 60) {
      if (currentHour == 19) {
        updatedMinutes = '00';
        currentHour += 1;
      } else {
        updatedMinutes = '30';
        currentHour += 1;
      }
    }

    hours = '$currentHour:$updatedMinutes';

    CollectionReference _pickupTimeCollection =
        FirebaseFirestore.instance.collection('pickup_time');

    QuerySnapshot _snapshot = await _pickupTimeCollection
        .orderBy('pukul')
        .startAt([hours])
        .limit(4)
        .get();

    var _documnet = _snapshot.docs;

    List<PickupTime> _pickUpTimeList = [];

    for (var doc in _documnet) {
      _pickUpTimeList.add(PickupTime(doc['pukul']));
    }

    return _pickUpTimeList;
  }
}
