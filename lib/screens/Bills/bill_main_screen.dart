import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/screens/Bills/bill_history.dart';
import 'package:junaidtraders/screens/Bills/create_bill_screen.dart';
import 'package:junaidtraders/screens/Bills/stock_detail.dart';

import '../../utils/utils.dart';

class BillMainScreen extends StatefulWidget {
  const BillMainScreen({super.key});

  @override
  State<BillMainScreen> createState() => _BillMainScreenState();
}

class _BillMainScreenState extends State<BillMainScreen> {
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
              text: 'Bill Management',
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
                  onPress: () {
                    Get.to(() => const CreateBillScreen());
                  },
                  text: 'Create Bill',
                ),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () {
                    Get.to(() => const BillHistory());
                  },
                  text: 'Bill History',
                ),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () {
                    Get.to(() => const StockDetailScreen());
                  },
                  text: 'Stock Detail',
                )
              ],
            ),
          ],
        ));
  }
}
