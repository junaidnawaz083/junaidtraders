import 'package:junaidtraders/models/salesman_model.dart';

import 'customer_model.dart';

class Recovery {
  int? id;
  int? customrId;
  int? salesmaneId;
  Customer? customerModel;
  SalesMan? salesMan;
  double? recovery;
  double? netCredit;
  String? date;

  Recovery({
    this.customrId,
    this.salesmaneId,
    this.recovery,
    this.netCredit,
    this.date,
  });

  Recovery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customrId = json['customrId'];

    salesmaneId = json['salesmaneId'];
    recovery = json['recovery'];
    netCredit = json['netCredit'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customrId'] = customrId;
    data['salesmaneId'] = salesmaneId;
    data['recovery'] = recovery;
    data['netCredit'] = netCredit;
    data['date'] = date;
    return data;
  }
}
