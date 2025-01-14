import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/bill_controller.dart';
import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/services/printing.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  List<Bill> billList = [];
  bool loading = true;
  int? selctedIndex;
  final _con = Get.put(BillController());
  final ScrollController _controller = ScrollController();
  late DateTime selectedDateTime;
  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    getData();
  }

  void getData() async {
    loading = true;
    setState(() {});
    billList = await _con.getBills(selectedDateTime.microsecondsSinceEpoch);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      title: 'Bill History',
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Row(
          children: [
            SizedBox(
              width: context.width * 0.025,
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: context.width * 0.1,
                        child: getLable(text: 'Date:', fontSize: 20),
                      ),
                      getButton(
                        width: context.width * 0.2,
                        onPress: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 7)),
                              lastDate: DateTime.now());
                          if (date != null) {
                            setState(() {
                              selectedDateTime = date;
                            });
                            getData();
                          }
                        },
                        text: selectedDateTime.formatedDateTime(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  getButton(
                    disabled: selctedIndex == null,
                    width: context.width * 0.3,
                    onPress: () async {
                      await PrintingService.instance
                          .printBill(billList[selctedIndex!]);
                    },
                    text: 'Print Selected Bill',
                  ),
                  SizedBox(
                    height: context.height * 0.05,
                  ),
                  getButton(
                    width: context.width * 0.3,
                    onPress: () async {
                      for (var e in billList) {
                        await PrintingService.instance.printBill(e);
                      }
                    },
                    text: 'Print All Bill',
                  ),
                  SizedBox(
                    height: context.height * 0.05,
                  ),
                  getButton(
                    width: context.width * 0.3,
                    onPress: () async {
                      await PrintingService.instance.printBillSheet(billList);
                    },
                    text: 'Print Bill Sheet',
                  ),
                ],
              ),
            )),
            SizedBox(
              width: context.width * 0.025,
            ),
            Container(
              //color: Colors.amber,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              width: context.width * 0.56,
              height: context.height,
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          color: primary,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.02, vertical: 5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: context.width * 0.025,
                                child: getLable(
                                  text: 'No',
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.02,
                              ),
                              SizedBox(
                                width: context.width * 0.1,
                                child: getLable(
                                  text: 'Code',
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.25,
                                child: getLable(
                                  text: 'Name',
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.02,
                              ),
                              SizedBox(
                                width: context.width * 0.1,
                                child: getLable(
                                  text: 'Total Price',
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            controller: _controller,
                            child: ListView.builder(
                              controller: _controller,
                              shrinkWrap: true,
                              itemCount: billList.length,
                              itemBuilder: (context, ind) {
                                return getListTile(billList[ind], ind);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              width: context.width * 0.025,
            ),
          ],
        ),
      ),
    );
  }

  Widget getListTile(Bill model, index) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          selctedIndex = index;
        });
      },
      onDoubleTap: () {
        log('double tap called');
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: context.width * 0.02, vertical: 5),
        color: selctedIndex == index
            ? Colors.white
            : index % 2 == 0
                ? Colors.black
                : Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: context.width * 0.025,
              child: getLable(
                text: (index + 1).toString(),
                fontSize: 18,
                color: selctedIndex == index
                    ? Colors.black
                    : index % 2 != 0
                        ? Colors.white
                        : Colors.white70,
              ),
            ),
            SizedBox(
              width: context.width * 0.02,
            ),
            SizedBox(
              width: context.width * 0.1,
              child: getLable(
                text: model.customer!.code ?? '',
                fontSize: 18,
                color: selctedIndex == index
                    ? Colors.black
                    : index % 2 != 0
                        ? Colors.white
                        : Colors.white70,
              ),
            ),
            SizedBox(
              width: context.width * 0.25,
              child: getLable(
                text: model.customer!.name ?? '',
                fontSize: 18,
                color: selctedIndex == index
                    ? Colors.black
                    : index % 2 != 0
                        ? Colors.white
                        : Colors.white70,
              ),
            ),
            SizedBox(
              width: context.width * 0.02,
            ),
            SizedBox(
              width: context.width * 0.05,
              child: getLable(
                text: model.totalAmount!.toStringAsFixed(0),
                fontSize: 18,
                color: selctedIndex == index
                    ? Colors.black
                    : index % 2 != 0
                        ? Colors.white
                        : Colors.white70,
              ),
            ),
            SizedBox(
              width: context.width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
