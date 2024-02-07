import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [],
          )),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0XFFCCCCCC))),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '내용 입력',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.send)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
