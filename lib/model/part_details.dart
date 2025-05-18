// ignore_for_file: non_constant_identifier_names

class PartDetails {
  PartDetails({
    this.specification,
    this.ans,
  });

  PartDetails.fromJson(dynamic json) {
    specification = json['title'];
    ans = json['title2'];
  }
  String? specification;
  String? ans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = specification;
    map['title2'] = ans;

    return map;
  }
}

List<PartDetails> all_details = [
  PartDetails(
    specification: 'Status',
    ans: '154',
  ),
  PartDetails(
    specification: 'Brand',
    ans: "Brand's Name",
  ),
  PartDetails(
    specification: 'Dimension',
    ans: 'Value',
  ),
  PartDetails(
    specification: 'Color',
    ans: "Product's Color",
  ),
  PartDetails(
    specification: 'Other details',
    ans: 'Value here',
  ),
];
