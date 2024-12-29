import 'dart:convert';

import 'customer_model.dart';
import 'salesman_model.dart';

class History {
  int? id;
  Customer? customer;
  SalesMan? salesMan;
  String? type;
  int? typeId;
  double? amount;
  String? date;

  History(
      {this.customer,
      this.salesMan,
      this.type,
      this.typeId,
      this.amount,
      this.date});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    var cus = jsonDecode(json['customer']);
    customer = Customer.fromJson(cus);
    var sal = jsonDecode(json['salesman']);
    salesMan = SalesMan.fromJson(sal);
    type = json['type'];
    typeId = json['typeId'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = jsonEncode(customer?.toJson());
    data['salesman'] = jsonEncode(salesMan?.toJson());
    data['type'] = type;
    data['typeId'] = typeId;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}
