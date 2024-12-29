import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  await DatabaseController.instance.initDatabse();
  DatabaseController.instance.getCustomerByCode();
}
