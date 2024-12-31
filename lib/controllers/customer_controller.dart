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
    // TODO: implement onClose
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
}
