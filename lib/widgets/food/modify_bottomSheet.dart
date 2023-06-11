import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/manual_add_page.dart';
import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/food/foodAll.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyFoodBottomSheet extends StatefulWidget {
  final Food modifyFood;
  final int userId;
  const ModifyFoodBottomSheet({super.key, required this.modifyFood, required this.userId});

  @override
  State<ModifyFoodBottomSheet> createState() => _ModifyFoodBottomSheetState();
}

class _ModifyFoodBottomSheetState extends State<ModifyFoodBottomSheet> {
  final FoodListController _foodListController = Get.find<FoodListController>();

  void setName(String value) => setState(() {
        widget.modifyFood.foodName = value;
      });

  void setStock(num value, {int? index}) => setState(() {
        widget.modifyFood.stock = value;
      });
  void setStorage(String value) => setState(() {
        widget.modifyFood.storageWay = value;
      });
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => widget.modifyFood.expireDate = value);

  var divider = Column(
    children: [
      const SizedBox(height: 10),
      Divider(
        thickness: 1,
        height: 1,
        color: ColorStyles.lightGrey,
      ),
      const SizedBox(height: 10),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FoodName(
              setName: setName,
              foodName: widget.modifyFood.foodName,
            ),
            const SizedBox(height: 30),
            FoodStorageDropdown(storage: widget.modifyFood.storageWay, setStorage: setStorage),
            divider,
            FoodStockButton(stock: widget.modifyFood.stock, setStock: setStock),
            divider,
            FoodExpireDate(
              expireDate: widget.modifyFood.expireDate,
              setExpireDate: setExpireDate,
            ),
            const SizedBox(height: 30),
            RoundedOutlinedButton(
              text: '수정하기',
              width: double.infinity,
              onPressed: () {
                _foodListController.modifyFoodInfo(widget.userId, widget.modifyFood);
                Navigator.of(context).pop();
                showToast('식료품이 수정되었습니다');
              },
              foregroundColor: ColorStyles.white,
              backgroundColor: ColorStyles.mainColor,
              borderColor: ColorStyles.mainColor,
              fontSize: 18,
            ),
            const SizedBox(height: 10),
            RoundedOutlinedButton(
              text: '취소하기',
              width: double.infinity,
              onPressed: () => Navigator.of(context).pop(),
              foregroundColor: ColorStyles.mainColor,
              backgroundColor: ColorStyles.white,
              borderColor: ColorStyles.mainColor,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
