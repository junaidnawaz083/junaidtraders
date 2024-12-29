import 'package:junaidtraders/services/database.dart';

class DatabaseController {
  static final DatabaseController instance = DatabaseController._internal();
  late LocalDatabase _localDatabase;

  factory DatabaseController() {
    return instance;
  }

  DatabaseController._internal();

  Future<void> initDatabse() async {
    _localDatabase = LocalDatabase();
    await _localDatabase.initDatabase();
  }

  Future<void> getCustomerByCode() async {
    await _localDatabase.getCustomerByCode("1000");
  }
}
