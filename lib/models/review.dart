import 'dart:ffi';

class Review {
  int? reviewId;
  int reviewFrom;
  String? reviewFromName;
  Double? reviewFromReliability;
  int reviewTo;
  String? reviewToName;
  Double? reviewToReliability;
  int dealId;
  double rating;
  String reviewContent;
  String? createdAt;

  Review({
    required this.reviewFrom,
    required this.reviewTo,
    required this.dealId,
    required this.rating,
    required this.reviewContent,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['reviewFrom'] = reviewFrom;
    data['reviewTo'] = reviewTo;
    data['rating'] = rating;
    data['reviewContent'] = reviewContent;

    return data;
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewFrom: json['reviewFrom'],
      reviewTo: json['reviewTo'],
      dealId: json['dealId'],
      rating: json['rating'],
      reviewContent: json['reviewContent'],
    );
  }
}
