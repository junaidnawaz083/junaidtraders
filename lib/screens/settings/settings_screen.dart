import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/services/backup_restore.dart';
import 'package:junaidtraders/utils/utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late BackupRestore _backupRestore;
  @override
  void initState() {
    super.initState();
    _backupRestore = BackupRestore();
    _backupRestore.init();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20),
          child: getButton(
            onPress: () {
              Get.back();
            },
            text: '   Back    ',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getLable(
              text: 'Settings',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: context.height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () async {
                    _backupRestore.createBackUp();
                  },
                  text: 'Backup Data',
                ),
                SizedBox(
                  width: Get.width * 0.025,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () async {
                    await _backupRestore.restoreCustomerData();
                  },
                  text: 'Restore Customers',
                ),
                SizedBox(
                  width: Get.width * 0.025,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () async {
                    //     await _backupRestore.restoreHistoryData();
                  },
                  text: 'Restore History',
                ),
                SizedBox(
                  width: Get.width * 0.025,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () async {
                    await _backupRestore.restoreItemsData();
                  },
                  text: 'Restore Items',
                ),
              ],
            ),
          ],
        ));
  }
}
