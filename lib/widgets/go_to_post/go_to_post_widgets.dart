import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
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
                      color: widget.dealColors[widget.deal.dealType]),
                  child: Center(
                    child: Text(
                      widget.deal.dealType.toString(),
                      style: const TextStyle(fontSize: 11, color: ColorStyles.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Text(
                      widget.deal.dealName,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600, color: ColorStyles.black),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.deal.createdAt.toString(),
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
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text('삼식이 네끼',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: ColorStyles.black)),
                ),
                Text(widget.deal.distance.toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                widget.deal.dealContent,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
