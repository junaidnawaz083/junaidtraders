import 'package:intl/intl.dart';

extension FormatedDate on DateTime {
  String formatedDateTime() {
    return DateFormat('d MMMM yyy').format(this);
  }

  String formatedDateTime2() {
    return DateFormat('d-MMM-yyy').format(this);
  }
}
