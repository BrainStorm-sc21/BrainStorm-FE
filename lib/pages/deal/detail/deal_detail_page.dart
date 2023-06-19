import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/providers/chat_controller.dart';
import 'package:brainstorm_meokjang/providers/deal_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/deal_detail/deal_detail_widgets.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class DealDetailPage extends StatefulWidget {
  final int userId;
  final Deal deal;
  final bool isMine;

  const DealDetailPage({
    super.key,
    required this.userId,
    required this.deal,
    required this.isMine,
  });

  @override
  State<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  final DealListController _dealListController = Get.put(DealListController());

  List<String> imageList = [];
  late bool isClickModifyButton = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());
  late Room? chatRoom;

  void initEditingController() {
    _nameController.text = widget.deal.dealName;
    _contentsController.text = widget.deal.dealContent;
  }

  void setImageList() {
    if (widget.deal.dealImage1 != null) {
      imageList.add(widget.deal.dealImage1!);
    }
    if (widget.deal.dealImage2 != null) {
      imageList.add(widget.deal.dealImage2!);
    }
    if (widget.deal.dealImage3 != null) {
      imageList.add(widget.deal.dealImage3!);
    }
    if (widget.deal.dealImage4 != null) {
      imageList.add(widget.deal.dealImage4!);
    }
  }

  void modifyDeal(int dealId, Deal deal) async {
    String imageBaseURL =
        'https://objectstorage.ap-chuncheon-1.oraclecloud.com/p/mOKCBwWiKyiyIkbN0aqY5KV5_K2-OzTt4V7feFotQqm3epdOyNO0VUJdtMUsv3Jq/n/axzkif4tbwyu/b/file-bucket/o/';
    print('modifyDeal 호출');
    print('userId: ${deal.userId}');
    print('dealType: ${deal.dealType}');
    print('dealName: ${deal.dealName}');
    print('dealContent: ${deal.dealContent}');
    print('image1: ${deal.dealImage1?.replaceFirst(imageBaseURL, "")}');
    print('image2: ${deal.dealImage2?.replaceFirst(imageBaseURL, "")}');
    print('image3: ${deal.dealImage3?.replaceFirst(imageBaseURL, "")}');
    print('image4: ${deal.dealImage4?.replaceFirst(imageBaseURL, "")}');

    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10)
      ..contentType = 'multipart/form-data';

    final FormData formData = FormData.fromMap({
      'userId': deal.userId,
      'dealType': deal.dealType,
      'dealName': deal.dealName,
      'dealContent': deal.dealContent,
      'image1': deal.dealImage1 == null
          ? null
          : MultipartFile.fromFileSync(
              deal.dealImage1!.replaceFirst(imageBaseURL, "")),
      'image2': deal.dealImage2 == null
          ? null
          : MultipartFile.fromFileSync(
              deal.dealImage2!.replaceFirst(imageBaseURL, "")),
      'image3': deal.dealImage3 == null
          ? null
          : MultipartFile.fromFileSync(
              deal.dealImage3!.replaceFirst(imageBaseURL, "")),
      'image4': deal.dealImage4 == null
          ? null
          : MultipartFile.fromFileSync(
              deal.dealImage4!.replaceFirst(imageBaseURL, "")),
    });

    try {
      final resp = await dio.put("/deal/$dealId", data: formData);
      print("modify Status: ${resp.statusCode}");

      if (resp.data['status'] == 200) {
        print('수정 성공!');
      } else {
        print('??');
      }
    } catch (e) {
      Exception(e);
      print(e);
    } finally {
      dio.close();
    }
  }

  void findChatRoom() {
    for (Room roomItem in _chatController.roomList) {
      if (roomItem.dealInfo.dealId == widget.deal.dealId) {
        setState(() {
          chatRoom = roomItem;
          return;
        });
      }
    }
    setState(() {
      chatRoom = null;
    });
  }

  @override
  void initState() {
    super.initState();
    setImageList();
    initEditingController();
    findChatRoom();
    print(widget.deal.dealImage1);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.3,
                color: Colors.grey[300],
                child: (imageList.isEmpty)
                    ? null
                    : PageView.builder(
                        controller: PageController(initialPage: 0),
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Image.network(
                            imageList[index],
                            fit: BoxFit.fill,
                          ));
                        },
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            width: width,
            height: (imageList.isEmpty) ? height * 0.87 : height * 0.72,
            child: Column(
              children: [
                TopPostUnit(
                  nickname: widget.deal.userName!,
                  reliability: widget.deal.reliability!,
                  distance: '${widget.deal.distance?.round()}m',
                  isMine: widget.isMine,
                  dealId: widget.deal.dealId!,
                  reviewFrom: widget.deal.userId,
                  deal: widget.deal,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 10),
                  child: Container(
                    color: Colors.grey[350],
                    height: 0.5,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: firstPostUnit(
                    deal: widget.deal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: AbsorbPointer(
                        absorbing: !isClickModifyButton,
                        child: TextFormField(
                          maxLines: 8,
                          controller: _contentsController,
                          decoration: InputDecoration(
                            enabled: isClickModifyButton,
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(fontSize: 12),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // child: Text(widget.deal.dealContent),
                    ),
                  ),
                ),
                const Spacer(),
                (widget.isMine)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 40),
                        child: Column(
                          children: [
                            RoundedOutlinedButton(
                                width: double.infinity,
                                height: 40,
                                text: '수정하기',
                                onPressed: () {
                                  print('수정하기 버튼 클릭');
                                  setState(() {
                                    isClickModifyButton = !isClickModifyButton;
                                  });
                                  print(isClickModifyButton);
                                },
                                backgroundColor: ColorStyles.mainColor,
                                foregroundColor: ColorStyles.white,
                                borderColor: ColorStyles.mainColor),
                            const SizedBox(height: 10),
                            RoundedOutlinedButton(
                                width: double.infinity,
                                height: 40,
                                text: '삭제하기',
                                onPressed: () {
                                  print('삭제하기 버튼 클릭');
                                  showDeleteDealDialog();
                                  print(isClickModifyButton);
                                },
                                backgroundColor: ColorStyles.white,
                                foregroundColor: ColorStyles.mainColor,
                                borderColor: ColorStyles.mainColor)
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 40),
                        child: RoundedOutlinedButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatDetailPage(
                                senderId: widget.userId,
                                receiverId: widget.deal.userId,
                                deal: widget.deal,
                                room: chatRoom,
                                receiverName: widget.deal.userName == null
                                    ? '(알 수 없음)'
                                    : widget.deal.userName!,
                              ),
                            ),
                          ),
                          text: '채팅하기',
                          width: double.infinity,
                          height: 40,
                          backgroundColor: ColorStyles.mainColor,
                          foregroundColor: ColorStyles.white,
                          borderColor: ColorStyles.mainColor,
                        ),
                      )
              ],
            ),
          ),
        ),
        (isClickModifyButton)
            ? Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Container(
                  child: Column(
                    children: [
                      RoundedOutlinedButton(
                          width: double.infinity,
                          height: 40,
                          text: '확인',
                          onPressed: () {
                            showModifyDealDialog();
                          },
                          backgroundColor: ColorStyles.mainColor,
                          foregroundColor: ColorStyles.white,
                          borderColor: ColorStyles.mainColor),
                      const SizedBox(height: 10),
                      RoundedOutlinedButton(
                          width: double.infinity,
                          height: 40,
                          text: '취소',
                          onPressed: () {
                            initEditingController();
                            print('취소 버튼 클릭');
                            setState(() {
                              isClickModifyButton = !isClickModifyButton;
                            });
                            print(isClickModifyButton);
                          },
                          backgroundColor: ColorStyles.white,
                          foregroundColor: ColorStyles.mainColor,
                          borderColor: ColorStyles.mainColor)
                    ],
                  ),
                ),
              )
            : Container(),
        Positioned(
          left: 15,
          top: 30,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              print('버튼 클릭');
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    );
  }

  //Regrigerator의 다이얼로그를 활용 - 삭제 버튼 클릭 시
  void showDeleteDealDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("정말로 삭제하시겠습니까?"),
            actions: [
              // 취소 버튼
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("취소"),
              ),
              // 확인 버튼
              TextButton(
                onPressed: () {
                  _dealListController.deleteDeal(widget.deal);
                  //deleteDeal(widget.deal.dealId!);
                  showToast('게시글이 삭제되었습니다');
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AppPagesContainer(
                  //         index: AppPagesNumber.deal, userId: widget.userId),
                  //   ),
                  //   (route) => false,
                  // );
                  Navigator.pop(context);
                },
                child: const Text(
                  "확인",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          );
        });
  }

  void showModifyDealDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("게시글 정보를 수정하시겠습니까?"),
            actions: [
              // 취소 버튼
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("취소"),
              ),
              // 확인 버튼
              TextButton(
                onPressed: () {
                  widget.deal.dealContent = _contentsController.text;
                  modifyDeal(widget.deal.dealId!, widget.deal);
                  print('deal의 컨텐츠가 ${widget.deal.dealContent}로 바뀌었습니다.');
                  showToast('게시글이 수정되었습니다');
                  Navigator.pop(context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AppPagesContainer(
                  //         index: AppPagesNumber.deal, userId: widget.userId),
                  //   ),
                  //   (route) => false,
                  // );
                },
                child: const Text(
                  "확인",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          );
        });
  }
}

class ModifyStatusButtons extends StatefulWidget {
  const ModifyStatusButtons({super.key});

  @override
  State<ModifyStatusButtons> createState() => _ModifyStatusButtonsState();
}

class _ModifyStatusButtonsState extends State<ModifyStatusButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RoundedOutlinedButton(
              width: double.infinity,
              height: 40,
              text: '확인',
              onPressed: () {},
              backgroundColor: ColorStyles.mainColor,
              foregroundColor: ColorStyles.white,
              borderColor: ColorStyles.mainColor),
          const SizedBox(height: 10),
          RoundedOutlinedButton(
              width: double.infinity,
              height: 40,
              text: '취소',
              onPressed: () {},
              backgroundColor: ColorStyles.white,
              foregroundColor: ColorStyles.mainColor,
              borderColor: ColorStyles.mainColor)
        ],
      ),
    );
  }
}
