// ignore_for_file: non_constant_identifier_names

class Review {
  Review({
    this.title,
    this.total,
  });

  Review.fromJson(dynamic json) {
    title = json['title'];
    total = json['title2'];
  }
  String? title;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['title2'] = total;

    return map;
  }
}

List<Review> all_reviews = [
  Review(
    title: 'Total Sold',
    total: '154',
  ),
  Review(
    title: 'Out Standing',
    total: '321',
  ),
  Review(
    title: 'Due',
    total: '32',
  ),
];
