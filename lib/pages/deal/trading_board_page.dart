import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class TradingBoard extends StatelessWidget {
  const TradingBoard({super.key, required this.posts});

  final List<Deal> posts;

  final Map dealColors = const {
    '공구': ColorStyles.groupBuyColor,
    '교환': ColorStyles.exchangeColor,
    '나눔': ColorStyles.shareColor
  };

  final Map dealTextColors = const {
    '공구': ColorStyles.groupBuyTextColor,
    '교환': ColorStyles.exchangeTextColor,
    '나눔': ColorStyles.shareTextColor
  };

  @override
  Widget build(BuildContext context) {
    Deal deal;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        deal = posts[index];
        final dealName = deal.dealName;
        final distance = deal.distance;
        final dealType = deal.dealType;
        final time = deal.dealTime;
        final imgUrl = deal.dealImage;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 35,
                height: 20,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: dealColors[dealType],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(dealType,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          color: dealTextColors[dealType],
                          fontWeight: FontWeight.w500,
                          height: 1)),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 270,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Flexible(
                          child: Text(dealName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500, height: 1),
                              overflow: TextOverflow.ellipsis)),
                      Text(time,
                          style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1)),
                    ]),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    distance,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
