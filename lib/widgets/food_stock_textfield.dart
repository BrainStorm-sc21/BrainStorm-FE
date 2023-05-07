// 식료품 수량
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodStockTextfield extends StatelessWidget {
  final num stock;
  final void Function(num value) setStock;
  final TextEditingController controller;
  final void Function() updateControllerText;
  final FocusNode focusNode;

  const FoodStockTextfield(
      {Key? key,
      required this.stock,
      required this.setStock,
      required this.controller,
      required this.updateControllerText,
      required this.focusNode})
      : super(key: key);

  void decreaseStock() {
    if (stock <= StockRange.minStock) return;

    num result = 0;
    if (0.1 < stock && stock <= 0.5) {
      result = num.parse((stock - 0.1).toStringAsFixed(1));
    } else if (0.5 < stock && stock <= 1) {
      result = 0.5;
    } else if (1 < stock && stock <= 1.5) {
      result = 1;
    } else if (1.5 < stock && stock <= 2) {
      result = 1.5;
    } else {
      result = (stock - 1).ceil();
    }
    setStock(result);
    updateControllerText();
  }

  void increaseStock() {
    if (stock >= StockRange.maxStock) return;

    num result = 0;
    if (0.1 <= stock && stock < 0.5) {
      result = 0.5;
    } else if (0.5 <= stock && stock < 1) {
      result = 1;
    } else if (1 <= stock && stock < 1.5) {
      result = 1.5;
    } else {
      result = (stock + 1).floor();
    }
    setStock(result);
    updateControllerText();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("수량"),
        const Spacer(),
        Row(children: [
          // 수량 빼기
          IconButton(
            color: Colors.grey.shade400,
            onPressed: () => decreaseStock(),
            icon: const Icon(Icons.remove),
          ),
          // 수량 표시 및 입력란
          SizedBox(
            width: 40,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              focusNode: focusNode,
              // 입력란에 실제로 표시되는 값: controller.text
              controller: controller,
              // 입력란 클릭 시, 숫자 키보드 표시
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              // 0~999, x.y 꼴의 실수만 입력 가능 (ex. 0.0~9.9, 0~999, 10.~99.),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d)\d{0,2}\.?\d{0,1}')),
                LengthLimitingTextInputFormatter(
                    StockRange.maxStock.toString().length),
              ],
              onChanged: (value) {
                if (value.isNotEmpty && num.parse(value) != 0) {
                  setStock(num.parse(value));
                }
              },
              // 입력 완료 시 stock 값 저장 및 표시되는 text 업데이트
              onSubmitted: (value) {
                if (value.isNotEmpty && num.parse(value) != 0) {
                  setStock(num.parse(value));
                } else {
                  updateControllerText();
                }
              },
              onTapOutside: (event) {
                // textField 값이 null 또는 0인 경우, 입력되기 이전 값으로 되돌림
                if (controller.text != '$stock') {
                  updateControllerText();
                }
                FocusScope.of(context).unfocus(); // 키보드 숨김
              },
            ),
          ),
          // 수량 더하기
          IconButton(
            color: Colors.grey.shade400,
            onPressed: increaseStock,
            icon: const Icon(Icons.add),
          ),
        ]),
      ],
    );
  }
}
