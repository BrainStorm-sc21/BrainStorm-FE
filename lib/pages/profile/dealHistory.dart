import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/utilities/Popups.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DealHistoryPage extends StatefulWidget {
  final int userId;
  const DealHistoryPage({super.key, required this.userId});

  @override
  State<DealHistoryPage> createState() => _DealHistoryPageState();
}

class _DealHistoryPageState extends State<DealHistoryPage> {
  late List<Deal> myPosts = [];

  Future getServerMyDealDataWithDio() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/deal/${widget.userId}/my");

      print("Deal Status: ${resp.statusCode}");
      print("My Deal Data: ${resp.data}");

      DealData dealData = DealData.fromJson(resp.data);

      print('딜 데이터: ${dealData.data}');

      setState(() {
        for (Deal deal in dealData.data) {
          print('게시글: $deal');
          myPosts.add(deal);
        }
      });
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServerMyDealDataWithDio();
    print('내 게시글: $myPosts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorStyles.lightGrey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorStyles.mainColor),
        title: const Text(
          '거래내역',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: ColorStyles.mainColor),
        ),
        backgroundColor: ColorStyles.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        color: ColorStyles.lightGrey,
        child:
            // (myPosts.isEmpty)
            //     ? const Center(child: Text('내가 올린 게시글이 없습니다!'))
            //     :
            ListView.builder(
                itemCount: myPosts.length,
                itemBuilder: ((context, index) {
                  print('내 게시글의 갯수: ${myPosts.length}');
                  return MyPostUnit(
                    deal: myPosts[index],
                    statusCheck: (index % 2 == 0),
                  );
                })),
      ),
    );
  }
}

class MyPostUnit extends StatefulWidget {
  final Deal deal;
  final bool statusCheck; //true - 거래 중, false - 거래 완료 가능
  const MyPostUnit({super.key, required this.deal, required this.statusCheck});

  @override
  State<MyPostUnit> createState() => _MyPostUnitState();
}

class _MyPostUnitState extends State<MyPostUnit> {
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
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorStyles.white,
        ),
        width: double.infinity,
        height: 150,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: (widget.deal.dealImage1 != null)
                        ? Image.network(widget.deal.dealImage1!,
                            height: 60, width: 60, fit: BoxFit.fill)
                        : Image.asset('assets/images/logo.png',
                            height: 60, width: 60, fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 20,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: DealType.dealColors[widget.deal.dealType],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                                DealType.dealTypeName[widget.deal.dealType],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: DealType
                                        .dealTextColors[widget.deal.dealType],
                                    fontWeight: FontWeight.w500,
                                    height: 1)),
                          ),
                        ),
                        Text(
                          widget.deal.dealName,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            countHour(widget.deal.createdAt),
                            style: const TextStyle(
                                color: ColorStyles.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundedOutlinedButton(
                  width: double.infinity,
                  height: 26,
                  text: (widget.statusCheck) ? '거래중' : '거래완료하기',
                  onPressed: () {
                    Popups.showReview(context);
                  },
                  backgroundColor: (widget.statusCheck)
                      ? ColorStyles.grey
                      : ColorStyles.mainColor,
                  foregroundColor: ColorStyles.white,
                  borderColor: (widget.statusCheck)
                      ? ColorStyles.grey
                      : ColorStyles.mainColor),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
