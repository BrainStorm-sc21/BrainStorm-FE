import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';

class TradingBoard extends StatelessWidget {
  final int userId;
  const TradingBoard({super.key, required this.posts, required this.userId});

  final List<Deal> posts;

  String countHour(DateTime givenDate) {
    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(givenDate);
    int minutesDifference = difference.inMinutes;
    int hoursDifference = difference.inHours;
    int daysDifference = difference.inDays;

    if (daysDifference >= 1) {
      return '$daysDifference일 전';
    } else if (hoursDifference >= 1) {
      return '$hoursDifference시간 전';
    } else if (minutesDifference == 0) {
      return '방금 전';
    } else {
      return '$minutesDifference분 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    Deal deal;
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        deal = posts[index];
        final dealName = deal.dealName;
        final distance = deal.distance.round();
        final dealType = deal.dealType;
        final time = countHour(deal.createdAt);
        final imgUrl = deal.dealImage1;
        return InkWell(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imgUrl != null
                        ? Image.network(imgUrl,
                            height: 60, width: 60, fit: BoxFit.fill)
                        : Image.asset('assets/images/logo.png',
                            height: 60, width: 60, fit: BoxFit.fill),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 35,
                    height: 20,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: DealType.dealColors[dealType],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(DealType.dealTypeName[dealType],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              color: DealType.dealTextColors[dealType],
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(dealName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 1),
                                      overflow: TextOverflow.ellipsis)),
                              Text(time,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      height: 1)),
                            ]),
                      ),
                      const SizedBox(height: 6),
                      Text('${distance}M',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ],
              )),
          onTap: () {
            bool isMine = (posts[index].userId == userId) ? true : false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DealDetailPage(
                          deal: posts[index],
                          isMine: isMine,
                        )));
          },
        );
      },
    );
  }
}
