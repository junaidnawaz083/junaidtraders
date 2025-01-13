import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/models/customer_model.dart';

class CustomerController extends GetxController {
  List<Customer> customers = [];
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchCustomersData() async {
    isLoading = true;
    update();
    customers = await DBC.instance.fetchAllCustomer();
    isLoading = false;
    update();
  }

  Future<String> getCustomerCodeByRoute(String route) async {
    return await DBC.instance.getCustomerCodeByRoute(route) ?? '';
  }

  Future<void> addCustomer({required Customer model}) async {
    await DBC.instance.addCustomer(model);
    fetchCustomersData();
  }

  Future<void> updateCustomer({required Customer model}) async {
    await DBC.instance.updateCustomer(model);
    fetchCustomersData();
  }

  Future<void> deleteCustomer(int id) async {
    bool res = await DBC.instance.deleteCustomer(id);
    if (res) {
      customers.removeWhere((e) => e.id == id);
      update();
    }
  }

  Future<void> getCustomerByRoute(String route) async {
    isLoading = true;
    update();
    customers = await DBC.instance.getCustomerByRoute(route);
    isLoading = false;
    update();
  }
}
