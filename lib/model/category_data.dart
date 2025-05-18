class CategoryData {
  CategoryData({
    this.id,
    this.name,
    this.image,
    this.appearInMenu,
    this.isActive,
    this.code,
    this.catCount,
    this.createdAt,
  });

  CategoryData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    appearInMenu = json['appear_in_menu'];
    isActive = json['is_active'];
    code = json['code'];
    catCount = json['cat_count'];
    createdAt = json['created_at'];
  }
  int? id;
  String? name;
  String? image;
  dynamic appearInMenu;
  String? isActive;
  String? code;
  int? catCount;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['appear_in_menu'] = appearInMenu;
    map['is_active'] = isActive;
    map['code'] = code;
    map['cat_count'] = catCount;
    map['created_at'] = createdAt;
    return map;
  }
}
