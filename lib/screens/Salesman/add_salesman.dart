import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/salescontroller.dart';
import 'package:junaidtraders/models/salesman_model.dart';
import 'package:junaidtraders/utils/constants.dart';
import 'package:junaidtraders/utils/utils.dart';
import 'package:junaidtraders/utils/validations.dart';

class AddorUpdateSalesman extends StatefulWidget {
  const AddorUpdateSalesman({super.key, required this.con, this.salesManModel});
  final Salescontroller con;
  final SalesMan? salesManModel;

  @override
  State<AddorUpdateSalesman> createState() => _AddorUpdateSalesmanState();
}

class _AddorUpdateSalesmanState extends State<AddorUpdateSalesman> {
  late Salescontroller _con;

  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_add = TextEditingController();
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_cnic = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    _con = widget.con;
    if (widget.salesManModel != null) {
      txt_name.text = widget.salesManModel!.name ?? '';
      txt_add.text = widget.salesManModel!.address ?? '';
      txt_phone.text = widget.salesManModel!.phone ?? '';
      txt_cnic.text = widget.salesManModel!.cnic ?? '';
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
                child: getLable(text: 'Cnin: '),
              ),
              getTextFormField(
                width: context.width * 0.3,
                textInputFormatter: [cnicformatter],
                controller: txt_cnic,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                validator: (val) {
                  if (val == null || val.toString().isEmpty) {
                    return 'cnic is required';
                  }
                  return null;
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
                        if (widget.salesManModel != null) {
                          await updateSaleman();
                        } else {
                          await addSalesman();
                        }
                      }
                    },
                    text: widget.salesManModel != null ? 'Update' : 'Add',
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

  Future<void> addSalesman() async {
    await _con.addSalesman(
      model: SalesMan(
          name: txt_name.text,
          address: txt_add.text,
          phone: txt_phone.text,
          cnic: txt_cnic.text),
    );
    Get.back();
  }

  Future<void> updateSaleman() async {
    widget.salesManModel!.address = txt_add.text;
    widget.salesManModel!.phone = txt_phone.text;
    widget.salesManModel!.name = txt_name.text;
    widget.salesManModel!.cnic = txt_cnic.text;

    await _con.updatSales(model: widget.salesManModel!);
    Get.back();
  }
}
