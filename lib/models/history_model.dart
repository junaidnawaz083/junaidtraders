class History {
  int? id;
  int? customerId;
  int? salesmanId;
  String? type;
  int? typeId;
  double? amount;
  String? date;

  History(
      {this.customerId,
      this.salesmanId,
      this.type,
      this.typeId,
      this.amount,
      this.date});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    salesmanId = json['salesmanId'];
    type = json['type'];
    typeId = json['typeId'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['salesmanId'] = salesmanId;
    data['type'] = type;
    data['typeId'] = typeId;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}
