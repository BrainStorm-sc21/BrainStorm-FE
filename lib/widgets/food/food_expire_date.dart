// 식료품 소비기한
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodExpireDate extends StatelessWidget {
  final DateTime expireDate;
  final int? index;
  final void Function(DateTime value, {int? index}) setExpireDate;
  final bool? isRecommended;
  const FoodExpireDate({
    super.key,
    required this.expireDate,
    required this.setExpireDate,
    this.index,
    this.isRecommended,
  });

// cupertino 날짜 선택기를 하단에 모달로 띄우는 메서드
  Future<dynamic> showDateModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            height: 160,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.ymd,
                minimumYear: 2020,
                maximumYear: 2025,
                initialDateTime: expireDate,
                onDateTimeChanged: (value) {
                  if (index == null) {
                    setExpireDate(value);
                  } else {
                    setExpireDate(value, index: index);
                  }
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('소비기한'),
        const Spacer(),
        // 추천 박스가 있으면 표시
        if (isRecommended == true) const RecommendTip() else const SizedBox(),
        // 소비기한 표시 및 선택 버튼
        TextButton(
          child: Text(
            '${expireDate.year}. ${expireDate.month}. ${expireDate.day}',
            style: const TextStyle(
              color: ColorStyles.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () async => await showDateModalPopup(context),
        ),
      ],
    );
  }
}

class RecommendTip extends StatelessWidget {
  const RecommendTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      decoration: const BoxDecoration(
        color: ColorStyles.tipBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'TIP!',
            style: TextStyle(
              color: ColorStyles.mainColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            ' 추천',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
