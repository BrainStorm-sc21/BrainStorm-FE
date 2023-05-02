import 'package:flutter/material.dart';

class FoodStorageDropdown extends StatefulWidget {
  const FoodStorageDropdown({Key? key}) : super(key: key);

  @override
  State<FoodStorageDropdown> createState() => _FoodStorageDropdown();
}

class _FoodStorageDropdown extends State<FoodStorageDropdown> {
  final _storages = ['냉장', '냉동', '실온'];
  String? _selectedStorage = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedStorage = _storages[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('보관방법'),
        const Spacer(),
        // 드롭다운
        DropdownButton(
          value: _selectedStorage,
          items: _storages
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedStorage = value!;
            });
          },
        ),
      ],
    );
  }
}
