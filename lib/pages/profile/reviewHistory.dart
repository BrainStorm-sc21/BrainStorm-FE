import 'package:brainstorm_meokjang/models/review.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReviewHistoryPage extends StatefulWidget {
  final int userId;
  const ReviewHistoryPage({super.key, required this.userId});

  @override
  State<ReviewHistoryPage> createState() => _ReviewHistoryPageState();
}

//home_page의 tabbar 활용
class _ReviewHistoryPageState extends State<ReviewHistoryPage> {
  late List<Review> sentReviewList = List.empty(growable: true);
  late List<Review> receivedReviewList = List.empty(growable: true);

  Future getServerMyReviewDataWithDio() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/review/${widget.userId}");

      print("Review Status: ${resp.statusCode}");
      print("My Review Data: ${resp.data}");

      if (resp.statusCode == 200) {
        print('통신 성공!!');

        SentReviewData sentReviews = SentReviewData.fromJson(resp.data);
        ReceivedReviewData receivedReviews =
            ReceivedReviewData.fromJson(resp.data);

        setState(() {
          for (Review review in sentReviews.data) {
            sentReviewList.add(review);
          }
          for (Review review in receivedReviews.data) {
            receivedReviewList.add(review);
          }
        });
      }
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
    getServerMyReviewDataWithDio();
  }

  TabBar get _tabBar => const TabBar(
      padding: EdgeInsets.only(top: 10),
      isScrollable: false,
      indicatorColor: ColorStyles.mainColor,
      indicatorWeight: 4,
      labelColor: ColorStyles.mainColor,
      unselectedLabelColor: ColorStyles.textColor,
      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      tabs: [Tab(text: "보낸 후기"), Tab(text: "받은 후기")]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorStyles.mainColor),
          title: const Text(
            '후기내역',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: ColorStyles.mainColor),
          ),
          backgroundColor: ColorStyles.white,
          elevation: 0,
          centerTitle: false,
        ),
        body: Column(
          children: [
            _tabBar,
            const Divider(
                height: 0,
                color: ColorStyles.lightgrey,
                thickness: 1.5,
                endIndent: 10),
            Expanded(
                child: TabBarView(
              children: [
                Container(
                    color: ColorStyles.lightGrey,
                    child: (sentReviewList.isNotEmpty)
                        ? ListView.builder(
                            itemCount: sentReviewList.length,
                            itemBuilder: ((context, index) {
                              return MyReviewUnit(
                                reviewPoint: sentReviewList[index].rating,
                                reviewContents:
                                    sentReviewList[index].reviewContent,
                                dealId: sentReviewList[index].dealId,
                                dealName: sentReviewList[index].dealName!,
                                userName: sentReviewList[index].reviewToName!,
                                reliability:
                                    sentReviewList[index].reviewToReliability!,
                                createAt: sentReviewList[index]
                                    .createdAt!
                                    .substring(0, 10),
                              );
                            }),
                          )
                        : const Center(child: Text('보낸 후기가 없습니다!'))),
                Container(
                  color: ColorStyles.lightGrey,
                  // child: const Center(child: Text('후기가 없습니다!'))),
                  child: (receivedReviewList.isNotEmpty)
                      ? ListView.builder(
                          itemCount: receivedReviewList.length,
                          itemBuilder: ((context, index) {
                            return MyReviewUnit(
                              reviewPoint: receivedReviewList[index].rating,
                              reviewContents:
                                  receivedReviewList[index].reviewContent,
                              dealId: receivedReviewList[index].dealId,
                              dealName: receivedReviewList[index].dealName!,
                              userName:
                                  receivedReviewList[index].reviewFromName!,
                              reliability: receivedReviewList[index]
                                  .reviewFromReliability!,
                              createAt: receivedReviewList[index]
                                  .createdAt!
                                  .substring(0, 10),
                            );
                          }),
                        )
                      : const Center(child: Text('받은 후기가 없습니다!')),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MyReviewUnit extends StatefulWidget {
  final double reviewPoint;
  final String? reviewContents;
  final int dealId;
  final String dealName;
  final String userName;
  final double reliability;
  final String createAt;

  const MyReviewUnit({
    super.key,
    required this.reviewPoint,
    required this.reviewContents,
    required this.dealId,
    required this.dealName,
    required this.userName,
    required this.reliability,
    required this.createAt,
  });

  @override
  State<MyReviewUnit> createState() => _MyReviewUnitState();
}

class _MyReviewUnitState extends State<MyReviewUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorStyles.white,
        ),
        height: (widget.reviewContents == null) ? 130 : 220,
        child: Column(
          children: [
            TopReviewUnit(
              userName: widget.userName,
              dealTitle: widget.dealName,
              reliability: widget.reliability.toInt(),
            ),
            Container(height: 1, color: ColorStyles.lightGrey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Icon(
                          Icons.star,
                          color: (index <= widget.reviewPoint.toInt() - 1)
                              ? ColorStyles.mainColor
                              : ColorStyles.grey,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.createAt,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            (widget.reviewContents != null)
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorStyles.lightGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          child: Text(widget.reviewContents!),
                        ),
                      ),
                    ),
                  )
                : Container(height: 1),
          ],
        ),
      ),
    );
  }
}

class TopReviewUnit extends StatelessWidget {
  final String userName;
  final String dealTitle;
  final int reliability;
  const TopReviewUnit(
      {super.key,
      required this.userName,
      required this.dealTitle,
      required this.reliability});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dealTitle,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 65,
            height: 50,
            child: Column(
              children: [
                Container(
                  child: FractionallySizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('신뢰도 ${reliability.toString()}',
                            style: const TextStyle(
                              color: ColorStyles.mainColor,
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ),
                ),
                CustomProgressBar(
                  paddingHorizontal: 2,
                  currentPercent: reliability.toDouble(),
                  maxPercent: 100,
                  lineHeight: 8,
                  firstColor: ColorStyles.mainColor,
                  secondColor: ColorStyles.mainColor,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
