class ProfileData {
  ProfileData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.businessName,
    this.businessAbn,
    this.profileImage,
    this.selectedLanguage,
    this.priceGroup,
  });

  ProfileData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    businessName = json['business_name'];
    businessAbn = json['business_abn'];
    profileImage = json['profile_image'];
    selectedLanguage = json['selected_language'];
    priceGroup = json['price_group'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? businessName;
  String? businessAbn;
  String? profileImage;
  String? selectedLanguage;
  dynamic priceGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['business_name'] = businessName;
    map['business_abn'] = businessAbn;
    map['profile_image'] = profileImage;
    map['selected_language'] = selectedLanguage;
    map['price_group'] = priceGroup;
    return map;
  }
}
