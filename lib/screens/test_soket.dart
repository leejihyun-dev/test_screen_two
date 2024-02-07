import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_app/screens/test_soket_screens/test_one_screen.dart';
import 'package:test_app/screens/test_soket_screens/test_three_screen.dart';
import 'package:test_app/screens/test_soket_screens/test_two_screen.dart';

class TestSocketScreen extends StatefulWidget {
  const TestSocketScreen({super.key});

  @override
  State<TestSocketScreen> createState() => _TestSocketScreenState();
}

class _TestSocketScreenState extends State<TestSocketScreen> {
  final IO.Socket socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());
  // String message = '';
  List<String> messages = [];
  late TextEditingController _controller;
  bool receiveData = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    socketEventSetting(); //서버랑 연결시켜야하니까 화면 들어오자마자 해준다.
  }

  void socketEventSetting() {
    socket.onConnect((_) {
      //서버연결 확인
      print('Connected to server');
    });
    socket.onDisconnect((_) {
      //서버 끊겼을 때 재연결 시도
      print('Disconnected from server');
      _reconnect();
    });
    socket.onError((error) {
      print('Error: $error');
    });

    socket.connect();
    socket.on('chat message', (data) {
      //메세지 받기  'chat message' 이렇게 안하면 메세지가 제대로 안온다./
      print('Received message: ${data['message']}');
      setState(() {
        receiveData = true;
      });
      Future.delayed(const Duration(seconds: 3), () async {
        if ('Yellow' == data['message']) {
          await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => TestOneScreen(),
              ));
        } else if ('Pink' == data['message']) {
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
      // setState(() {
      //   message = data;
      //   messages.add(data);
      // });
    });
  }

  void sendMessage(String message) {
    socket.emit('chat message', message);
    // 메시지를 서버로 보내는 코드입니다.
  }

  void _reconnect() {
    //연결이 끊겼을 때 다시 연결을 시도한다.
    Future.delayed(Duration(seconds: 5), () {
      print('Reconnecting...');
      socket.connect();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Align(
            alignment: Alignment.center,
            child: Text(
              '기본 화면입니다.',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          if (receiveData)
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
    // Column(
    //   children: [
    //     Expanded(
    //       child: ListView.builder(
    //         itemCount: messages.length,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             title: Text(messages[index]),
    //           );
    //         },
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.all(8),
    //       child: TextField(
    //         controller: _controller,
    //         onSubmitted: (message) {
    //           sendMessage(message);
    //         },
    //         decoration: InputDecoration(labelText: 'Enter your message'),
    //       ),
    //     )
    //   ],
    // );
  }
}
