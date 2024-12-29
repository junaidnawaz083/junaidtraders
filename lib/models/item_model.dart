class Item {
  int? id;
  String? code;
  String? name;
  String? company;
  double? cost;
  double? sale;

  Item({this.code, this.name, this.company, this.cost, this.sale});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    company = json['company'];
    cost = json['cost'];
    sale = json['sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['company'] = company;
    data['cost'] = cost;
    data['sale'] = sale;
    return data;
  }
}
