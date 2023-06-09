import 'dart:ffi';

class SentReviewData {
  final List<Review> data;

  SentReviewData({required this.data});

  factory SentReviewData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;

    List<Review> reviewList = list.map((i) => Review.fromJson(i)).toList();

    return SentReviewData(data: reviewList);
  }
}

class ReceivedReviewData {
  final List<Review> data;

  ReceivedReviewData({required this.data});

  factory ReceivedReviewData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;

    List<Review> reviewList = list.map((i) => Review.fromJson(i)).toList();

    return ReceivedReviewData(data: reviewList);
  }
}

class Review {
  int? reviewId;
  int reviewFrom;
  String? reviewFromName;
  Double? reviewFromReliability;
  int reviewTo;
  String? reviewToName;
  Double? reviewToReliability;
  int dealId;
  int rating;
  String? reviewContent;
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
