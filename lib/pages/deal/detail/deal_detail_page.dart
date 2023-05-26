import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/deal_detail/deal_detail_widgets.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class DealDetailPage extends StatefulWidget {
  final Deal deal;

  const DealDetailPage({
    super.key,
    required this.deal,
  });

  @override
  State<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  List<String> imageList = [];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setImageList();
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
              SizedBox(
                width: width,
                height: height * 0.3,
                child: PageView.builder(
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
              // Container(
              //   width: width,
              //   height: height * 0.3,
              //   decoration: BoxDecoration(
              //     color: ColorStyles.black,
              //     image: widget.deal.dealImage1 != null
              //         ? DecorationImage(
              //             image: NetworkImage(widget.deal.dealImage1 ?? ''),
              //             fit: BoxFit.fitWidth)
              //         : const DecorationImage(
              //             image: AssetImage('assets/images/logo.png'),
              //             fit: BoxFit.fitWidth),
              //   ),
              // ),
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
            height: height * 0.72,
            child: Column(
              children: [
                TopPostUnit(
                  distance: '${widget.deal.distance.round()}m',
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
                      padding: const EdgeInsets.all(20),
                      child: Text(widget.deal.dealContent),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: RoundedOutlinedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ChatDetailPage(
                          nickname: 'userId',
                          content: '',
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
        Positioned(
          top: 20,
          left: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorStyles.mainColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]),
    );
  }
}
