import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:collection/collection.dart';
import 'package:test_app/screens/chatting_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserCredential userCredential;
  const HomeScreen({super.key, required this.userCredential});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List testPeople = [
    'assets/images/one.jpeg',
    'assets/images/two.jpeg',
    'assets/images/three.jpeg',
    'assets/images/four.jpg',
    'assets/images/four.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chating',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Color(0XFFF8F9FD),
        child: Column(
          children: [
            Container(
              //검색창
              width: size.width / 1.1,
              height: size.height / 12,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(size.width / 10),
              ),
            ),
            SizedBox(
              height: size.height / 25,
            ),
            Container(
              //최근 채팅한 사람 목록
              width: size.width,
              color: Colors.amber,
              height: size.height / 6.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: testPeople.mapIndexed((index, element) {
                    return RecentPeople(
                      index: index,
                      iconName: testPeople[index],
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ChattingScreen()),
                      );
                    },
                    child: Container(
                      //이거 사이즈 조절해야함
                      color: Colors.red,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(widget
                                    .userCredential.user?.photoURL ??
                                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: size.height / 60,
                              ),
                              Padding(
                                //이름
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${widget.userCredential.user?.displayName}',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                //마지막 대화내용
                                'test',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecentPeople extends StatefulWidget {
  final int index;
  final String iconName;
  const RecentPeople({
    super.key,
    required this.index,
    required this.iconName,
  });

  @override
  State<RecentPeople> createState() => _RecentPeopleState();
}

class _RecentPeopleState extends State<RecentPeople> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width / 4.7,
          margin: EdgeInsets.only(left: 0 == widget.index ? 10 : 0, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width / 10),
            border: Border.all(color: Colors.black54),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.width / 10),
            child: Image.asset(widget.iconName),
          ),
        ),
        Text('test')
      ],
    );
  }
}
