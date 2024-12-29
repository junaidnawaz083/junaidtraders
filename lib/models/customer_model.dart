class Customer {
  int? id;
  String? name;
  String? code;
  String? route;
  String? phone;
  String? address;
  double? credit;

  Customer({
    required this.name,
    required this.code,
    this.phone,
    this.address,
    this.credit,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    route = json['route'];
    phone = json['phone'];
    address = json['address'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['code'] = code;
    data['name'] = name;
    data['route'] = route;
    data['phone'] = phone;
    data['address'] = address;
    data['credit'] = credit;
    return data;
  }
}
