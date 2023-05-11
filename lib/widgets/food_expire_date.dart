// 식료품 소비기한
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodExpireDate extends StatelessWidget {
  final DateTime expireDate;
  final int? index;
  final void Function(DateTime value, {int? index}) setExpireDate;
  const FoodExpireDate({
    super.key,
    required this.expireDate,
    required this.setExpireDate,
    this.index,
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
