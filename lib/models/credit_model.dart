import 'dart:convert';

import 'package:junaidtraders/models/salesman_model.dart';

import 'customer_model.dart';

class CreditModel {
  int? id;
  Customer? customer;
  SalesMan? salesMan;
  double? credit;
  double? netCredit;
  DateTime? date;

  CreditModel({
    this.customer,
    this.salesMan,
    this.credit,
    this.netCredit,
    this.date,
  });

  CreditModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    var cus = jsonDecode(json['customer']);
    customer = Customer.fromJson(cus);
    var sal = jsonDecode(json['salesman']);
    salesMan = SalesMan.fromJson(sal);
    credit = json['credit'];
    netCredit = json['netCredit'];
    date = DateTime.fromMicrosecondsSinceEpoch(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = jsonEncode(customer?.toJson());
    data['salesman'] = jsonEncode(salesMan?.toJson());
    data['credit'] = credit;
    data['netCredit'] = netCredit;
    data['date'] = date?.microsecondsSinceEpoch;
    return data;
  }
}
