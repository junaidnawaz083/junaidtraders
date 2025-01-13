import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/customer_controller.dart';
import 'package:junaidtraders/controllers/item_controller.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/models/item_model.dart';
import 'package:junaidtraders/utils/constants.dart';
import 'package:junaidtraders/utils/utils.dart';
import 'package:junaidtraders/utils/validations.dart';

class AddOrUpdateItem extends StatefulWidget {
  const AddOrUpdateItem({super.key, required this.con, this.itemModel});
  final ItemController con;
  final Item? itemModel;

  @override
  State<AddOrUpdateItem> createState() => _AddOrUpdateItemState();
}

class _AddOrUpdateItemState extends State<AddOrUpdateItem> {
  late ItemController _con;
  FocusNode f1 = FocusNode();
  String ICode = '';
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_company = TextEditingController();
  TextEditingController txt_cost = TextEditingController();
  TextEditingController txt_sale = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    _con = widget.con;
    if (widget.itemModel != null) {
      txt_name.text = widget.itemModel!.name ?? '';
      txt_company.text = widget.itemModel!.company ?? '';
      txt_cost.text = (widget.itemModel!.cost ?? '0').toString();
      txt_sale.text = (widget.itemModel!.sale ?? '0').toString();

      ICode = widget.itemModel!.code ?? '';

      setState(() {});
    } else {
      Future.delayed(Duration.zero, () async {
        ICode = await _con.getItemCode();
        setState(() {});
      });
    }
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
          // if (widget.itemModel == null)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         width: context.width * 0.15,
          //         child: getLable(text: 'Route: '),
          //       ),
          //       dropDownField(
          //         enabled: widget.itemModel == null,
          //         width: context.width * 0.3,
          //         value: selectedRoute,
          //         data: routes,
          //         onChange: (val) async {
          //           ICode = await _con.getCustomerCodeByRoute(val);
          //           setState(() {
          //             selectedRoute = val;
          //           });
          //           f1.requestFocus();
          //         },
          //       )
          //     ],
          //   ),
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
                  text: ICode,
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
                // isEnabled: selectedRoute != null,
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: context.width * 0.15,
          //       child: getLable(text: 'Number: '),
          //     ),
          //     getTextFormField(
          //       textInputFormatter: [amountFormatter],
          //       isEnabled: selectedRoute != null,
          //       width: context.width * 0.3,
          //       controller: txt_phone,
          //       textInputAction: TextInputAction.next,
          //       keyboardType:
          //           const TextInputType.numberWithOptions(decimal: false),
          //       onFieldSubmitted: (val) {},
          //       validator: (val) {
          //         return validatePhoneNumber(number: val);
          //       },
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Company: '),
              ),
              getTextFormField(
                //  isEnabled: selectedRoute != null,
                width: context.width * 0.3,
                controller: txt_company,
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
                child: getLable(text: 'Cost Price: '),
              ),
              getTextFormField(
                //  isEnabled: selectedRoute != null,
                textInputFormatter: [amountFormatter],
                width: context.width * 0.3,
                controller: txt_cost,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) async {},
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width * 0.15,
                child: getLable(text: 'Sale Price: '),
              ),
              getTextFormField(
                // isEnabled: selectedRoute != null,
                textInputFormatter: [amountFormatter],
                width: context.width * 0.3,
                controller: txt_sale,
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
                        if (widget.itemModel != null) {
                          await updateCustomer();
                        } else {
                          await addCustomer();
                        }
                      }
                    },
                    text: widget.itemModel != null ? 'Update' : 'Add',
                  ),
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
                    text: 'Back',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<void> addCustomer() async {
    await _con.addItem(
      model: Item(
        name: txt_name.text,
        code: ICode,
        company: txt_company.text,
        cost: double.tryParse(txt_cost.text) ?? 0,
        sale: double.tryParse(txt_sale.text) ?? 0,
      ),
    );
    Get.back();
  }

  Future<void> updateCustomer() async {
    widget.itemModel!.company = txt_company.text;
    widget.itemModel!.name = txt_name.text;
    widget.itemModel!.sale = double.tryParse(txt_sale.text) ?? 0;
    widget.itemModel!.cost = double.tryParse(txt_cost.text) ?? 0;

    await _con.updateItem(model: widget.itemModel!);
    Get.back();
  }
}
