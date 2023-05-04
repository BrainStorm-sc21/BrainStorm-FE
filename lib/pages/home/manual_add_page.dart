import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
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
      foodId: 1,
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
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => food.expireDate = value);
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
          color: ColorStyles.lightGrey,
        ),
        const SizedBox(height: 10),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AddFoodLayout(
        title: '식품 등록',
        containerColor: ColorStyles.white,
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
              color: ColorStyles.mainColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: ColorStyles.mainColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: ColorStyles.errorRed,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 2,
              color: ColorStyles.errorRed,
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
        // "보관장소" title
        const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("보관장소"),
          Spacer(),
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
                  ? ColorStyles.mainColor
                  : ColorStyles.white,
              foregroundColor: storage == _storages[index]
                  ? ColorStyles.white
                  : ColorStyles.black,
              borderColor: ColorStyles.mainColor,
            );
          }),
        ),
      ],
    );
  }
}
