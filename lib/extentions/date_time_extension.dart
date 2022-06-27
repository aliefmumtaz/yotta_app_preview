part of 'extentions.dart';

extension DateTimeExtenton on DateTime {
  String get dateTime => '${this.day} ${this.monthName} ${this.year}';

  String get monthName {
    switch (this.month) {
      case 01:
        return 'Januari';
      case 02:
        return 'Februari';
      case 03:
        return 'Maret';
      case 04:
        return 'April';
      case 05:
        return 'Mei';
      case 06:
        return 'Juni';
      case 07:
        return 'Juli';
      case 08:
        return 'Augustus';
      case 09:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      default:
        return 'Desember';
    }
  }
}
