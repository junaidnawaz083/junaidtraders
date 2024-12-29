import 'dart:convert';

import 'package:junaidtraders/models/salesman_model.dart';

import 'customer_model.dart';

class RecoveryModel {
  int? id;
  Customer? customer;
  SalesMan? salesMan;
  double? recovery;
  double? netCredit;
  DateTime? date;

  RecoveryModel({
    this.customer,
    this.salesMan,
    this.recovery,
    this.netCredit,
    this.date,
  });

  RecoveryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    var cus = jsonDecode(json['customer']);
    customer = Customer.fromJson(cus);
    var sal = jsonDecode(json['salesman']);
    salesMan = SalesMan.fromJson(sal);
    recovery = json['recovery'];
    netCredit = json['netCredit'];
    date = DateTime.fromMicrosecondsSinceEpoch(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = jsonEncode(customer?.toJson());
    data['salesman'] = jsonEncode(salesMan?.toJson());
    data['recovery'] = recovery;
    data['netCredit'] = netCredit;
    data['date'] = date?.microsecondsSinceEpoch;
    return data;
  }
}
