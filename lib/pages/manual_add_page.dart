import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class ManualAddPage extends StatelessWidget {
  const ManualAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // 날짜 선택기 및 달력에 표시되는 언어 세팅을 위한 localization
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ko', 'KR'),
          Locale('en', ''),
        ],
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AddFoodLayout(
            title: '식품 등록',
            containerColor: Colors.white,
            child: FoodInfo(),
          ),
        ));
  }
}

class FoodInfo extends StatefulWidget {
  const FoodInfo({super.key});

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  // 식료품 정보(이름, 보관장소, 수량, 소비기한)를 나타내는 변수
  String name = '';
  String storage = '냉장';
  num stock = 1;
  DateTime expireDate = DateFormat('yyyy-MM-dd').parse('${DateTime.now()}');

  final List<String> _storages = ['냉장', '냉동', '실온']; // 보관장소 선택을 위한 list
  final _formKey = GlobalKey<FormState>(); // 수량 입력을 위한 formkey

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 식료품 이름 입력
        TextField(
          decoration: const InputDecoration(
            hintText: '식품 이름을 입력하세요',
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Color.fromRGBO(35, 204, 135, 1.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Color.fromRGBO(35, 204, 135, 1.0),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        const SizedBox(height: 30), // 여백
        // 보관 장소 선택
        const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("보관장소"),
          Spacer(),

          /// 보관 장소 추천 description
          /// 추후 DB에 저장된 추천 가능 식료품에만 적용할 수 있도록 수정 필요
          Center(
            child: Icon(
              Icons.info_outline,
              color: Colors.amber,
              size: 18,
            ),
          ),
          SizedBox(width: 5), // 여백
          Text(
            "냉장 보관을 추천해요",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
            ),
          ),
        ]),
        const SizedBox(height: 10), // 여백
        // 냉장/냉동/실온 선택 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(3, (index) {
            return RoundedOutlinedButton(
              text: _storages[index],
              onPressed: () => setState(() => storage = _storages[index]),
              width: MediaQuery.of(context).size.width / 3.0 - 50,
              backgroundColor: storage == _storages[index]
                  ? const Color.fromRGBO(35, 204, 135, 1.0)
                  : Colors.white,
              foregroundColor:
                  storage == _storages[index] ? Colors.white : Colors.black,
              borderColor: const Color.fromRGBO(35, 204, 135, 1.0),
            );
          }),
        ),
        const SizedBox(height: 10), // 여백
        // 구분선
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 10), // 여백
        // 수량 조절
        Row(children: [
          const Text("수량"),
          const Spacer(),
          Column(
            children: [
              Row(children: [
                // 수량 빼기
                IconButton(
                  color: Colors.grey.shade400,
                  onPressed: decrementStock,
                  icon: const Icon(Icons.remove),
                ),
                // 수량 표시 및 입력란
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: 40,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      // 입력란에 stock 변수의 값을 표시
                      controller: TextEditingController(text: '$stock'),
                      // 입력란 클릭 시, 숫자 키보드 표시
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      // 0~999, x.y 꼴의 실수만 입력 가능 (ex. 0.0~9.9, 0~999, 10.~99.),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d)\d{0,2}\.?\d{0,1}')),
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onSaved: (value) {
                        setState(() => stock = num.parse(value!));
                        value = '$stock';
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      onTapOutside: (event) {
                        // 입력란 바깥 클릭 시, 값을 변수에 저장
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        // 입력란 바깥 클릭 시, 키보드 숨김
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
                // 수량 더하기
                IconButton(
                  color: Colors.grey.shade400,
                  onPressed: incrementStock,
                  icon: const Icon(Icons.add),
                ),
              ]),
            ],
          ),
        ]),
        const SizedBox(height: 10), // 여백
        // 구분선
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 10), // 여백
        // 소비기한 입력
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('소비기한'),
            const Spacer(),
            // 소비기한 표시 및 선택 버튼(cupertino)
            TextButton(
              child: Text(
                '${expireDate.year}. ${expireDate.month}. ${expireDate.day}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () async => await showDateModalPopup(context),
            ),
            // 달력 팝업 버튼
            IconButton(
              icon: const Icon(Icons.date_range_rounded),
              iconSize: 18,
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: expireDate,
                  firstDate: DateTime(expireDate.year - 5),
                  lastDate: DateTime(expireDate.year + 100, 12, 31),
                );
                if (selectedDate != null) {
                  setState(() => expireDate = selectedDate);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

// cupertino 날짜 선택기를 bottom 모달로 띄움
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
              minimumYear: expireDate.year - 100,
              maximumYear: expireDate.year + 100,
              initialDateTime: expireDate,
              onDateTimeChanged: (value) => setState(() => expireDate = value),
            ),
          ),
        ],
      ),
    );
  }

  void decrementStock() {
    if (stock <= 0.5) {
      return;
    } else if (stock <= 2) {
      setState(() => stock = num.parse((stock - 0.5).toStringAsFixed(1)));
    } else {
      setState(() => stock--);
    }
    debugPrint('$stock');
  }

  void incrementStock() {
    if (stock < 2) {
      setState(() => stock += 0.5);
    } else {
      setState(() => stock++);
    }
  }
}
