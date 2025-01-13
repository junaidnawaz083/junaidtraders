import 'dart:developer';

import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/models/credit_model.dart';
import 'package:junaidtraders/models/history_model.dart';
import 'package:junaidtraders/models/salesman_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/customer_model.dart';
import '../models/item_model.dart';
import '../models/recovery_model.dart';
import '../utils/constants.dart';

class LocalDatabase {
  Database? db;

  Future<void> closeDatabse() async {
    await db!.close();
  }

  Future<void> initDatabase(String database) async {
    if (db != null) {
      closeDatabse();
    }
    db = await databaseFactoryFfi.openDatabase(
      '$database.db!',
      options: OpenDatabaseOptions(
        version: 2,
        onCreate: (a, b) async {
          await a.execute(
            'CREATE TABLE Customer (id INTEGER PRIMARY KEY, code TEXT, name TEXT,route TEXT, phone TEXT, address TEXT, credit REAL)',
          );
          await a.execute(
            'CREATE TABLE SalesMan (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, address TEXT, cnic TEXT)',
          );
          await a.execute(
            'CREATE TABLE Item (id INTEGER PRIMARY KEY, code TEXT, name TEXT, company TEXT, cost REAL, sale REAL)',
          );
          await a.execute(
            'CREATE TABLE Credit (id INTEGER PRIMARY KEY, customer TEXT, salesman TEXT, credit REAL, netCredit REAL, date INTEGER)',
          );
          await a.execute(
            'CREATE TABLE Recovery (id INTEGER PRIMARY KEY, customer TEXT, salesman TEXT, recovery REAL, netCredit REAL, date INTEGER)',
          );
          await a.execute(
            'CREATE TABLE Bill (id INTEGER PRIMARY KEY, customer TEXT, salesman TEXT, type TEXT, totalAmount REAL, totalItems INTEGER, date INTEGER, billingItems TEXT)',
          );
          await a.execute(
            'CREATE TABLE History (id INTEGER PRIMARY KEY, customer TEXT, salesman TEXT, type TEXT, typeId INTEGER, amount REAL, date INTEGER)',
          );
        },
      ),
    );
  }

  //  <---------------   Recovery   ------------------->
  Future<int> createRecovery(RecoveryModel model) async {
    if (db == null) {
      return -1;
    }
    try {
      int id = await db!.insert('Recovery', model.toJson());
      return id;
    } catch (e) {
      log('Error while adding Recovery   $e');
    }
    return -1;
  }

  Future<List<RecoveryModel>> readAllRecoveryData() async {
    List<RecoveryModel> list = [];
    if (db == null) {
      return [];
    }
    var result = await db!.query(
      'Recovery',
    );
    for (var e in result) {
      list.add(RecoveryModel.fromJson(e));
    }
    return list;
  }

  Future<RecoveryModel?> getRecoveryById(int id) async {
    try {
      var result = await db!.query('Recovery', where: 'id = $id');
      for (var e in result) {
        return RecoveryModel.fromJson(e);
      }
    } catch (e) {
      log('Error while getting Recovery : $e');
    }
    return null;
  }

  Future<void> updateRecovery(RecoveryModel model) async {
    try {
      await db!.update(
        'Recovery',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating Recovery :   $e');
    }
  }

  Future<bool> deleteRecovery(int id) async {
    try {
      await db!.delete('Recovery', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting Recovery   $e');
    }
    return false;
  }

  //  <---------------   Credit     ------------------->

  Future<int> createCredit(CreditModel model) async {
    try {
      int id = await db!.insert('Credit', model.toJson());
      return id;
    } catch (e) {
      log('Error while adding Credit    $e');
    }
    return -1;
  }

  Future<List<CreditModel>> readAllCreditData() async {
    List<CreditModel> list = [];
    var result = await db!.query(
      'Credit',
    );
    for (var e in result) {
      list.add(CreditModel.fromJson(e));
    }
    return list;
  }

  Future<CreditModel?> getCreditById(int id) async {
    try {
      var result = await db!.query('Credit', where: 'id = $id');
      for (var e in result) {
        return CreditModel.fromJson(e);
      }
    } catch (e) {
      log('Error while getting Credit : $e');
    }
    return null;
  }

  Future<void> updateCredit(CreditModel model) async {
    try {
      await db!.update(
        'Credit',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating Credit :   $e');
    }
  }

  Future<bool> deleteCredit(int id) async {
    try {
      await db!.delete('Credit', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting Credit   $e');
    }
    return false;
  }

  //  <---------------   Customers  ------------------->

  Future<void> createNewCustomer(Customer model) async {
    await db!.insert('Customer', model.toJson());
  }

  Future<List<Customer>> readAllCustomerData() async {
    List<Customer> list = [];
    var result = await db!.query('Customer', orderBy: 'CAST(code AS INTEGER)');
    for (var e in result) {
      list.add(Customer.fromJson(e));
    }
    return list;
  }

  Future<List<Customer>> readCustomerDataByRoute(String route) async {
    List<Customer> list = [];
    var result = await db!.query('Customer',
        orderBy: 'CAST(code AS INTEGER)', where: 'route = \'$route\'');
    for (var e in result) {
      list.add(Customer.fromJson(e));
    }
    return list;
  }

  Future<Customer?> getCustomerById(int id) async {
    try {
      var result = await db!.query('Customer', where: 'id = $id');
      for (var e in result) {
        return Customer.fromJson(e);
      }
    } catch (e) {
      log('Error while getting customer : $e');
    }
    return null;
  }

  Future<Customer?> getCustomerByCode(String code) async {
    try {
      var result = await db!.query('Customer', where: 'code = \'$code\'');

      for (var e in result) {
        return Customer.fromJson(e);
      }
    } catch (e) {
      log('Error while getting customer : $e');
    }
    return null;
  }

  Future<void> updateCustomer(Customer model) async {
    try {
      var res = await db!
          .update('Customer', model.toJson(), where: 'id = ${model.id}');
      log(res.toString());
    } catch (e) {
      log('Error while updating customer :   $e');
    }
  }

  Future<bool> deleteCustomer(int id) async {
    try {
      await db!.delete('Customer', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting Customer   $e');
    }
    return false;
  }

  Future<String?> getAvailableCustomerCode(String route) async {
    try {
      var result = await db!.query('Customer', where: 'route = \'$route\'');
      int code = await getCustomerCodeByRoute(route);
      Customer model;
      if (result.isEmpty) {
        log('customers are empty');
        return code.toString();
      } else {
        for (var e in result) {
          model = Customer.fromJson(e);
          if (model.code != '$code') {
            return code.toString();
          } else {
            code++;
          }
        }
        return code.toString();
      }
    } catch (e) {
      log('Error while fetching availble customer code   $e');
      return null;
    }
  }

  //  <---------------   SalesMan  ------------------->

  Future<void> createNewSalesman(SalesMan model) async {
    await db!.insert('SalesMan', model.toJson());
  }

  Future<List<SalesMan>> readAllSalesmanData() async {
    List<SalesMan> list = [];
    var result = await db!.query(
      'SalesMan',
    );
    for (var e in result) {
      list.add(SalesMan.fromJson(e));
    }
    return list;
  }

  Future<SalesMan?> getSalesManById(int id) async {
    try {
      var result = await db!.query('SalesMan', where: 'id = $id');
      for (var e in result) {
        return SalesMan.fromJson(e);
      }
    } catch (e) {
      log('Error while getting SalesMan : $e');
    }
    return null;
  }

  Future<void> updateSalesMan(SalesMan model) async {
    try {
      await db!.update(
        'SalesMan',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating SalesMan :   $e');
    }
  }

  Future<bool> deleteSalesMan(int id) async {
    try {
      await db!.delete('SalesMan', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting SalesMan   $e');
    }
    return false;
  }

  //  <---------------   Item  ------------------->

  Future<void> createNewItem(Item model) async {
    await db!.insert('Item', model.toJson());
  }

  Future<List<Item>> readAllItemData() async {
    List<Item> list = [];
    var result = await db!.query(
      'Item',
    );
    for (var e in result) {
      list.add(Item.fromJson(e));
    }
    return list;
  }

  Future<Item?> getItemById(int id) async {
    try {
      var result = await db!.query('Item', where: 'id = $id');
      for (var e in result) {
        return Item.fromJson(e);
      }
    } catch (e) {
      log('Error while getting Item : $e');
    }
    return null;
  }

  Future<String?> getAvailableItemCode() async {
    try {
      var result = await db!.query('Item');
      int code = 1;
      Item model;
      if (result.isEmpty) {
        return code.toString();
      } else {
        for (var e in result) {
          model = Item.fromJson(e);
          if (model.code != '$code') {
            return code.toString();
          } else {
            code++;
          }
        }
        return code.toString();
      }
    } catch (e) {
      log('Error while fetching availble Item code   $e');
      return null;
    }
  }

  Future<Item?> getItemByCode(String code) async {
    try {
      var result = await db!.query('Item', where: 'code = \'$code\'');

      for (var e in result) {
        return Item.fromJson(e);
      }
    } catch (e) {
      log('Error while fetching  Item by Code   $e');
      // return null;
    }
    return null;
  }

  Future<void> updateItem(Item model) async {
    try {
      await db!.update('Item', model.toJson(), where: 'id = ${model.id}');
    } catch (e) {
      log('Error while updating Item :   $e');
    }
  }

  Future<bool> deleteItem(int id) async {
    try {
      await db!.delete('Item', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting Item   $e');
    }
    return false;
  }

  //  <---------------   Recovery   ------------------->
  Future<int> createHistory(History model) async {
    if (db == null) {
      return -1;
    }
    try {
      int id = await db!.insert('History', model.toJson());
      return id;
    } catch (e) {
      log('Error while adding History   $e');
    }
    return -1;
  }

  Future<List<History>> readAllHistoryData() async {
    List<History> list = [];
    if (db == null) {
      return [];
    }
    var result = await db!.query(
      'History',
    );
    for (var e in result) {
      list.add(History.fromJson(e));
    }
    return list;
  }

  Future<List<History>> readByDateHistoryData(int time) async {
    List<History> list = [];
    if (db == null) {
      return [];
    }
    var result = await db!.query('History', where: 'date = $time');
    for (var e in result) {
      list.add(History.fromJson(e));
    }
    return list;
  }

  Future<History?> getHistoryById(int id) async {
    try {
      var result = await db!.query('History', where: 'id = $id');
      for (var e in result) {
        return History.fromJson(e);
      }
    } catch (e) {
      log('Error while getting History : $e');
    }
    return null;
  }

  Future<void> updateHistory(History model) async {
    try {
      await db!.update(
        'History',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating History :   $e');
    }
  }

  Future<bool> deleteHistory(int id) async {
    try {
      await db!.delete('History', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting History   $e');
    }
    return false;
  }

  Future<bool> deleteHistoryByTypeID(int id) async {
    try {
      await db!.delete('History', where: 'typeId = $id');
      return true;
    } catch (e) {
      log('Error while deleting History   $e');
    }
    return false;
  }

  //  <---------------   Bills   ------------------->
  Future<int> createBill(Bill model) async {
    if (db == null) {
      return -1;
    }
    try {
      int id = await db!.insert('Bill', model.toJson());
      return id;
    } catch (e) {
      log('Error while adding Bill   $e');
    }
    return -1;
  }

  Future<List<Bill>> readBillData(int date) async {
    List<Bill> list = [];
    if (db == null) {
      return [];
    }
    var result = await db!.query('Bill', where: 'date = $date');
    for (var e in result) {
      list.add(Bill.fromJson(e));
    }
    return list;
  }

  Future<Bill?> getBillById(int id) async {
    try {
      var result = await db!.query('Bill', where: 'id = $id');
      for (var e in result) {
        return Bill.fromJson(e);
      }
    } catch (e) {
      log('Error while getting Bill : $e');
    }
    return null;
  }

  Future<void> updateBill(Bill model) async {
    try {
      await db!.update('Bill', model.toJson(), where: 'typeId = ${model.id}');
    } catch (e) {
      log('Error while updating Bill :   $e');
    }
  }

  Future<bool> deleteBill(int id) async {
    try {
      await db!.delete('Bill', where: 'id = $id');
      return true;
    } catch (e) {
      log('Error while deleting Bill   $e');
    }
    return false;
  }

  //    ---------------------   Extraaas ---------------------------------

  Future<int> getCustomerCodeByRoute(String r) async {
    return (routes.indexOf(r) + 1) * 1000;
  }
}
