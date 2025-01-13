import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/models/salesman_model.dart';

class Salescontroller extends GetxController {
  List<SalesMan> salesman = [];
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> fetchSalemanData() async {
    isLoading = true;
    update();
    salesman = await DBC.instance.getAllSalesman();
    isLoading = false;
    update();
  }

  Future<void> addSalesman({required SalesMan model}) async {
    await DBC.instance.addSalesman(model);
    fetchSalemanData();
  }

  Future<void> updatSales({required SalesMan model}) async {
    await DBC.instance.updateSalesman(model);
    fetchSalemanData();
  }

  Future<void> deleteSalesman(int id) async {
    bool res = await DBC.instance.deleteSalesman(id);
    if (res) {
      salesman.removeWhere((e) => e.id == id);
      update();
    }
  }
}
