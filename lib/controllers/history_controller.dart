import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/models/history_model.dart';

class HistoryController extends GetxController {
  List<History> modelList = [];
  List<History> filteredList = [];

  @override
  void onInit() async {
    super.onInit();
    modelList = await DBC.instance.getByDateHistory(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0,
              0, 0)
          .microsecondsSinceEpoch,
    );
    filteredList = modelList.toList();
    update();
  }

  Future<void> filterByDate({required DateTime date, String? code}) async {
    filteredList = modelList.where((e) {
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
    if (code != null && code.isNotEmpty) {
      filteredList =
          filteredList.where((e) => e.customer!.code == code).toList();
    }
    update();
  }

  Future<void> filterByCustomerCode(String code) async {
    filteredList = modelList.where((e) => e.customer!.code == code).toList();
    update();
  }
}
