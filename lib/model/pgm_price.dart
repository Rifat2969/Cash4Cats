class PgmPrice {
  PgmPrice({
    this.pt,
    this.pd,
    this.rh,
  });

  PgmPrice.fromJson(dynamic json) {
    pt = json['pt'];
    pd = json['pd'];
    rh = json['rh'];
  }
  int? pt;
  int? pd;
  int? rh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pt'] = pt;
    map['pd'] = pd;
    map['rh'] = rh;
    return map;
  }
}
