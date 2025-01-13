import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/models/credit_model.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/history_model.dart';
import 'package:junaidtraders/models/item_model.dart';
import 'package:junaidtraders/models/recovery_model.dart';
import 'package:junaidtraders/models/salesman_model.dart';
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

//      ------------------->  Customer  <----------------------
  Future<String?> getCustomerCodeByRoute(String route) async {
    return await _localDatabase.getAvailableCustomerCode(route);
  }

  Future<Customer?> getCustomerByCode(String code) async {
    return await _localDatabase.getCustomerByCode(code);
  }

  Future<List<Customer>> getCustomerByRoute(String route) async {
    return await _localDatabase.readCustomerDataByRoute(route);
  }

  Future<void> addCustomer(Customer model) async {
    await _localDatabase.createNewCustomer(model);
  }

  Future<void> updateCustomer(Customer model) async {
    await _localDatabase.updateCustomer(model);
  }

  Future<List<Customer>> fetchAllCustomer() async {
    return await _localDatabase.readAllCustomerData();
  }

  Future<bool> deleteCustomer(int id) async {
    return await _localDatabase.deleteCustomer(id);
  }

  //      ------------------->  Items  <----------------------
  Future<String?> getItemCode() async {
    return await _localDatabase.getAvailableItemCode();
  }

  Future<Item?> getItembyCode(String code) async {
    return await _localDatabase.getItemByCode(code);
  }

  Future<void> addItem(Item model) async {
    await _localDatabase.createNewItem(model);
  }

  Future<void> updateItem(Item model) async {
    await _localDatabase.updateItem(model);
  }

  Future<List<Item>> fetchItemData() async {
    return await _localDatabase.readAllItemData();
  }

  Future<bool> deleteItem(int id) async {
    return await _localDatabase.deleteItem(id);
  }

  //      ------------------->  Salesman  <----------------------

  Future<List<SalesMan>> getAllSalesman() async {
    return _localDatabase.readAllSalesmanData();
  }

  Future<void> addSalesman(SalesMan model) async {
    await _localDatabase.createNewSalesman(model);
  }

  Future<void> updateSalesman(SalesMan model) async {
    await _localDatabase.updateSalesMan(model);
  }

  Future<bool> deleteSalesman(int id) async {
    return await _localDatabase.deleteSalesMan(id);
  }

  //      ------------------->  Cash Recovery  <----------------------

  Future<List<RecoveryModel>> getAllRecovery() async {
    return _localDatabase.readAllRecoveryData();
  }

  Future<int> addRecovery(RecoveryModel model) async {
    return await _localDatabase.createRecovery(model);
  }

  Future<void> updateRecovery(RecoveryModel model) async {
    await _localDatabase.updateRecovery(model);
  }

  Future<bool> deleteRecovery(int id) async {
    return await _localDatabase.deleteRecovery(id);
  }
  //      ------------------->  Cash Credit  <----------------------

  Future<List<CreditModel>> getAllCredit() async {
    return _localDatabase.readAllCreditData();
  }

  Future<int> addCredit(CreditModel model) async {
    return await _localDatabase.createCredit(model);
  }

  Future<void> updateCredit(CreditModel model) async {
    await _localDatabase.updateCredit(model);
  }

  Future<bool> deleteCredit(int id) async {
    return await _localDatabase.deleteCredit(id);
  }

  //      ------------------->  Histoy   <----------------------

  Future<List<History>> getAllHistory() async {
    return _localDatabase.readAllHistoryData();
  }

  Future<List<History>> getByDateHistory(int date) async {
    return _localDatabase.readByDateHistoryData(date);
  }

  Future<int> addCHistory(History model) async {
    return await _localDatabase.createHistory(model);
  }

  Future<void> updateHistory(History model) async {
    await _localDatabase.updateHistory(model);
  }

  Future<bool> deleteHistory(int id) async {
    return await _localDatabase.deleteHistory(id);
  }

  Future<bool> deleteHistoryByTypeID(int id) async {
    return await _localDatabase.deleteHistoryByTypeID(id);
  }
  //      ------------------->  Bills  <----------------------

  Future<List<Bill>> getBills(int date) async {
    return _localDatabase.readBillData(date);
  }

  Future<int> addBill(Bill model) async {
    return await _localDatabase.createBill(model);
  }

  Future<void> updateBill(Bill model) async {
    await _localDatabase.updateBill(model);
  }

  Future<bool> deleteBill(int id) async {
    return await _localDatabase.deleteBill(id);
  }
}
