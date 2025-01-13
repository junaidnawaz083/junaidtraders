import 'dart:developer';

import 'package:get/get.dart';
import 'package:junaidtraders/models/credit_model.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/history_model.dart';
import 'package:junaidtraders/models/recovery_model.dart';
import 'package:junaidtraders/models/salesman_model.dart';
import 'package:junaidtraders/screens/Cash%20in_out/cash_in_out_screen.dart';

import 'databaseController.dart';

class Depositcontroller extends GetxController {
  late List modelList;
  List filterList = [];

  double totalAmount = 0;
  List<SalesMan> salesmanList = [];

  void init(CashInOut type) async {
    if (type == CashInOut.Recovery) {
      modelList = <RecoveryModel>[];
    } else {
      modelList = <CreditModel>[];
    }
    await getSalesManList();
    update();
  }

  void getDepositData(CashInOut type) async {
    if (type == CashInOut.Recovery) {
      modelList = <RecoveryModel>[];
      modelList = await DBC.instance.getAllRecovery();
    } else {
      modelList = <CreditModel>[];
      modelList = await DBC.instance.getAllCredit();
    }

    filterList = modelList;
    update();
  }

  void filterData(DateTime date) async {
    filterList = modelList.where((e) {
      log(date.toString());
      log(e.date.toString());
      log(date
          .add(
            const Duration(
              days: 1,
            ),
          )
          .toString());
      return ((e.date as DateTime).isAfter(date) ||
              (e.date as DateTime).isAtSameMomentAs(date)) &&
          (e.date as DateTime).isBefore(
            date.add(
              const Duration(
                days: 1,
              ),
            ),
          );
    }).toList();
    update();
  }

  Future<void> getSalesManList() async {
    salesmanList = await DBC.instance.getAllSalesman();
  }

  Future<Customer?> getCustomerByCode(String code) async {
    return await DBC.instance.getCustomerByCode(code);
  }

  Future<bool> addDeposit(model, CashInOut type) async {
    int res = 0;
    if (type == CashInOut.Recovery) {
      res = await DBC.instance.addRecovery(model as RecoveryModel);
    } else {
      res = await DBC.instance.addCredit(model as CreditModel);
    }
    if (res == -1) return false;
    Customer customerModel = model.customer!;
    if (type == CashInOut.Recovery) {
      customerModel.credit = customerModel.credit! - model.recovery!;
    } else {
      customerModel.credit = customerModel.credit! + model.credit!;
    }
    await DBC.instance.updateCustomer(customerModel);
    await addHistory(
      History(
        amount: type == CashInOut.Recovery ? model.recovery : model.credit,
        customer: model.customer,
        date: model.date!,
        salesMan: model.salesMan,
        type: type.name,
        typeId: res,
      ),
    );
    model.id = res;
    model.customer = customerModel;
    modelList.add(model);
    update();
    return true;
  }

  Future<void> addHistory(History model) async {
    totalAmount += model.amount ?? 0;
    update();
    await DBC.instance.addCHistory(model);
  }

  Future<void> deleteDeposit(model, CashInOut type) async {
    if (type == CashInOut.Recovery) {
      var m = model as RecoveryModel;
      int id = m.id!;
      double amount = m.recovery!;
      Customer? cutomerModel = await getCustomerByCode(m.customer!.code!);
      bool res = await DBC.instance.deleteRecovery(id);
      if (res) {
        await DBC.instance.deleteHistoryByTypeID(id);
        cutomerModel!.credit = cutomerModel.credit! + amount;
        totalAmount = totalAmount - amount;
        await DBC.instance.updateCustomer(cutomerModel);
        update();
      }
    } else {
      var m = model as CreditModel;
      int id = m.id!;
      double amount = m.credit!;
      Customer? cutomerModel = await getCustomerByCode(m.customer!.code!);

      bool res = await DBC.instance.deleteCredit(id);
      if (res) {
        await DBC.instance.deleteHistoryByTypeID(id);
        cutomerModel!.credit = cutomerModel.credit! - amount;
        totalAmount = totalAmount - amount;
        await DBC.instance.updateCustomer(cutomerModel);
        update();
      }
    }
  }
}
