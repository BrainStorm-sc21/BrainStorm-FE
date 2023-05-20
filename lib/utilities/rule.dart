import 'package:brainstorm_meokjang/utilities/colors.dart';

class StockRange {
  static const num minStock = 0.1;
  static const num maxStock = 999;
}

class DealType {
  static const List dealTypeName = ["공구", "교환", "나눔"];
  static const List dealColors = [
    ColorStyles.groupBuyColor,
    ColorStyles.exchangeColor,
    ColorStyles.shareColor
  ];

  static const List dealTextColors = [
    ColorStyles.groupBuyTextColor,
    ColorStyles.exchangeTextColor,
    ColorStyles.shareTextColor
  ];

  static const List markerImage = [
    'assets/images/groupMarker.png',
    'assets/images/exchangeMarker.png',
    'assets/images/shareMarker.png'
  ];
}
