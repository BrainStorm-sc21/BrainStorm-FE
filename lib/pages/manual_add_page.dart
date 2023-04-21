import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ManualAddPage extends StatelessWidget {
  const ManualAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale('en', ''),
        ],
        home:
            /*Scaffold(
        appBar: AppBar(
          title: const Text(
            "식품 등록",
          ),
          centerTitle: true,
        ),
        body: const FoodInfo(),
      ),*/
            Scaffold(
          body: Stack(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(35, 204, 135, 1.0),
                    Colors.cyan
                  ])),
                  child: const Center(
                    child: Text(
                      '식품 등록',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: const FoodInfo(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ],
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

  List<String> storageList = ['냉장', '냉동', '실온'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 식료품 이름 입력
        TextField(
          decoration: const InputDecoration(hintText: '식품 이름을 입력하세요'),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        // 보관 장소 선택
        const Row(children: [
          Text("보관 장소"),
          Spacer(),
          Icon(Icons.question_mark),
          Text("OO 보관을 추천해요"),
        ]),
        Wrap(
          spacing: 5.0,
          children: List<Widget>.generate(3, (index) {
            return ChoiceChip(
              label: Text(storageList[index]),
              selected: storage == storageList[index],
              onSelected: (selected) {
                setState(() {
                  storage = storageList[index];
                });
              },
            );
          }),
        ),
        // 구분선
        const Divider(
          thickness: 1,
          height: 1,
        ),
        // 수량 조절
        Row(children: [
          const Text("수량"),
          const Spacer(),
          Column(
            children: [
              Row(children: [
                IconButton(
                    onPressed: decrementStock, icon: const Icon(Icons.remove)),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: TextEditingController(text: '$stock'),
                      textAlign: TextAlign.right,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d)\d{0,3}\.?\d{0,1}')),
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(fontSize: 0)),
                      onSaved: (value) {
                        setState(() {
                          stock = num.parse(value!);
                        });
                        value = '$stock';
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      onTapOutside: (event) {
                        // textFormField 바깥 클릭 시, state 저장
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        // textFormField 바깥 클릭 시, hide keyboard
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                    onPressed: incrementStock, icon: const Icon(Icons.add)),
              ]),
            ],
          ),
        ]),
        // 구분선
        const Divider(
          thickness: 1,
          height: 1,
        ),
        // 소비기한 입력
        Row(
          children: [
            const Text('소비기한'),
            const Spacer(),
            CupertinoButton(
              child: Text(
                  '${expireDate.year}/${expireDate.month}/${expireDate.day}'),
              onPressed: () => showDateModalPopup(context),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DatePickerDialog(
                          initialDate: expireDate,
                          firstDate: expireDate,
                          lastDate: expireDate));
                },
                icon: const Icon(Icons.date_range_rounded)),
          ],
        ),
      ],
    );
  }

  Future<dynamic> showDateModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.ymd,
                minimumYear: expireDate.year - 100,
                maximumYear: expireDate.year + 100,
                initialDateTime: expireDate,
                onDateTimeChanged: (value) =>
                    setState(() => expireDate = value),
              ),
            ),
            Row(
              children: [
                CupertinoButton(
                  child: const Text('취소'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                CupertinoButton(
                  child: const Text('완료'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
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
  }

  void incrementStock() {
    if (stock < 2) {
      setState(() => stock += 0.5);
    } else {
      setState(() => stock++);
    }
  }

  void setStock(value) {
    if (value.isNull || num.parse(value) == 0) {
      return;
    }
    setState(() {
      stock = num.parse(value);
    });
    value = '$stock';
  }
}
