import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          const Text("타이틀 이미지"),
          Column(
            children: const [
              Text("제목"),
              Text("타이틀을 입력하세요."),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpirationDateInput extends StatelessWidget {
  const ExpirationDateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            "소비기한",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
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

class NumOfPeopleInput extends StatelessWidget {
  const NumOfPeopleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            "인원 수",
            style: TextStyle(color: Colors.grey),
          ),
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
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

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            "상세설명",
            style: TextStyle(color: Colors.grey),
          ),
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
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
