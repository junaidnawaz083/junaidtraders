import 'dart:convert';

import 'package:junaidtraders/models/item_model.dart';

import 'customer_model.dart';
import 'salesman_model.dart';

class Bill {
  int? id;
  Customer? customer;
  SalesMan? salesMan;
  String? type;
  double? totalAmount;
  int? totalItems;
  DateTime? date;
  List<BillingItems>? billingItems;

  Bill({
    required this.customer,
    required this.salesMan,
    required this.type,
    required this.totalAmount,
    required this.totalItems,
    required this.date,
    required this.billingItems,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    var cus = jsonDecode(json['customer']);
    customer = Customer.fromJson(cus);
    var sal = jsonDecode(json['salesmane']);
    salesMan = SalesMan.fromJson(sal);
    type = json['type'];
    totalAmount = json['totalAmount'];
    totalItems = json['totalItems'];
    date = DateTime.fromMicrosecondsSinceEpoch(json['date']);
    if (json['billingItems'] != null) {
      var d = jsonDecode(json['billingItems']);
      billingItems = <BillingItems>[];
      d.forEach((v) {
        billingItems!.add(BillingItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = jsonEncode(customer?.toJson());
    data['salesman'] = jsonEncode(salesMan?.toJson());
    data['type'] = type;
    data['totalAmount'] = totalAmount;
    data['totalItems'] = totalItems;
    data['date'] = date?.microsecondsSinceEpoch;
    if (billingItems != null) {
      data['billingItems'] =
          jsonEncode(billingItems!.map((v) => v.toJson()).toList());
    }
    return data;
  }
}

class BillingItems {
  Item? item;
  int? quantity;
  double? price;
  double? totalPrice;
  double? discount;

  BillingItems({
    required this.item,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.discount,
  });

  BillingItems.fromJson(Map<String, dynamic> json) {
    var i = jsonDecode(json['item']);
    item = Item.fromJson(i);
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = jsonEncode(item?.toJson());
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['discount'] = discount;
    return data;
  }
}
