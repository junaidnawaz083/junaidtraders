import 'dart:developer';

import 'package:junaidtraders/models/credit_model.dart';
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
            'CREATE TABLE Credit (id INTEGER PRIMARY KEY, customr TEXT, salesman TEXT, credit REAL, netCredit REAL, date INTEGER)',
          );
          await a.execute(
            'CREATE TABLE Recovery (id INTEGER PRIMARY KEY, customr TEXT, salesman TEXT, recovery REAL, netCredit REAL, date INTEGER)',
          );
          await a.execute(
            'CREATE TABLE Bill (id INTEGER PRIMARY KEY, customr TEXT, salesman TEXT, type TEXT, totalAmount REAL, totalItems INTEGER, date INTEGER, billingItems TEXT)',
          );
          await a.execute(
            'CREATE TABLE History (id INTEGER PRIMARY KEY, customr TEXT, salesman TEXT, type TEXT, typeId INTEGER, amount REAL, date INTEGER)',
          );
        },
      ),
    );
  }

  //  <---------------   Recovery   ------------------->
  Future<void> createRecovery(SalesMan model) async {
    if (db == null) {
      return;
    }
    await db!.insert('Recovery', model.toJson());
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

  Future<void> deleteRecovery(int id) async {
    try {
      await db!.delete('Recovery', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Recovery   $e');
    }
  }

  //  <---------------   Credit     ------------------->

  Future<void> createCredit(SalesMan model) async {
    await db!.insert('Credit', model.toJson());
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

  Future<void> deleteCredit(int id) async {
    try {
      await db!.delete('Credit', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Credit   $e');
    }
  }

  //  <---------------   Customers  ------------------->

  Future<void> createNewCustomer(Customer model) async {
    await db!.insert('Customer', model.toJson());
  }

  Future<List<Customer>> readAllCustomerData() async {
    List<Customer> list = [];
    var result = await db!.query(
      'Customer',
    );
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
      var result = await db!.query('Customer', where: 'code = $code');

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
      await db!.update(
        'Customer',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating customer :   $e');
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      await db!.delete('Customer', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Customer   $e');
    }
  }

  Future<String?> getAvailableCustomerCode(String route) async {
    try {
      var result = await db!.query('Customer', where: 'route == "$route"');
      int code = await getCustomerCodeByRoute(route);
      Customer model;
      if (result.isEmpty) {
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

  Future<void> deleteSalesMan(int id) async {
    try {
      await db!.delete('SalesMan', where: 'id = $id');
    } catch (e) {
      log('Error while deleting SalesMan   $e');
    }
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

  Future<String?> getAvailableItemCode(String route) async {
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

  Future<void> updateItem(Item model) async {
    try {
      await db!.update(
        'Item',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating Item :   $e');
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await db!.delete('Item', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Item   $e');
    }
  }

  //    ---------------------   Extraaas ---------------------------------

  Future<int> getCustomerCodeByRoute(String r) async {
    return (routes.indexOf(r) + 1) * 1000;
  }
}
