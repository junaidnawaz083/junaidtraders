import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/models/history_model.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../controllers/history_controller.dart';
import '../../utils/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _con = Get.put(HistoryController());
  DateTime selectedDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  TextEditingController code = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      title: 'History',
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: getButton(
          onPress: () {
            Get.back();
          },
          text: '   Back    ',
        ),
      ),
      body: GetBuilder<HistoryController>(builder: (con) {
        return Container(
          //color: Colors.amber,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          width: context.width,
          height: context.height,
          child: Column(
            //  shrinkWrap: true,
            children: [
              Container(
                // color: primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getLable(text: 'Filter Data'),
                    Row(
                      children: [
                        getLable(text: 'Customer Code:   '),
                        getTextFormField(
                            controller: code,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (val) async {
                              if (val.isEmpty) {
                                return;
                              }
                              _con.filterByDate(
                                  date: selectedDateTime, code: null);
                            },
                            validator: (val) {
                              return null;
                            }),
                        SizedBox(
                          width: context.width * 0.05,
                        ),
                        getLable(text: 'Date:   '),
                        getButton(
                          onPress: () async {
                            DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 7)),
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
                              _con.filterByDate(
                                  date: selectedDateTime, code: null);
                            }
                          },
                          text: selectedDateTime.formatedDateTime(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: primary,
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.02, vertical: 5),
                child: Row(
                  children: [
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
                      width: context.width * 0.15,
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
                    SizedBox(
                      width: context.width * 0.1,
                      child: getLable(
                        text: 'Type',
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
                    getLable(
                      text: '',
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: con.filteredList.isEmpty
                    ? Center(
                        child: getLable(text: 'No Record found!'),
                      )
                    : Scrollbar(
                        controller: _controller,
                        child: ListView.builder(
                          controller: _controller,
                          shrinkWrap: true,
                          //primary: false,
                          itemCount: con.filteredList.length,
                          itemBuilder: (context, ind) {
                            return getListTile(con.filteredList[ind], ind);
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

  Widget getListTile(History model, index) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.02, vertical: 5),
      color: index % 2 == 0 ? Colors.black : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: model.customer!.code ?? '',
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.22,
            child: getLable(
              text: model.customer!.name ?? '',
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.15,
            child: getLable(
              text: model.salesMan!.name ?? '',
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
              text: (model.date as DateTime).formatedDateTime(),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: model.type ?? '',
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.1,
            child: getLable(
              text: model.amount!.toStringAsFixed(0),
              color: Colors.white,
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
