import 'package:intl/intl.dart';

class Utils {
  static String numberFormat(int number) {
    final numberFormatter = NumberFormat.simpleCurrency(locale: 'ko_KR', name: '', decimalDigits: 0);
    return numberFormatter.format(number);
  }
}