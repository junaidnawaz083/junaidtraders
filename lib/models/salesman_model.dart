class SalesMan {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? cnic;

  SalesMan({this.name, this.phone, this.address, this.cnic});

  SalesMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['cnic'] = cnic;
    return data;
  }
}
