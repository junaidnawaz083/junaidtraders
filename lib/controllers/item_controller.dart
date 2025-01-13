import 'package:get/get.dart';
import 'package:junaidtraders/models/item_model.dart';

import 'databaseController.dart';

class ItemController extends GetxController {
  List<Item> items = [];
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

  Future<void> fetchItemsData() async {
    isLoading = true;
    update();
    items = await DBC.instance.fetchItemData();
    isLoading = false;
    update();
  }

  Future<String> getItemCode() async {
    return await DBC.instance.getItemCode() ?? '';
  }

  Future<void> addItem({required Item model}) async {
    await DBC.instance.addItem(model);
    fetchItemsData();
  }

  Future<void> updateItem({required Item model}) async {
    await DBC.instance.updateItem(model);
    fetchItemsData();
  }

  Future<void> deleteItem(int id) async {
    bool res = await DBC.instance.deleteItem(id);
    if (res) {
      items.removeWhere((e) => e.id == id);
      update();
    }
  }
}
