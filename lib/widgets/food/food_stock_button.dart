import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';

class FoodStockButton extends StatelessWidget {
  final num stock;
  final void Function(int index, num value) setStock;
  final int index;

  const FoodStockButton(
      {super.key, required this.index, required this.stock, required this.setStock});

  num convertInteger(stock) {
    if (stock == 1 || stock >= 2) {
      stock = stock.ceil();
    }
    return stock;
  }

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
    setStock(index, result);
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
    setStock(index, result);
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
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minHeight: kMinInteractiveDimension,
            ),
          ),
          const SizedBox(width: 5),
          // 수량 표시 및 입력란
          SizedBox(
            width: 30,
            child: Text(
              convertInteger(stock).toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(width: 5),
          // 수량 더하기
          IconButton(
            color: Colors.grey.shade400,
            onPressed: increaseStock,
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minHeight: kMinInteractiveDimension,
            ),
          ),
        ]),
      ],
    );
  }
}
