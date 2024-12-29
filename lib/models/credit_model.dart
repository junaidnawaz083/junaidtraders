class Credit {
  int? id;
  int? customrId;
  int? salesmaneId;
  double? credit;
  double? netCredit;
  String? date;

  Credit(
      {this.customrId,
      this.salesmaneId,
      this.credit,
      this.netCredit,
      this.date});

  Credit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customrId = json['customrId'];
    salesmaneId = json['salesmaneId'];
    credit = json['Credit'];
    netCredit = json['netCredit'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customrId'] = customrId;
    data['salesmaneId'] = salesmaneId;
    data['Credit'] = credit;
    data['netCredit'] = netCredit;
    data['date'] = date;
    return data;
  }
}
