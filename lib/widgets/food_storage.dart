import 'package:flutter/material.dart';

class FoodStorageDropdown extends StatelessWidget {
  final _storages = ['냉장', '냉동', '실온'];
  //String _selectedStorage = '';

  final String storage;
  final int index;
  final void Function(int index, String value) setStorage;
  FoodStorageDropdown(
      {super.key, required this.index, required this.storage, required this.setStorage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('보관방법'),
        const Spacer(),
        // 드롭다운
        DropdownButton(
            value: storage,
            items: _storages
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setStorage(index, value!);
            }),
      ],
    );
  }
}
