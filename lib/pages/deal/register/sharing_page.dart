import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class SharingPage extends StatelessWidget {
  const SharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("공동구매"),
      ),
      body: Column(
        children: const [
          TitleInput(),
          ExpirationDateInput(),
          DescriptionInput(),
        ],
      ),
    );
  }
}
