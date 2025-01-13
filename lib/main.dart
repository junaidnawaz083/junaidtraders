import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:junaidtraders/screens/login_screen/login.dart';
import 'package:junaidtraders/services/printing.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  await PrintingService.instance.init();
  // await DatabaseController.instance.initDatabse();
  // DatabaseController.instance.getCustomerByCode();
  runApp(GetMaterialApp(
    theme: ThemeData.dark()
        .copyWith(primaryColor: Color.fromARGB(255, 175, 142, 129)),
    home: LoginScreen(),
  ));
}
