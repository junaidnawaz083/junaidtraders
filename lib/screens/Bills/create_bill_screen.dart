// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/bill_controller.dart';
import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/salesman_model.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';

class CreateBillScreen extends StatefulWidget {
  const CreateBillScreen({
    super.key,
  });

  @override
  State<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends State<CreateBillScreen> {
  final _con = Get.put(BillController());
  FocusNode itemCode = FocusNode();
  FocusNode itemQty = FocusNode();
  FocusNode d = FocusNode();

  DateTime selectedDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  SalesMan? selectedSalesman;
  String name = '';
  TextEditingController txt_qty = TextEditingController();
  TextEditingController txt_itemCode = TextEditingController();
  TextEditingController txt_price = TextEditingController();

  TextEditingController txt_customer = TextEditingController();
  final ScrollController _controller = ScrollController();

  Customer? customerModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _con.init();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: SizedBox(
          width: context.width * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getButton(
                onPress: () async {
                  await createBill();
                },
                text: '   Save    ',
              ),
              getButton(
                onPress: () {
                  resetBill();
                },
                text: '   Reset    ',
              ),
              getButton(
                onPress: () {
                  Get.back();
                },
                text: '   Back    ',
              ),
            ],
          ),
        ),
      ),
      title: 'Create Bill',
      body: GetBuilder<BillController>(builder: (con) {
        if (con.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                              width: context.width * 0.15,
                              child: getLable(
                                text: 'Name',
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.02,
                            ),
                            SizedBox(
                              width: context.width * 0.05,
                              child: getLable(
                                text: 'Qty',
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
                            SizedBox(
                              width: context.width * 0.02,
                            ),
                          ],
                        ),
                      ),
                      if (con.billModel != null)
                        Expanded(
                          child: Scrollbar(
                            controller: _controller,
                            child: ListView.builder(
                              controller: _controller,
                              shrinkWrap: true,
                              itemCount: con.billModel!.billingItems?.length,
                              itemBuilder: (context, ind) {
                                return getListTile(
                                    con.billModel!.billingItems![ind], ind);
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
                                ? selectedDateTime.formatedDateTime()
                                : 'Select Date',
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
                            child: getLable(text: 'Salesman:', fontSize: 20),
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
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                d.nextFocus();
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: context.height * 0.025,
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
                                  selectedSalesman != null &&
                                  name == '',
                              controller: txt_customer,
                              focusNode: d,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (val) async {
                                if (_formKey.currentState!.validate()) {
                                  customerModel =
                                      await con.getCustomerByCode(val);

                                  if (customerModel == null) {
                                    setState(() {
                                      name = 'No customer found';
                                    });
                                  } else {
                                    con.billModel = Bill(
                                        customer: customerModel,
                                        salesMan: selectedSalesman,
                                        type: 'Credit Bill',
                                        totalAmount: 0,
                                        totalItems: 0,
                                        date: selectedDateTime,
                                        billingItems: []);
                                    setState(() {
                                      name = customerModel!.name ?? '';
                                    });
                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      itemCode.requestFocus();
                                    });
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
                        height: context.height * 0.025,
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
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      if (name != '' && name != 'No customer found')
                        itemWidget(con),
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
      }),
    );
  }

  Widget itemWidget(BillController con) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration:
          BoxDecoration(color: primary, borderRadius: BorderRadius.circular(9)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: 'Item Code:',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: context.width * 0.2,
                child: getTextFormField(
                  isEnabled: name != '',
                  controller: txt_itemCode,
                  focusNode: itemCode,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) async {
                    if (_formKey.currentState!.validate()) {
                      await con.findItemByCode(val);
                      if (con.currentItem != null) {
                        txt_price.text =
                            con.currentItem!.sale!.toStringAsFixed(0);
                        txt_qty.text = '1';
                      }
                    }
                  },
                  validator: (val) {
                    if (val == null || val.toString().isEmpty) {
                      return 'Item code is required';
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
            height: context.height * 0.025,
          ),
          Row(
            children: [
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: 'Item Name:',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: context.width * 0.2,
                child: getLable(
                  text: con.currentItem != null ? con.currentItem!.name! : '',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.025,
          ),
          Row(
            children: [
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: 'Item Price:',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: context.width * 0.2,
                child: getTextFormField(
                  isEnabled: name != '',
                  controller: txt_price,
                  //focusNode: c,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) async {
                    if (_formKey.currentState!.validate()) {}
                  },
                  validator: (val) {
                    if (con.currentItem == null) {
                      return null;
                    } else if (val == null || val.toString().isEmpty) {
                      return 'price is required';
                    } else if (!RegExp('[0-9]').hasMatch(val)) {
                      return 'price is not valid';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.025,
          ),
          Row(
            children: [
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                    text: 'Quantity', fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                width: context.width * 0.2,
                child: getTextFormField(
                  // isEnabled: c,
                  isEnabled:
                      selectedDateTime != null && selectedSalesman != null,
                  controller: txt_qty,
                  // focusNode: itemQty,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  //  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) async {
                    await con.addItemToBill(con.currentItem!,
                        int.parse(txt_qty.text), double.parse(txt_price.text));
                    txt_itemCode.clear();
                    txt_qty.clear();
                    txt_price.clear();
                    itemCode.requestFocus();
                  },
                  validator: (val) {
                    if (con.currentItem == null) {
                      return null;
                    } else if (val == null || val.toString().isEmpty) {
                      return 'quantity is required';
                    } else if (!RegExp('[0-9]').hasMatch(val)) {
                      return 'quantity is not valid';
                    }

                    return null;
                  },
                ),
              ),
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
                color: primary, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                getLable(
                  text: 'Total Amount:    ',
                  fontSize: 20,
                  color: Colors.black,
                ),
                getLable(
                  text: con.billModel == null
                      ? ''
                      : con.billModel!.totalAmount!.toStringAsFixed(0),
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getListTile(BillingItems model, index) {
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
              text: model.item!.code!,
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.15,
            child: getLable(
              text: model.item!.name!,
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.05,
            child: getLable(
              text: model.quantity!.toString(),
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
              text: model.totalPrice!.toStringAsFixed(0),
              fontSize: 18,
              color: index % 2 != 0 ? Colors.white : Colors.white70,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          Spacer(),
          IconButton(
            onPressed: () async {
              showAlertDialog(context, title: 'Deleting ${model.item!.name}?',
                  onYes: () async {
                _con.billModel!.billingItems!.removeAt(index);
                _con.update();
                Get.back();
              }, onNo: () {
                Get.back();
              },
                  content:
                      'are you sure you want to delete ${model.item!.name}');
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Future<void> createBill() async {
    bool res = await _con.addBill();
    if (res) {
      name = '';
      d.requestFocus();
      setState(() {});
    }
  }

  Future<void> resetBill() async {
    _con.billModel = null;
    _con.currentItem = null;
    name = '';
    txt_customer.clear();
    txt_itemCode.clear();
    txt_price.clear();
    txt_qty.clear();
    d.requestFocus();
    _con.update();
  }
}
