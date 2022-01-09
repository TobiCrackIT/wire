import 'package:intl/intl.dart';

class Formatter{
  static toMoney(String value) {
    var mFmt = NumberFormat("#,##0.00", "en_US");
    mFmt.minimumFractionDigits = 0;
    mFmt.maximumFractionDigits = 2;
    return mFmt.format(double.parse(value));
  }
}