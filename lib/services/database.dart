import 'dart:developer';

import 'package:junaidtraders/models/salesman_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/customer_model.dart';
import '../models/item_model.dart';

class LocalDatabase {
  late Database db;
  Future<void> initDatabase() async {
    db = await databaseFactoryFfi.openDatabase('demo1.db',
        options: OpenDatabaseOptions(
            version: 2,
            onCreate: (a, b) async {
              await a.execute(
                  'CREATE TABLE Customer (id INTEGER PRIMARY KEY, code TEXT, name TEXT, phone TEXT, address TEXT, credit REAL)');
            }));
  }

  //  <---------------   Customers  ------------------->

  Future<void> createNewCustomer(Customer model) async {
    await db.insert('Customer', model.toJson());
  }

  Future<List<Customer>> readAllCustomerData() async {
    List<Customer> list = [];
    var result = await db.query(
      'Customer',
    );
    for (var e in result) {
      list.add(Customer.fromJson(e));
    }
    return list;
  }

  Future<Customer?> getCustomerById(int id) async {
    try {
      var result = await db.query('Customer', where: 'id = $id');
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
      var result = await db.query('Customer', where: 'code = $code');

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
      await db.update(
        'Customer',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating customer :   $e');
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      await db.delete('Customer', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Customer   $e');
    }
  }

  //  <---------------   SalesMan  ------------------->

  Future<void> createNewSalesman(SalesMan model) async {
    await db.insert('SalesMan', model.toJson());
  }

  Future<List<SalesMan>> readAllSalesmanData() async {
    List<SalesMan> list = [];
    var result = await db.query(
      'SalesMan',
    );
    for (var e in result) {
      list.add(SalesMan.fromJson(e));
    }
    return list;
  }

  Future<SalesMan?> getSalesManById(int id) async {
    try {
      var result = await db.query('SalesMan', where: 'id = $id');
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
      await db.update(
        'SalesMan',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating SalesMan :   $e');
    }
  }

  Future<void> deleteSalesMan(int id) async {
    try {
      await db.delete('SalesMan', where: 'id = $id');
    } catch (e) {
      log('Error while deleting SalesMan   $e');
    }
  }

  //  <---------------   Item  ------------------->

  Future<void> createNewItem(Item model) async {
    await db.insert('Item', model.toJson());
  }

  Future<List<Item>> readAllItemmanData() async {
    List<Item> list = [];
    var result = await db.query(
      'Item',
    );
    for (var e in result) {
      list.add(Item.fromJson(e));
    }
    return list;
  }

  Future<Item?> getItemById(int id) async {
    try {
      var result = await db.query('Item', where: 'id = $id');
      for (var e in result) {
        return Item.fromJson(e);
      }
    } catch (e) {
      log('Error while getting Item : $e');
    }
    return null;
  }

  Future<void> updateItemMan(Item model) async {
    try {
      await db.update(
        'Item',
        model.toJson(),
      );
    } catch (e) {
      log('Error while updating Item :   $e');
    }
  }

  Future<void> deleteItemMan(int id) async {
    try {
      await db.delete('Item', where: 'id = $id');
    } catch (e) {
      log('Error while deleting Item   $e');
    }
  }
}
