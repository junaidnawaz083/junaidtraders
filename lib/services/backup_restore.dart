import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/item_model.dart';
import 'package:junaidtraders/screens/city_sole/selection_screeen.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/databaseController.dart';

class BackupRestore {
  Directory? appDocumentsDir;
  init() async {
    appDocumentsDir = await getApplicationDocumentsDirectory();
  }

  Future<void> restoreCustomerData() async {
    try {
      log('Restore clicked');
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      log('file  picked');
      List<Customer> cusList = [];
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        for (var file in files) {
          var bytes = file.readAsBytesSync();
          var excel = Excel.decodeBytes(bytes);
          for (var table in excel.tables.keys) {
            for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
              List<Data?> row = excel.tables[table]!.rows[i];
              if (row.length == 7) {
                int code = int.tryParse(
                        row[1] == null ? '0' : row[1]!.value.toString()) ??
                    0;
                if (code < 7000) {
                  cusList.add(
                    Customer(
                      name: row[2]!.value.toString(),
                      code: row[1]?.value.toString(),
                      phone: row[3]?.value.toString(),
                      address: row[4]?.value.toString(),
                      route: row[5]?.value.toString(),
                      credit: double.tryParse(row[6] == null
                              ? '0'
                              : row[6]!.value.toString()) ??
                          0,
                    ),
                  );
                }
              }
            }
            break;
          }
        }
      }
      if (cusList.isNotEmpty) {
        await DBC.instance.reCreateCustomer();
        for (var cus in cusList) {
          await DBC.instance.addCustomer(cus);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> restoreHistoryData() async {
    try {
      log('Restore clicked');
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      log('file  picked');

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        for (var file in files) {
          var bytes = file.readAsBytesSync();
          var excel = Excel.decodeBytes(bytes);
          for (var table in excel.tables.keys) {
            for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
              List<Data?> row = excel.tables[table]!.rows[i];
              String text = '';
              for (int j = 1; j < row.length; j++) {
                text = '$text${row[j]?.value} - ';
              }
              print(text);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> restoreItemsData() async {
    try {
      log('Restore clicked');
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      log('file  picked');
      List<Item> iList = [];
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        for (var file in files) {
          var bytes = file.readAsBytesSync();
          var excel = Excel.decodeBytes(bytes);
          for (var table in excel.tables.keys) {
            for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
              List<Data?> row = excel.tables[table]!.rows[i];
              if (row.length == 11) {
                iList.add(
                  Item(
                    name: row[2]!.value.toString(),
                    code: row[1]?.value.toString(),
                    company: row[4]?.value.toString(),
                    cost: double.tryParse(
                            row[6] == null ? '0' : row[6]!.value.toString()) ??
                        0,
                    sale: double.tryParse(
                            row[7] == null ? '0' : row[7]!.value.toString()) ??
                        0,
                  ),
                );
              }
            }
            break;
          }
        }
      }
      if (iList.isNotEmpty) {
        await DBC.instance.reCreateItem();
        for (var i in iList) {
          await DBC.instance.addItem(i);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createBackUp() async {
    String path = '${appDocumentsDir?.path}';
    var directory =
        await Directory('$path/${DateTime.now().formatedDateTime()}')
            .create(recursive: true);
    path = directory.path;

    if (selectedArea == CitySole.city) {
      directory = await Directory('$path/City').create(recursive: true);
    } else {
      directory = await Directory('$path/Sole').create(recursive: true);
    }
    path = directory.path;
    await createCustomerFile(path: path);
  }

  Future<void> readExcelFiles() async {}

  Future<void> createExcelFile(
      {required String filename, required String path}) async {}
  Future<void> createCustomerFile({required String path}) async {
    Excel excel = Excel.createExcel();
    Sheet customerSheet = excel['Sheet1'];
    List<String> headers = [
      'Date',
      'Shop Name',
      'Tailor Name',
      'Size',
      'H',
      'Other',
      'Pcs',
      'Rate',
      'Total'
    ];
    for (int i = 0; i < headers.length; i++) {
      customerSheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(headers[i]);
    }
    var excelData = excel.save();
    File customerFile = File('$path/Customers.xlsx');
    if (await customerFile.exists()) {
      await customerFile.delete();
    }
    customerFile.create(recursive: true);

    await customerFile.writeAsBytes(excelData ?? []);
  }
}
