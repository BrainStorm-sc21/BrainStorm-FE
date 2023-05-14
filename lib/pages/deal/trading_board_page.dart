import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class TradingBoard extends StatelessWidget {
  const TradingBoard({super.key});

  final Map dealColors = const {
    '공구': ColorStyles.groupBuyColor,
    '교환': ColorStyles.exchangColor,
    '나눔': ColorStyles.shareColor
  };

  final List<Map<String, String>> post = const [
    {
      "name": "감자 공동구매 하실 분!",
      "distance": "150M",
      "dealType": "공구",
      "imgUrl":
          "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcR1M89lNmXLBltfEc5TQZJSpcqvZ36vvZyZfpP98EFh-i4Q9X8S8woN6El91b1pZ5Sw",
      "time": "30분 전"
    },
    {
      "name": "양파 나눔해요~",
      "distance": "400M",
      "dealType": "교환",
      "imgUrl":
          "https://i.namu.wiki/i/qTfdtopPV7GKQ0YmjVsHxythtmlSQ35OppjcjwJgHJoLVXzx5iCZRFHaq-mXoTR5cl-j2X4SQm1xvyj2hhxBEw.webp",
      "time": "1시간 전"
    },
    {
      "name": "이천 쌀 공구하실 분 구합니다!!!",
      "distance": "1.2KM",
      "dealType": "나눔",
      "imgUrl": "https://www.newspeak.kr/news/photo/202209/435707_284048_3504.jpg",
      "time": "2시간 전"
    },
    {
      "name": "사과랑 바나나 교환해요",
      "distance": "750M",
      "dealType": "공구",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlxKlz8H0tHG-DpyUhBOOo6wpGw_NnEYPMLDjrfVA3aSPyIdCfmzS_fzOcnj0seChhGo&usqp=CAU",
      "time": "4시간 전"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        final item = post[index % post.length];
        final name = item["name"] ?? "name";
        final distance = item["distance"] ?? "distance";
        final dealType = item["dealType"] ?? "dealType";
        final time = item["time"] ?? "time";
        final imgUrl = item["imgUrl"] ?? "";
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 35,
                height: 20,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: dealColors[dealType],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  dealType,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, color: ColorStyles.white),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 270,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500, height: 1)),
                      //const Spacer(),
                      Text(time,
                          style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1)),
                    ]),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    distance,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
