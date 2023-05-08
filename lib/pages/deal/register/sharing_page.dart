import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class SharingPage extends StatelessWidget {
  const SharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("나눔 게시글"),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: const [
              TitleInput(),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ExpirationDateInput(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: DescriptionInput(),
              ),
              Spacer(),
              BottomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
