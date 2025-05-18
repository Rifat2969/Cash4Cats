class ProductsData {
  ProductsData({
    this.catalogueId,
    this.name,
    this.sampleCode,
    this.price,
    this.isPopular,
    this.catalogueImage,
    this.categoryName,
    this.categoryImage,
  });

  ProductsData.fromJson(dynamic json) {
    catalogueId = json['catalogue_id'];
    name = json['name'];
    sampleCode = json['sample_code'];
    price = json['price'];
    isPopular = json['is_popular'];
    catalogueImage = json['catalogue_image'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }
  int? catalogueId;
  String? name;
  String? sampleCode;
  dynamic price;
  bool? isPopular;
  String? catalogueImage;
  String? categoryName;
  String? categoryImage;
  int quantity = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catalogue_id'] = catalogueId;
    map['name'] = name;
    map['sample_code'] = sampleCode;
    map['price'] = price;
    map['is_popular'] = isPopular;
    map['catalogue_image'] = catalogueImage;
    map['category_name'] = categoryName;
    map['category_image'] = categoryImage;
    return map;
  }
}
