import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/models/item_model.dart';
import 'package:junaidtraders/screens/Bills/bill_main_screen.dart';
import 'package:junaidtraders/screens/Cash%20in_out/cash_in_out_screen.dart';
import 'package:junaidtraders/screens/Customer/customers.dart';
import 'package:junaidtraders/screens/History/history.dart';
import 'package:junaidtraders/screens/Report/resport_screen.dart';
import 'package:junaidtraders/screens/Salesman/salesman.dart';
import 'package:junaidtraders/services/printing.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../Item/items.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getLable(
          text: 'Welcome!',
          fontSize: 40,
        ),
        SizedBox(
          height: context.height * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getBigButton(
              icon: Image.asset(
                'assets/icons/bill.png',
                height: context.height * 0.2,
                fit: BoxFit.fitHeight,
              ),
              width: context.width * 0.18,
              height: context.height * 0.4 + 10,
              borderRadius: 5,
              borderColor: Colors.white,
              onPress: () async {
                //await PrintingService.instance.printBill();
                Get.to(() => BillMainScreen());
              },
              text: 'Billing Management',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/history.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(() => const HistoryScreen());
                      },
                      text: 'History',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/profit-report.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(() => RepostScreen());
                      },
                      text: 'Report',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/financial-contribution.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(
                          () => CashInOutScreen(
                            depositType: CashInOut.Recovery,
                          ),
                        );
                      },
                      text: 'Recovey Management',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/loan.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(
                          () => CashInOutScreen(
                            depositType: CashInOut.Credit,
                          ),
                        );
                      },
                      text: 'Loan Management',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/customer.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(() => CustomerSreen());
                      },
                      text: 'Customer Management',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/wine.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(() => ItemsScreen());
                      },
                      text: 'Item Management',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/salesman.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {
                        Get.to(() => SalesmanScreen());
                      },
                      text: 'Salesman',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    getBigButton(
                      icon: Image.asset(
                        'assets/icons/analytics.png',
                        height: context.height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),
                      width: context.width * 0.18,
                      height: context.height * 0.2,
                      borderRadius: 5,
                      borderColor: Colors.white,
                      onPress: () {},
                      text: 'Income Management',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(
            //   width: 10,
            // ),
            // getBigButton(
            //   icon: Image.asset(
            //     'assets/icons/history.png',
            //     height: context.height * 0.2,
            //     fit: BoxFit.fitHeight,
            //   ),
            //   width: context.width * 0.18,
            //   height: context.height * 0.4 + 10,
            //   borderRadius: 5,
            //   borderColor: Colors.white,
            //   onPress: () {
            //     Get.to(() => const HistoryScreen());
            //   },
            //   text: 'History ',
            //   fontWeight: FontWeight.bold,
            // ),
          ],
        )
      ],
    ));
  }
}
