import 'package:flutter/material.dart';

class TestThreeScreen extends StatefulWidget {
  const TestThreeScreen({super.key});

  @override
  State<TestThreeScreen> createState() => _TestThreeScreenState();
}

class _TestThreeScreenState extends State<TestThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Text(
            '파랑입니다.',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
