import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:test_app/screens/test_soket_screens/test_one_screen.dart';
import 'package:test_app/screens/test_soket_screens/test_three_screen.dart';
import 'package:test_app/screens/test_soket_screens/test_two_screen.dart';
import 'package:test_app/screens/test_soket_screens/video_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//클라이언트2
class WebSoketScreen extends StatefulWidget {
  const WebSoketScreen({super.key});

  @override
  State<WebSoketScreen> createState() => _WebSoketScreenState();
}

class _WebSoketScreenState extends State<WebSoketScreen> {
  late final WebSocketChannel _channel;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    connectChannel();
  }

  void connectChannel() {
    //서버 연결 시도
    _channel = WebSocketChannel.connect(Uri.parse(
        'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.eventsd
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _channel.sink.close(); //소켓 서버 연결 끊기
  }

  void _showContainer(context, data) async {
    Future.delayed(const Duration(seconds: 3), () async {
      if ('1' == data) {
        await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  VideoScreen(), //TestOneScreen(),
            ));
      } else if ('2' == data) {
        await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => TestTwoScreen(),
            ));
      } else {
        await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => TestThreeScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // _channel.stream.listen((event) {
    //   (message) {
    //     print('message $message');
    //   };
    // });

    // return Column(
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.all(10),
    //       child: TextField(
    //         controller: _controller,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     StreamBuilder(
    //         stream: _channel.stream,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             print('snapshot.data ${snapshot.data}');
    //             return Text(snapshot.data);
    //           } else {
    //             return Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height,
    //               child: Image.asset(
    //                 'assets/images/loading_background.gif',
    //                 fit: BoxFit.cover,
    //               ),
    //             );
    //           }
    //         }),
    //   ],
    // );
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/loading_background.gif',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              FloatingActionButton(
                //눈꽃버튼
                //연결 입장
                heroTag: 'connect',
                onPressed: () {
                  final msg = {
                    "type": "ENTER",
                    "roomId": "1",
                    "name": "이지현???",
                  };
                  _channel.sink.add(jsonEncode(msg));
                },
                child: Icon(Icons.ac_unit_rounded),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: 'message',
                onPressed: () {
                  final talkMsg = {
                    "type": "TALK",
                    "roomId": "1",
                    "sender": "chee",
                    "msg": _controller.text.toString(),
                  };
                  _channel.sink.add(jsonEncode(talkMsg));
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        json.decode(snapshot.data.toString());
                    print('snapshot.data ${snapshot.data}');
                    if (data['msg'] == '1') {
                      //넘어오는 데이터에 따라 화면 다르게 표시
                      print('요깃');
                      _showContainer(context, data['msg']); //이렇게 하면 오류 안남
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) => TestOneScreen(),
                      //   ),
                      // );
                    }
                    return Text(snapshot.data);
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
    // Column(
    //   children: [
    //     StreamBuilder(
    //         stream: _channel.stream,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             print('snapshot.data ${snapshot.data}');
    //             return Center(child: Text(snapshot.data));
    //           } else {
    //             return Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height,
    //               child: Stack(
    //                 children: [
    //                   Positioned.fill(
    //                     child: Image.asset(
    //                       'assets/images/loading_background.gif',
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.center,
    //                     child: Text(
    //                       '기본 화면입니다.',
    //                       style: TextStyle(
    //                         fontSize: 30,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           }
    //         }),
    //   ],
    // );
  }
}
