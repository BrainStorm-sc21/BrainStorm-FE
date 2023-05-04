import 'package:brainstorm_meokjang/pages/deal/register/exchange_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/group_purchase_page.dart';
import 'package:flutter/material.dart';

class DealPage extends StatelessWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExchangePage()),
                );
              },
              child: const Text("교환"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GroupPurchasePage()),
                );
              },
              child: const Text("공동구매"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExchangePage()),
                );
              },
              child: const Text("나눔"),
            ),
          ],
        ),
      ),
    );
  }
}
