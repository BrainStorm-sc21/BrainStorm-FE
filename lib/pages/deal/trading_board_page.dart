import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/count_hour.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TradingBoard extends StatelessWidget {
  final int userId;
  const TradingBoard({super.key, required this.posts, required this.userId});

  final List<Deal> posts;

  @override
  Widget build(BuildContext context) {
    Deal deal;
    return ListView.builder(
      itemCount: posts.length,
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
  const OnePostUnit({super.key, required this.deal, this.isChat = false});

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
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 55,
              height: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imgUrl == null
                    ? Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imgUrl!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  height: 20,
                  decoration: BoxDecoration(
                    color: DealType.dealColors[dealType],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      DealType.dealTypeName[dealType],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: DealType.dealTextColors[dealType],
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    dealName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  print('거래완료 버튼 클릭!');
                  showCompleteDealDialog(context);
                },
                icon: const Icon(CupertinoIcons.checkmark_rectangle)),
          ],
        ));
  }
}

//Regrigerator의 다이얼로그를 활용
void showCompleteDealDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("거래를 완료하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {},
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      });
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
