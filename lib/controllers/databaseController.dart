import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/services/database.dart';

class DBC {
  static final DBC instance = DBC._internal();
  late LocalDatabase _localDatabase;

  factory DBC() {
    return instance;
  }

  DBC._internal();

  Future<void> initDatabse(String database) async {
    _localDatabase = LocalDatabase();
    await _localDatabase.initDatabase(database);
  }

  Future<String?> getCustomerCodeByRoute(String route) async {
    return await _localDatabase.getAvailableCustomerCode(route);
  }

  Future<void> addCustomer(Customer model) async {
    await _localDatabase.createNewCustomer(model);
  }

  Future<List<Customer>> fetchAllCustomer() async {
    return await _localDatabase.readAllCustomerData();
  }
}
