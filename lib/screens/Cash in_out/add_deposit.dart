import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/depositController.dart';
import 'package:junaidtraders/models/credit_model.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/recovery_model.dart';
import 'package:junaidtraders/models/salesman_model.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';
import 'cash_in_out_screen.dart';

class AddDeposit extends StatefulWidget {
  const AddDeposit({
    super.key,
    required this.depositType,
  });
  final CashInOut depositType;

  @override
  State<AddDeposit> createState() => _AddDepositState();
}

class _AddDepositState extends State<AddDeposit> {
  final _con = Get.put(Depositcontroller());
  FocusNode c = FocusNode();
  FocusNode a = FocusNode();
  FocusNode d = FocusNode();

  DateTime? selectedDateTime;
  SalesMan? selectedSalesman;
  String name = '';
  TextEditingController txt_amount = TextEditingController();
  TextEditingController txt_customer = TextEditingController();
  final ScrollController _controller = ScrollController();

  Customer? customerModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _con.init(widget.depositType);
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
      title:
          'Add ${widget.depositType == CashInOut.Recovery ? 'Recovery' : 'Loan'}',
      body: GetBuilder<Depositcontroller>(builder: (con) {
        return Form(
          key: _formKey,
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: Row(
              children: [
                SizedBox(
                  width: context.width * 0.025,
                ),
                Container(
                  //color: Colors.amber,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  width: context.width * 0.6,
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
                            itemCount: con.modelList.length,
                            itemBuilder: (context, ind) {
                              return getListTile(con.modelList[ind], ind);
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
                Expanded(
                  child: Container(
                    //color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.1,
                              child: getLable(text: 'Date:', fontSize: 20),
                            ),
                            getButton(
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
                                }
                              },
                              text: selectedDateTime != null
                                  ? selectedDateTime!.formatedDateTime()
                                  : 'Select Date',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        if (selectedDateTime != null)
                          Row(
                            children: [
                              SizedBox(
                                width: context.width * 0.1,
                                child:
                                    getLable(text: 'Salesman:', fontSize: 20),
                              ),
                              dropDownField(
                                focus: d,
                                width: context.width * 0.2,
                                value: selectedSalesman?.name,
                                data: con.salesmanList
                                    .map((e) => e.name ?? '')
                                    .toList(),
                                onChange: (val) async {
                                  if (val == null) return;
                                  setState(() {
                                    selectedSalesman = con.salesmanList
                                        .firstWhere((e) => e.name == val);
                                  });
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    d.nextFocus();
                                  });
                                },
                              )
                            ],
                          ),
                        SizedBox(
                          height: context.height * 0.1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              getLable(
                                  text: 'Total Amount:    ',
                                  fontSize: 20,
                                  color: Colors.black),
                              getLable(
                                text: con.totalAmount.toStringAsFixed(0),
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.1,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.1,
                              child: getLable(
                                text: 'Customer:',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.2,
                              child: getTextFormField(
                                isEnabled: selectedDateTime != null &&
                                    selectedSalesman != null,
                                controller: txt_customer,
                                //focusNode: c,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (val) async {
                                  if (_formKey.currentState!.validate()) {
                                    customerModel =
                                        await con.getCustomerByCode(val);

                                    if (customerModel == null) {
                                      setState(() {
                                        name = 'No customer found';
                                      });
                                    } else {
                                      setState(() {
                                        name = customerModel!.name ?? '';
                                      });
                                      // WidgetsBinding.instance
                                      //     .addPostFrameCallback((_) {
                                      //   a.requestFocus();
                                      // });
                                    }
                                  }
                                },
                                validator: (val) {
                                  if (val == null || val.toString().isEmpty) {
                                    return 'Customer code is required';
                                  } else if (val.toString().length != 4) {
                                    return 'code is not valid';
                                  } else if (!RegExp('[0-9]').hasMatch(val)) {
                                    return 'code is not valid';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.1,
                              child: getLable(
                                text: 'Name:',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.2,
                              child: getLable(
                                text: name,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        // SizedBox(
                        //   height: context.height * 0.02,
                        // ),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.1,
                              child: getLable(
                                text: 'Credit:',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.2,
                              child: getLable(
                                text: customerModel == null
                                    ? ''
                                    : (customerModel!.credit ?? 0)
                                        .toStringAsFixed(0),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.1,
                              child: getLable(
                                text: widget.depositType == CashInOut.Recovery
                                    ? 'Recovery:'
                                    : 'Loan:',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.2,
                              child: getTextFormField(
                                // isEnabled: c,
                                isEnabled: selectedDateTime != null &&
                                    selectedSalesman != null,
                                controller: txt_amount,
                                //  focusNode: a,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                textInputAction: TextInputAction.previous,
                                onFieldSubmitted: (val) async {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.depositType ==
                                        CashInOut.Recovery) {
                                      var res = await con.addDeposit(
                                        RecoveryModel(
                                          customer: customerModel,
                                          salesMan: selectedSalesman,
                                          date: selectedDateTime,
                                          recovery: double.parse(
                                            txt_amount.text,
                                          ),
                                          netCredit: customerModel!.credit! +
                                              double.parse(
                                                txt_amount.text,
                                              ),
                                        ),
                                        widget.depositType,
                                      );
                                      if (res) {
                                        customerModel = null;
                                        name = '';
                                        txt_amount.text = '';
                                        txt_customer.text = '';
                                        setState(() {});
                                      }
                                    } else {
                                      bool res = await con.addDeposit(
                                        CreditModel(
                                          customer: customerModel,
                                          salesMan: selectedSalesman,
                                          date: selectedDateTime,
                                          credit: double.parse(
                                            txt_amount.text,
                                          ),
                                          netCredit: customerModel!.credit! +
                                              double.parse(
                                                txt_amount.text,
                                              ),
                                        ),
                                        widget.depositType,
                                      );
                                      if (res) {
                                        customerModel = null;
                                        name = '';
                                        txt_amount.text = '';
                                        txt_customer.text = '';
                                        setState(() {});
                                      }
                                    }
                                  }
                                },
                                validator: (val) {
                                  if (customerModel == null) {
                                    return null;
                                  }

                                  if (val == null || val.toString().isEmpty) {
                                    return 'amount code is required';
                                  } else if (!RegExp('[0-9]').hasMatch(val)) {
                                    return 'amount is not valid';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width * 0.025,
                ),
              ],
            ),
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
          Spacer(),
          IconButton(
            onPressed: () async {
              showAlertDialog(context,
                  title:
                      'Deleting ${widget.depositType == CashInOut.Recovery ? model.recovery.toStringAsFixed(0) : model.credit.toStringAsFixed(0)}',
                  onYes: () async {
                await _con.deleteDeposit(model, widget.depositType);
                _con.modelList.removeAt(index);
                _con.update();
                Get.back();
              }, onNo: () {
                Get.back();
              },
                  content:
                      'are you sure you want to delete  ${model.customer.name}');
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
