import 'package:flutter/material.dart';
import 'package:test_app/screens/test_soket_screens/video_screen.dart';

class TestOneScreen extends StatefulWidget {
  const TestOneScreen({super.key});

  @override
  State<TestOneScreen> createState() => _TestOneScreenState();
}

class _TestOneScreenState extends State<TestOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '보여줄 큰 화면',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => VideoScreen(),
                  ),
                );
              },
              child: Text('영상보기'),
            )
          ],
        ),
      ),
    );
  }
}
