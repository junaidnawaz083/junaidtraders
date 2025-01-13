import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/screens/Cash%20in_out/add_deposit.dart';
import 'package:junaidtraders/screens/Cash%20in_out/cashHistory.dart';
import 'package:junaidtraders/utils/utils.dart';

class CashInOutScreen extends StatefulWidget {
  const CashInOutScreen({
    required this.depositType,
    super.key,
  });
  final CashInOut depositType;

  @override
  State<CashInOutScreen> createState() => _CashInOutScreenState();
}

class _CashInOutScreenState extends State<CashInOutScreen> {
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
              text: widget.depositType == CashInOut.Recovery
                  ? 'Recovery Management'
                  : 'Loan Management',
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
                    Get.to(
                      () => AddDeposit(
                        depositType: widget.depositType,
                      ),
                    );
                  },
                  text:
                      'Add ${widget.depositType == CashInOut.Recovery ? 'Recovery' : 'Loan'}',
                ),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                getBigButton(
                  width: Get.width * 0.2,
                  onPress: () {
                    Get.to(CashInOutHistory(depositType: widget.depositType));
                  },
                  text:
                      '${widget.depositType == CashInOut.Recovery ? 'Recovery' : 'Loan'} History',
                )
              ],
            ),
          ],
        ));
  }
}

enum CashInOut { Recovery, Credit }
