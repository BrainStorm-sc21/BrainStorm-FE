import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: ColorStyles.mainColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: Text(
                    "제목",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 20,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "15 글자 이내로 입력해주세요",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpirationDateInput extends StatefulWidget {
  const ExpirationDateInput({super.key});

  @override
  State<ExpirationDateInput> createState() => _ExpirationDateInputState();
}

class _ExpirationDateInputState extends State<ExpirationDateInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "소비기한",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          // FoodExpireDate(
          //     expireDate: DateTime.now(), setExpireDate: DateTime.now()),
          TextFormField(
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumOfPeopleInput extends StatefulWidget {
  const NumOfPeopleInput({super.key});

  @override
  State<NumOfPeopleInput> createState() => _NumOfPeopleInputState();
}

class _NumOfPeopleInputState extends State<NumOfPeopleInput> {
  final _values = ['선택', '2명', '3명', '4명', '5명', '6명', '7명', '8명', '9명', '10명'];
  String _selectedValue = '선택';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "인원 수",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 100,
          height: 58,
          child: DropdownButtonFormField(
            value: _selectedValue,
            items: _values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "상세설명",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
            maxLines: 8,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("취소"),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("등록"),
          ),
        ),
      ],
    );
  }
}
