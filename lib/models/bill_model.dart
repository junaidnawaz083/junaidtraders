import 'dart:convert';

class Bill {
  int? customerId;
  int? salesmanId;
  String? type;
  double? totalAmount;
  int? totalItems;
  String? date;
  List<BillingItems>? billingItems;

  Bill({
    required this.customerId,
    required this.salesmanId,
    required this.type,
    required this.totalAmount,
    required this.totalItems,
    required this.date,
    required this.billingItems,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    salesmanId = json['salesmanId'];
    type = json['type'];
    totalAmount = json['totalAmount'];
    totalItems = json['totalItems'];
    date = json['date'];
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
    data['customerId'] = customerId;
    data['salesmanId'] = salesmanId;
    data['type'] = type;
    data['totalAmount'] = totalAmount;
    data['totalItems'] = totalItems;
    data['date'] = date;
    if (billingItems != null) {
      data['billingItems'] =
          jsonEncode(billingItems!.map((v) => v.toJson()).toList());
    }
    return data;
  }
}

class BillingItems {
  int? itemId;
  int? quantity;
  String? itemName;
  double? price;
  double? totalPrice;
  double? discount;

  BillingItems({
    required this.itemId,
    required this.quantity,
    required this.itemName,
    required this.price,
    required this.totalPrice,
    required this.discount,
  });

  BillingItems.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    quantity = json['quantity'];
    itemName = json['itemName'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['quantity'] = quantity;
    data['itemName'] = itemName;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['discount'] = discount;
    return data;
  }
}
