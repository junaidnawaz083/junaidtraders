import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/depositController.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';
import 'cash_in_out_screen.dart';

class CashInOutHistory extends StatefulWidget {
  const CashInOutHistory({
    super.key,
    required this.depositType,
  });
  final CashInOut depositType;

  @override
  State<CashInOutHistory> createState() => _CashInOutHistoryState();
}

class _CashInOutHistoryState extends State<CashInOutHistory> {
  final _con = Get.put(Depositcontroller());
  final ScrollController _controller = ScrollController();

  DateTime? selectedDateTime;
  @override
  void initState() {
    super.initState();
    _con.getDepositData(widget.depositType);
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      title: '${widget.depositType.name} History',
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: getButton(
          onPress: () {
            Get.back();
          },
          text: '   Back    ',
        ),
      ),
      leadingWidgets: [
        getButton(
          onPress: () async {
            DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime.now().subtract(const Duration(days: 7)),
                lastDate: DateTime.now());
            if (date != null) {
              setState(() {
                selectedDateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  0,
                  0,
                  0,
                );
              });
              if (selectedDateTime != null) {
                _con.filterData(selectedDateTime!);
              }
            }
          },
          text: selectedDateTime != null
              ? selectedDateTime!.formatedDateTime()
              : 'Select Date',
        ),
        SizedBox(
          width: Get.width * 0.05,
        )
      ],
      body: GetBuilder<Depositcontroller>(builder: (con) {
        return Container(
          //color: Colors.amber,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          width: context.width,
          height: context.height,
          child: Column(
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
                      width: context.width * 0.22,
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
                        text: 'Amount',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    SizedBox(
                      width: context.width * 0.22,
                      child: getLable(
                        text: 'Salesman',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    SizedBox(
                      width: context.width * 0.1,
                      child: getLable(
                        text: 'Date',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    getLable(
                      text: '',
                      color: Colors.black,
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
                    itemCount: con.filterList.length,
                    itemBuilder: (context, ind) {
                      return getListTile(con.filterList[ind], ind);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget getListTile(model, index) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.02, vertical: 5),
      color: index % 2 == 0 ? Colors.black : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: context.width * 0.025,
            child: getLable(
              text: (index + 1).toString(),
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: model.customer.code,
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.22,
            child: getLable(
              text: model.customer.name,
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: widget.depositType == CashInOut.Recovery
                  ? model.recovery.toStringAsFixed(0)
                  : model.credit.toStringAsFixed(0),
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.22,
            child: getLable(
              text: model.salesMan.name,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: (model.date as DateTime).formatedDateTime(),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
