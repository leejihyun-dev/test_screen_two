import 'package:flutter/material.dart';

class TestTwoScreen extends StatefulWidget {
  const TestTwoScreen({super.key});

  @override
  State<TestTwoScreen> createState() => _TestTwoScreenState();
}

class _TestTwoScreenState extends State<TestTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.pink,
        child: Center(
          child: Text(
            '핑크입니다.',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
