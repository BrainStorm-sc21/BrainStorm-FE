import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/Popups.dart';
import 'package:brainstorm_meokjang/utilities/count_hour.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';

class TradingBoard extends StatelessWidget {
  final int userId;
  const TradingBoard({super.key, required this.posts, required this.userId});

  final List<Deal> posts;

  @override
  Widget build(BuildContext context) {
    Deal deal;
    return ListView.builder(
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return const ADVBanner();
        deal = posts[index - 1];
        final dealName = deal.dealName;
        final distance = deal.distance!.round();
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
            bool isMine = (posts[index - 1].userId == userId) ? true : false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DealDetailPage(
                          userId: userId,
                          deal: posts[index - 1],
                          isMine: isMine,
                        )));
          },
        );
      },
    );
  }
}

class OnePostUnit extends StatefulWidget {
  final Deal deal;
  final bool isChat;
  final bool isMyDeal;
  const OnePostUnit(
      {super.key,
      required this.deal,
      this.isChat = false,
      this.isMyDeal = false});

  @override
  State<OnePostUnit> createState() => _OnePostUnitState();
}

class _OnePostUnitState extends State<OnePostUnit> {
  late String dealName;
  late int distance;
  late int dealType;
  late String time;
  late String? imgUrl;

  void setDeal() {
    dealName = widget.deal.dealName;
    distance = widget.deal.distance!.round();
    dealType = widget.deal.dealType;
    time = countHour(widget.deal.createdAt);
    imgUrl = widget.deal.dealImage1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDeal();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imgUrl != null
                  ? Image.network(imgUrl!,
                      height: 60, width: 60, fit: BoxFit.fill)
                  : Image.asset('assets/images/logo.png',
                      height: 60, width: 60, fit: BoxFit.fill),
            ),
            const SizedBox(width: 8),
            Container(
              width: 35,
              height: 20,
              margin: const EdgeInsets.only(bottom: 25),
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
                  width: (widget.isMyDeal)
                      ? MediaQuery.of(context).size.width * 0.3
                      : MediaQuery.of(context).size.width * 0.5,
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
                        Text((widget.isChat) ? ' ' : time,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey, height: 1)),
                      ]),
                ),
                const SizedBox(height: 6),
                Text('${distance}M',
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
            const Spacer(),
            (widget.isChat == true && widget.isMyDeal == true)
                ? OutlinedButton(
                    onPressed: () {
                      Popups.showParticipantList(
                          context, widget.deal.dealId, widget.deal.userId);
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorStyles.mainColor)),
                    child: const Text(
                      '거래완료',
                      style:
                          TextStyle(color: ColorStyles.mainColor, fontSize: 14),
                    ),
                  )
                : const SizedBox(width: 5)
          ],
        ));
  }
}

class ADVBanner extends StatelessWidget {
  const ADVBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorStyles.mainColor,
        ),
        height: 80,
        child: const Center(
            child: Text(
          '광고배너입니다.',
          style: TextStyle(fontSize: 15),
        )),
      ),
    );
  }
}
