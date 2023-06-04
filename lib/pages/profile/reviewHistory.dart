import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class ReviewHistoryPage extends StatefulWidget {
  final int userId;
  const ReviewHistoryPage({super.key, required this.userId});

  @override
  State<ReviewHistoryPage> createState() => _ReviewHistoryPageState();
}

class _ReviewHistoryPageState extends State<ReviewHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
          color: ColorStyles.lightGrey,
          // child: const Center(child: Text('후기가 없습니다!'))),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return MyReviewUnit(
                reviewPoint: index,
              );
            }),
          )),
    );
  }
}

class MyReviewUnit extends StatefulWidget {
  final int reviewPoint;
  const MyReviewUnit({super.key, required this.reviewPoint});

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
        height: 150,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Icon(
                      Icons.star,
                      color: (index <= widget.reviewPoint)
                          ? ColorStyles.mainColor
                          : ColorStyles.grey,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorStyles.lightGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${widget.reviewPoint + 1}번째 후기입니다. 별점은 ${widget.reviewPoint + 1}점 입니다.'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
