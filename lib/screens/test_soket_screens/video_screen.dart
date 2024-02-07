import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final WebSocketChannel _channel;
  late final Player player;
  late final VideoController videoController;

  // late int currentVolum;

  String totalLength = '00:00';
  String currentLength = '00:00';
  int intTotal = 1;
  int intCur = 0;
  Duration _totalDuration =
      Duration(hours: 0, minutes: 0, seconds: 0, milliseconds: 0);

  // //테스트
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    player = Player();

    // player.play();

    videoController = VideoController(player);

    player.open(Media('asset:///assets/images/teest_snow_angel_video.mp4'),
        play: false); //test_video teest_snow_angel_video

    player.stream.duration.listen((event) {
      // media_kit: wakelock: _count = 1 이게 되면 영상재생 길이를 파악할 수 있다.
      // videoLength = event;

      if (event != Duration.zero) {
        //총 재생시간이 들어왔을 때
        String totalLength = event
            .toString()
            .split('.')
            .first
            .split(':')
            // .skip(1)
            .take(3)
            .join(':');
        // .을 기준으로 자르는 후 첫번째 꺼를 또 :기준으로 자르고 스킵은 머임 join으로 연결한다.

        _totalDuration = Duration(
          //재생바를 구현하기 위해서 필요하다
          hours: event.inHours,
          minutes: (event.inMinutes % 60).floor(),
          seconds: (event.inSeconds % 60).floor(),
          microseconds: event.inMilliseconds % 1000,
        );
        final talkMsg = {
          "type": "TALK",
          "roomId": "1",
          "sender": "totalLength",
          "msg": '$totalLength',
          "length": "${event.inMilliseconds}",
          "playLength": "${event.inSeconds.toDouble()}", //_totalDuration
        };
        _channel.sink.add(jsonEncode(talkMsg));
        totalLength = totalLength;

        intTotal = event.inMilliseconds;
        _duration = event;

        Duration(
            hours: 0, minutes: 3, seconds: 28, milliseconds: 840); //이런식으로 뽑아내야함
      }
    });
    player.stream.position.listen((event) {
      //영상 실시간 위치 파악

      String currentLength =
          event.toString().split('.').first.split(':').join(':'); //.skip(1)
      Duration _currentDuration = Duration(
        //재생바를 구현하기 위해서 필요하다
        hours: event.inHours,
        minutes: (event.inMinutes % 60).floor(),
        seconds: (event.inSeconds % 60).floor(),
        microseconds: event.inMilliseconds % 1000,
      );
      final talkMsg = {
        "type": "TALK",
        "roomId": "1",
        "sender": "currentLength",
        "msg": '$currentLength',
        "length": '${event.inMilliseconds}',
        "playLength": "$_currentDuration",
      };
      _channel.sink.add(jsonEncode(talkMsg));
      currentLength = currentLength;

      _position = event;
      print('_position $event');
      intCur = event.inMilliseconds; //재생바를 구현하려고 duration을 밀리초로 변환후 int에 넣어준다.
    });

    super.initState();
    connectChannel(); //서버랑 연결시도
  }

  void connectChannel() {
    print('연결시도');
    //서버 연결 시도

    _channel = WebSocketChannel.connect(Uri.parse(
        'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.eventsd
    final msg = {
      "type": "ENTER",
      "roomId": "1",
      "name": "이지현???",
    };
    _channel.sink.add(jsonEncode(msg));
  }

  @override
  void dispose() {
    print('VideoPlayer dispose');
    player.dispose();
    // controller.stop();
    _channel.sink.close(); //소켓 서버 연결 끊기
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder(
        stream: _channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = json.decode(snapshot.data.toString());
            //stop, play, left, right, up, down
            if (data['msg'] == 'stop') {
              print('비디오 정지');
              player.pause(); //stop으로 하면 멈췄다가 재생하는게 안된다. pause로 해야함..
            } else if (data['msg'] == 'play') {
              if (!player.state.playing) {
                player.play();
              }
            } else if (data['msg'] == 'left') {
              //10초 이전  //위치 조절은 되는데 약간의 버퍼가 걸림
              player.seek(
                  Duration(seconds: player.state.position.inSeconds - 10));
            } else if (data['msg'] == 'right' ||
                data['msg'] == 'playProgressbar') {
              // player.seek(
              //     Duration(seconds: player.state.position.inSeconds + 10));
              print('data length 어케 넘어오냐 ${data['length']}');
              final _test = int.parse(data['length']);
              player.seek(Duration(seconds: _test));
              // player.seek(duration)
            } else if (data['msg'] == 'volumnOn') {
              player.setVolume(100);
            } else if (data['msg'] == 'volumnMute') {
              player.setVolume(0);
            }
            if (data['sender'] == 'totalLength') {
              totalLength = data['msg'];
            }
            if (data['sender'] == 'currentLength') {
              currentLength = data['msg'];
            }
            if (data['sender'] == 'videoControl') {
              List<String> test = data['msg'].toString().split(':');
              int hour = int.parse(test[0]); //넘겨받은 영상 데이터로 이동시키기~
              int minute = int.parse(test[1]);
              int seconds = int.parse(test[2]);
              player.seek(
                  Duration(hours: hour, minutes: minute, seconds: seconds));
              //한시간짜리도 넘어가는지 확인해보자
            }
            // else if (data['msg'] == 'down') {
            //   if (currentVolum <= 100) {
            //     //100이랑 같거나 작을때
            //     if (currentVolum != 0) {
            //       //볼륨이 0이 아닐때까지
            //       currentVolum = currentVolum - 10;
            //       player.setVolume(currentVolum.toDouble());
            //     }
            //   }
            // }
            int _intTotal = _totalDuration.inSeconds; //클릭한 위치의 재생시간을 알아내기 위해 사용
            print('_duration${_duration}');
            print(
                '_duration insecond ${_duration.inSeconds} ${_duration.inSeconds.toDouble()}');
            print(
                '_position insecond ${_position.inSeconds} ${_position.inSeconds.toDouble()}');
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Video(
                    controller: videoController,
                    fit: BoxFit.fitWidth,
                    // controls: null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      children: [
                        // Stack(
                        //   // LinearProgressIndicator버전
                        //   children: [
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width,
                        //       height: 25,
                        //       child: GestureDetector(
                        //         onTapDown: (details) {
                        //           // 전체 동영상 재생 시간을 초로 가정
                        //           double totalDurationInSeconds =
                        //               _intTotal.toDouble();
                        //           // 선택한 위치를 전체 길이에 대한 백분율로 계산
                        //           double selectedPercentage =
                        //               details.localPosition.dx /
                        //                   MediaQuery.of(context).size.width;
                        //           // 해당 백분율에 따른 시간을 초로 계산
                        //           double selectedTimeInSeconds =
                        //               selectedPercentage *
                        //                   totalDurationInSeconds;

                        //           // 초를 분과 초로 변환
                        //           int selectedMinutes =
                        //               (selectedTimeInSeconds / 60).floor();
                        //           int selectedSeconds =
                        //               (selectedTimeInSeconds % 60).floor();

                        //           // 분이 60분을 넘어가면 시간을 계산
                        //           int selectedHours = 0;
                        //           if (selectedMinutes >= 60) {
                        //             selectedHours =
                        //                 (selectedMinutes / 60).floor();
                        //             selectedMinutes %= 60;
                        //           }
                        //           final talkMsg = {
                        //             "type": "TALK",
                        //             "roomId": "1",
                        //             "sender": "videoControl",
                        //             "msg":
                        //                 '$selectedHours:$selectedMinutes:$selectedSeconds',
                        //             "length": "",
                        //             "playLength": "",
                        //           };
                        //           _channel.sink.add(jsonEncode(talkMsg));
                        //         },
                        //         child: ClipRRect(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(20)),
                        //           child: LinearProgressIndicator(
                        //             backgroundColor: Colors.yellow,
                        //             color: Colors.blue,
                        //             value: (intCur / intTotal),
                        //             minHeight: 30,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Align(
                        //       alignment: Alignment.lerp(Alignment.topLeft,
                        //           Alignment.topRight, (intCur / intTotal))!,
                        //       child: Container(
                        //         width: 37,
                        //         height: 37,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50),
                        //           color: Colors.pink.shade200,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 20, //진행바 높이
                            activeTrackColor: Colors.blue.shade300, //채워지는 색
                            inactiveTrackColor: Color(0xFF757575), //진행바
                            thumbColor: Colors.amber, //진행버튼 색
                            thumbShape: //진행버튼 크기조절
                                RoundSliderThumbShape(enabledThumbRadius: 20),
                            //
                            overlayColor: Color(0xFFCDDC39).withOpacity(0.2),
                            overlayShape: //버튼 눌렀을 때 퍼짐 효과
                                RoundSliderOverlayShape(overlayRadius: 30),
                            // showValueIndicator: // 이건 뭔지 모르겠다.
                            //     ShowValueIndicator.onlyForContinuous,
                            // valueIndicatorShape:
                            //     PaddleSliderValueIndicatorShape(),
                          ),
                          child: Slider(
                            //Slider 버전 (이게 더 나을듯)
                            min: 0,
                            max: _duration.inSeconds.toDouble(),
                            value: _position.inSeconds.toDouble(),
                            onChanged: (value) {
                              //클릭해서 넘길 수도 있긴 한데 일단 보류
                              // final position = Duration(seconds: value.toInt());
                              // player.seek(position);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Text('$currentLength / '),
                              Text('$totalLength'),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            print('음 연결안됌');
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Video(
                    controller: videoController,
                    fit: BoxFit.fitWidth,
                    // controls: null,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(
                        child: Text('연결이 끊겼어요!'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
    // return ClipRRect(
    //   borderRadius:
    //       BorderRadius.circular(MediaQuery.of(context).size.width / 40),
    //   child: SizedBox(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     child: Video(
    //       controller: videoController,
    //       fit: BoxFit.fitWidth,
    //       // controls: null,
    //     ),
    //   ),
    // );
  }
}
