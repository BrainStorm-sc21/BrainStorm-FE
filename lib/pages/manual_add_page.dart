import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 수동 추가 화면
class ManualAddPage extends StatefulWidget {
  const ManualAddPage({Key? key}) : super(key: key);

  @override
  State<ManualAddPage> createState() => _ManualAddPageState();
}

class _ManualAddPageState extends State<ManualAddPage> {
  // Food 모델 인스턴스 생성
  late Food food;
  // 수량 입력란에 실제로 표시되는 text를 갖는 컨트롤러
  late final TextEditingController _stockStringController =
      TextEditingController();
  // 수량 입력란 focus가 컨트롤러에 의해 꼬이지 않도록 focus를 고정해주는 focusNode
  late final FocusNode _stockFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // food 인스턴스 초기화
    food = Food(
      name: '',
      storage: '냉장',
      stock: 1,
      expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
    );
    // 수량 입력란에 stock 값이 표시되게 함
    _stockStringController.text = food.stock.toString();
  }

  @override
  void dispose() {
    _stockStringController.dispose();
    _stockFocusNode.dispose();
    super.dispose();
  }

  void setName(String value) => setState(() => food.name = value);
  void setStorage(String value) => setState(() => food.storage = value);
  void setStock(num value) => setState(() => food.stock = value);
  void setExpireDate(DateTime value) => setState(() => food.expireDate = value);
  // 수량 입력란에 stock 값이 표시되도록 set state
  void updateControllerText() =>
      setState(() => _stockStringController.text = food.stock.toString());

  @override
  Widget build(BuildContext context) {
    // 구분선
    var divider = Column(
      children: [
        const SizedBox(height: 10),
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 10),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AddFoodLayout(
        title: '식품 등록',
        containerColor: Colors.white,
        body: Column(
          children: [
            FoodName(setName: setName), // 식료품 이름 입력
            const SizedBox(height: 30), // 여백
            FoodStorage(
                storage: food.storage, setStorage: setStorage), // 식료품 보관장소 선택
            divider,
            FoodStock(
                stock: food.stock,
                setStock: setStock,
                controller: _stockStringController,
                updateControllerText: updateControllerText,
                focusNode: _stockFocusNode), // 식료품 수량 조절
            divider,
            FoodExpireDate(
                expireDate: food.expireDate,
                setExpireDate: setExpireDate), // 식료품 소비기한 입력
          ],
        ),
        onPressedAddButton: saveFoodInfo,
      ),
    );
  }

  // 입력한 식료품 정보를 DB에 저장하는 함수
  void saveFoodInfo() {
    if (food.isFoodValid() == false) {
      return;
    }
    debugPrint('${food.toJson()}');
    // 추후 DB에 저장하는 로직 구현 필요
  }
}

// 식료품 이름
class FoodName extends StatefulWidget {
  final void Function(String value) setName;
  const FoodName({super.key, required this.setName});

  @override
  State<FoodName> createState() => _FoodNameState();
}

class _FoodNameState extends State<FoodName> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: '식품 이름을 입력하세요',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: Color.fromRGBO(35, 204, 135, 1.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: Color.fromRGBO(35, 204, 135, 1.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.redAccent.shade700,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.redAccent.shade700,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '값을 입력해주세요.';
          } else if (value.startsWith(' ')) {
            return '올바른 값을 입력해주세요.';
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.always,
        onChanged: (value) => widget.setName(value),
        onTapOutside: (event) => FocusScope.of(context).unfocus(), // 키보드 숨김
      ),
    );
  }
}

// 식료품 보관장소
class FoodStorage extends StatelessWidget {
  final String storage;
  final void Function(String value) setStorage;
  FoodStorage({super.key, required this.setStorage, required this.storage});

  final List<String> _storages = ['냉장', '냉동', '실온']; // 보관장소 선택을 위한 list

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // "보관장소" title 및 보관장소 추천 description
        const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("보관장소"),
          Spacer(),
          // 보관장소 추천 description: 추후 추천 가능한 식료품에만 적용할 수 있도록 수정 필요
          Row(
            children: [
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
            ],
          ),
        ]),
        const SizedBox(height: 10), // 여백
        // 보관장소 선택 버튼 (냉장/냉동/실온)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(3, (index) {
            return RoundedOutlinedButton(
              text: _storages[index],
              onPressed: () => setStorage(_storages[index]),
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
      ],
    );
  }
}

// 식료품 수량
class FoodStock extends StatelessWidget {
  final num stock;
  final void Function(num value) setStock;
  final TextEditingController controller;
  final void Function() updateControllerText;
  final FocusNode focusNode;

  const FoodStock(
      {Key? key,
      required this.stock,
      required this.setStock,
      required this.controller,
      required this.updateControllerText,
      required this.focusNode})
      : super(key: key);

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
    setStock(result);
    updateControllerText();
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
    setStock(result);
    updateControllerText();
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
          ),
          // 수량 표시 및 입력란
          SizedBox(
            width: 40,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              focusNode: focusNode,
              // 입력란에 실제로 표시되는 값: controller.text
              controller: controller,
              // 입력란 클릭 시, 숫자 키보드 표시
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              // 0~999, x.y 꼴의 실수만 입력 가능 (ex. 0.0~9.9, 0~999, 10.~99.),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d)\d{0,2}\.?\d{0,1}')),
                LengthLimitingTextInputFormatter(
                    StockRange.maxStock.toString().length),
              ],
              onChanged: (value) {
                if (value.isNotEmpty && num.parse(value) != 0) {
                  setStock(num.parse(value));
                }
              },
              // 입력 완료 시 stock 값 저장 및 표시되는 text 업데이트
              onSubmitted: (value) {
                if (value.isNotEmpty && num.parse(value) != 0) {
                  setStock(num.parse(value));
                } else {
                  updateControllerText();
                }
              },
              onTapOutside: (event) {
                // textField 값이 null 또는 0인 경우, 입력되기 이전 값으로 되돌림
                if (controller.text != '$stock') {
                  updateControllerText();
                }
                FocusScope.of(context).unfocus(); // 키보드 숨김
              },
            ),
          ),
          // 수량 더하기
          IconButton(
            color: Colors.grey.shade400,
            onPressed: increaseStock,
            icon: const Icon(Icons.add),
          ),
        ]),
      ],
    );
  }
}

// 식료품 소비기한
class FoodExpireDate extends StatelessWidget {
  final DateTime expireDate;
  final void Function(DateTime value) setExpireDate;
  const FoodExpireDate({
    super.key,
    required this.expireDate,
    required this.setExpireDate,
  });

// cupertino 날짜 선택기를 하단에 모달로 띄우는 메서드
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
              minimumYear: 2020,
              maximumYear: 2025,
              initialDateTime: expireDate,
              onDateTimeChanged: (value) => setExpireDate(value),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('소비기한'),
        const Spacer(),
        // 소비기한 표시 및 선택 버튼
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
      ],
    );
  }
}
