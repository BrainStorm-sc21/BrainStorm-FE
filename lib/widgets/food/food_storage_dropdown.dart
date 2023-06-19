import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class FoodStorageDropdown extends StatelessWidget {
  final _storages = ['냉장', '냉동', '실온'];

  final String storage;
  final void Function(String value) setStorage;
  FoodStorageDropdown(
      {super.key, required this.storage, required this.setStorage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('보관방법'),
        const Spacer(),
        DropdownButton(
          value: storage,
          items: _storages
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setStorage(value!);
          },
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: 20,
          underline: Container(),
          elevation: 2,
          dropdownColor: ColorStyles.white,
        ),
      ],
    );
  }
}
