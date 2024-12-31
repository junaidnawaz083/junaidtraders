import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/customer_controller.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/utils/constants.dart';
import 'package:junaidtraders/utils/utils.dart';
import 'package:junaidtraders/utils/validations.dart';

class AddOrUpdateCustomer extends StatefulWidget {
  const AddOrUpdateCustomer({super.key, required this.con});
  final CustomerController con;

  @override
  State<AddOrUpdateCustomer> createState() => _AddOrUpdateCustomerState();
}

class _AddOrUpdateCustomerState extends State<AddOrUpdateCustomer> {
  late CustomerController _con;
  String? selectedRoute;
  FocusNode f1 = FocusNode();
  String CCode = '';
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_add = TextEditingController();
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_balance = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    _con = widget.con;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        body: Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Route: '),
              ),
              dropDownField(
                width: context.width * 0.3,
                value: selectedRoute,
                data: routes,
                onChange: (val) async {
                  CCode = await _con.getCustomerCodeByRoute(val);
                  setState(() {
                    selectedRoute = val;
                  });
                  f1.requestFocus();
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Code: '),
              ),
              SizedBox(
                width: context.width * 0.3,
                child: getLable(
                  text: CCode,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Name: '),
              ),
              getTextFormField(
                focusNode: f1,
                isEnabled: selectedRoute != null,
                width: context.width * 0.3,
                controller: txt_name,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                validator: (val) {
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Number: '),
              ),
              getTextFormField(
                textInputFormatter: [amountFormatter],
                isEnabled: selectedRoute != null,
                width: context.width * 0.3,
                controller: txt_phone,
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                onFieldSubmitted: (val) {},
                validator: (val) {
                  return validatePhoneNumber(number: val);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Address: '),
              ),
              getTextFormField(
                isEnabled: selectedRoute != null,
                width: context.width * 0.3,
                controller: txt_add,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                validator: (val) {
                  if (val == null || val.toString().isEmpty) {
                    return 'address is required';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Balance: '),
              ),
              getTextFormField(
                isEnabled: selectedRoute != null,
                textInputFormatter: [amountFormatter],
                width: context.width * 0.3,
                controller: txt_balance,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) async {
                  if (_key.currentState!.validate()) {
                    addCustomer();
                  }
                },
                validator: (val) {
                  if (val == null || val.toString().isEmpty) {
                    return null;
                  } else {
                    return validateDoubleValue(value: val);
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: context.width * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: context.width * 0.13,
                  child: getButton(
                      onPress: () async {
                        if (_key.currentState!.validate()) {
                          addCustomer();
                        }
                      },
                      text: 'Add'),
                ),
                SizedBox(
                  width: context.width * 0.04,
                ),
                SizedBox(
                  width: context.width * 0.13,
                  child: getButton(
                      onPress: () {
                        Get.back();
                      },
                      text: 'Back'),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<void> addCustomer() async {
    await _con.addCustomer(
      model: Customer(
        name: txt_name.text,
        code: CCode,
        address: txt_add.text,
        phone: txt_phone.text,
        credit: double.tryParse(txt_balance.text) ?? 0,
      ),
    );
    Get.back();
  }
}
