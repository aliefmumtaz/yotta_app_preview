part of 'services.dart';

class UserData {
    static CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');

  static Future<void> maxMinAge({bool isMaxAge = true}) async {
    print('getting all user data . . . . . . . \n');
    QuerySnapshot userSnapshot = await userCollection.get();

    var document = userSnapshot.docs;

    List<String> allUserData = [];

    for (var doc in document) {
      allUserData.add(doc['tanggal lahir']);
    }

    List<int> allUserAgeData = [];

    print('converting user birtdate to number . . . . . . . . \n');
    for (var doc in allUserData) {
      var strToInt = int.parse(doc.split(' ')[1]);

      allUserAgeData.add(strToInt);
    }

    print('sorting member age . . . . . . . . \n');
    allUserAgeData.sort();

    int age = 0;

    if (isMaxAge) {
      int maxAge = allUserAgeData.max;
      age = 2021 - maxAge;
    } else {
      int minAge = allUserAgeData.min;
      age = 2021 - minAge;
    }

    print('member paling tua = $age');
  }

  static Future<void> averageAge() async {
    print('mengambil semua data user . . . . . . . .');
    QuerySnapshot userSnapshot = await userCollection.get();

    var document = userSnapshot.docs;

    List<String> allUserData = [];


    for (var doc in document) {
      allUserData.add(doc['tanggal lahir']);
    }

    print('data index ke-1 = ' + allUserData[0]);

    List<int> allUserAgeData = [];

    print('converting data user . . . . . . ');
    for(var doc in allUserData) {
      var strToInt = int.parse(doc.split(' ')[2]);

      int userAge = 2021 - strToInt;

      allUserAgeData.add(userAge);
    }

    double averageAge = 0;

    int sumAllAge = allUserAgeData.sum;

    averageAge = sumAllAge / allUserAgeData.length;

    print('rata-rata umur member = $averageAge');
  }
}
