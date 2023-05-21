import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';

class firstPostUnit extends StatefulWidget {
  final Deal deal;

  final Map dealColors = {
    '공구': ColorStyles.groupBuyColor,
    '교환': ColorStyles.exchangeColor,
    '나눔': ColorStyles.shareColor
  };

  firstPostUnit({super.key, required this.deal});

  @override
  State<firstPostUnit> createState() => _firstPostUnitState();
}

class _firstPostUnitState extends State<firstPostUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 37,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: DealType.dealColors[widget.deal.dealType],
                  ),
                  child: Center(
                    child: Text(
                      DealType.dealTypeName[widget.deal.dealType],
                      style: TextStyle(
                          fontSize: 11, color: DealType.dealTextColors[widget.deal.dealType]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      widget.deal.dealName,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600, color: ColorStyles.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.deal.createdAt.toString().substring(0, 10),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class secondPostUnit extends StatefulWidget {
  final Deal deal;

  const secondPostUnit({super.key, required this.deal});

  @override
  State<secondPostUnit> createState() => _secondPostUnitState();
}

class _secondPostUnitState extends State<secondPostUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text('게시물 작성자 닉네임',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: ColorStyles.black)),
                ),
                Text(widget.deal.distance.toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1)),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    text: TextSpan(
                      text: widget.deal.dealContent,
                      style: const TextStyle(
                          color: ColorStyles.black, fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
