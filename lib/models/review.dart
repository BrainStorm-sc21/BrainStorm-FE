class SentReviewData {
  final List<Review> data;

  SentReviewData({required this.data});

  factory SentReviewData.fromJson(Map<String, dynamic> json) {
    var list = json['data']['reviewFrom'] as List;

    List<Review> reviewList = list.map((i) => Review.fromJson(i)).toList();

    return SentReviewData(data: reviewList);
  }
}

class ReceivedReviewData {
  final List<Review> data;

  ReceivedReviewData({required this.data});

  factory ReceivedReviewData.fromJson(Map<String, dynamic> json) {
    var list = json['data']['reviewTo'] as List;

    List<Review> reviewList = list.map((i) => Review.fromJson(i)).toList();

    return ReceivedReviewData(data: reviewList);
  }
}

class Review {
  int? reviewId;
  int reviewFrom;
  String? reviewFromName;
  double? reviewFromReliability;
  int reviewTo;
  String? reviewToName;
  double? reviewToReliability;
  int dealId;
  String? dealName;
  double rating;
  String? reviewContent;
  String? createdAt;

  Review({
    this.reviewId,
    required this.reviewFrom,
    this.reviewFromName,
    this.reviewFromReliability,
    required this.reviewTo,
    this.reviewToName,
    this.reviewToReliability,
    required this.dealId,
    this.dealName,
    required this.rating,
    required this.reviewContent,
    this.createdAt,
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
      reviewFromName: json['reviewFromName'],
      reviewFromReliability: json['reviewFromReliability'],
      reviewTo: json['reviewTo'],
      reviewToName: json['reviewToName'],
      reviewToReliability: json['reviewToReliability'],
      dealId: json['dealId'],
      dealName: json['dealName'],
      rating: json['rating'],
      reviewContent: json['reviewContent'],
      createdAt: json['createdAt'],
    );
  }
}
