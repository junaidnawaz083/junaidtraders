import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/models/history_model.dart';
import 'package:junaidtraders/models/item_model.dart';
import 'package:junaidtraders/services/printing.dart';

import '../models/customer_model.dart';
import '../models/salesman_model.dart';

class BillController extends GetxController {
  Bill? billModel;
  List<SalesMan> salesmanList = [];
  Item? currentItem;
  bool loading = true;
  void init() async {
    await getSalesManList();
    loading = false;
    update();
  }

  Future<void> getSalesManList() async {
    salesmanList = await DBC.instance.getAllSalesman();
  }

  Future<Customer?> getCustomerByCode(String code) async {
    return await DBC.instance.getCustomerByCode(code);
  }

  Future<void> findItemByCode(String code) async {
    currentItem = await DBC.instance.getItembyCode(code);
    update();
  }

  Future<List<Bill>> getBills(int date) async {
    return await DBC.instance.getBills(date);
  }

  Future<void> addItemToBill(Item item, int qty, double price) async {
    billModel!.billingItems!.add(
      BillingItems(
        item: item,
        quantity: qty,
        price: price,
        totalPrice: qty * price,
        discount: item.sale! - price,
      ),
    );
    billModel!.totalItems = billModel!.totalItems! + qty;
    billModel!.totalAmount = billModel!.totalAmount! + (qty * price);

    currentItem = null;
    update();
  }

  Future<bool> addBill(Customer cutomerModel) async {
    // return false;

    if (billModel == null) {
      return false;
    }
    billModel!.customer = cutomerModel;
    int res = await DBC.instance.addBill(billModel!);
    if (res != -1) {
      cutomerModel.credit = cutomerModel.credit! + billModel!.totalAmount!;
      await DBC.instance.updateCustomer(cutomerModel);
      await DBC.instance.addCHistory(
        History(
          amount: billModel!.totalAmount,
          customer: cutomerModel,
          salesMan: billModel!.salesMan,
          date: billModel!.date,
          type: billModel!.type,
          typeId: res,
        ),
      );

      await PrintingService.instance.printBill(billModel!);

      billModel = null;
      currentItem = null;
    }
    return res != -1;
  }
}
