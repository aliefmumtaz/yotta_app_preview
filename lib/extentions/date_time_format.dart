part of 'extentions.dart';

extension DateTimeApiFormatConverter on String {
  String get dateTimeFormat {
    String year = this.split('-')[0];
    String month = this.split('-')[1];
    String date = this.split('-')[2];

    return '${date.substring(0, 2)}-$month-$year';
  }

  String get userPointValidUntil {
    String dateFormat = this.split(' ')[0];

    String year = dateFormat.split('-')[0];
    String currentMonth = dateFormat.split('-')[1];
    String date = dateFormat.split('-')[2];
    String month = '';

    if (currentMonth == '01') 
      month = 'Jan';
    else if (currentMonth == '02') 
      month = 'Feb';
    else if (currentMonth == '03') 
      month = 'Mar';
    else if (currentMonth == '04')
      month = 'Apr';
    else if (currentMonth == '05')
      month = 'Mei';
    else if (currentMonth == '06')
      month = 'Jun';
    else if (currentMonth == '07')
      month = 'Jul';
    else if (currentMonth == '08')
      month = 'Aug';
    else if (currentMonth == '09')
      month = 'Sep';
    else if (currentMonth == '10')
      month = 'Okt';
    else if (currentMonth == '11')
      month = 'Nov';
    else 
      month = 'Des';

    int yearAfter = int.parse(year) + 1;

    return '$date $month $yearAfter';
  }
}
