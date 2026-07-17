import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('test'),
        ElevatedButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text('register'),
        ),
      ],
    );
  }
}
