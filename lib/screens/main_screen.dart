import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/screens/home_screen.dart';

class LoginSignScreen extends StatefulWidget {
  const LoginSignScreen({super.key});

  @override
  State<LoginSignScreen> createState() => _LoginSignScreenState();
}
//에뮬 먼저 돌려서 키고 난 후에 디버깅 해보기

class _LoginSignScreenState extends State<LoginSignScreen> {
  List loginImg = [
    'assets/images/google.png',
    'assets/images/Kakao.png',
    'assets/images/signup.png'
  ];
  var _isChecked = false;
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Color(0XFFF8F9FD),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: size.width / 6,
              fontWeight: FontWeight.w700,
              color: Color(0XFF12C3CD),
            ),
          ),
          SizedBox(
            height: size.height / 15,
          ),
          Column(
            //아이디,비밀번호
            children: [
              Container(
                width: size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width / 10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFD8EEF7).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: TextField(
                  controller: idController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width / 10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Container(
                width: size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width / 10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFD8EEF7).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: TextField(
                  controller: pwController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width / 10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 30,
          ),
          SizedBox(
              //자동저장 체크
              width: size.width / 1.3,
              height: size.height / 15,
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    checkColor: Color(0XFF12C3CD),
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.white.withOpacity(.32);
                      }
                      return Color(0XFFCCCCCC);
                    }),
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text('자동로그인'),
                ],
              )),
          SizedBox(
            height: size.height / 25,
          ),
          Column(
            children: [
              Text(
                'Sign up with social account',
                style: TextStyle(
                  fontSize: size.width / 30,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF999999),
                ),
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: loginImg.mapIndexed((index, element) {
                  return LoginIcon(
                    index: index,
                    iconName: loginImg[index],
                  );
                }).toList(),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Container(
                width: size.width / 1.3,
                height: size.height / 11,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(size.width / 13),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0XFF199ADE),
                      Color(0XFF12C3CD),
                    ],
                  ),
                ),
                child: Center(
                    child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: size.width / 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}

class LoginIcon extends StatefulWidget {
  final int index;
  final String iconName;
  const LoginIcon({
    super.key,
    required this.index,
    required this.iconName,
  });

  @override
  State<LoginIcon> createState() => _LoginIconState();
}

class _LoginIconState extends State<LoginIcon> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (0 == widget.index) {
          signInWithGoogle();
        } else {
          print('click');
        }
      },
      child: Container(
        width: size.width / 7,
        height: size.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width / 17),
          boxShadow: [
            BoxShadow(
              color: Color(0XFFD8EEF7).withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 7),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width / 17),
          child: Image.asset(widget.iconName),
        ),
      ),
    );
  }

  // Future<UserCredential>
  void signInWithGoogle() async {
    //구글 로그인
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential != null) {
      print('success login $userCredential');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userCredential: userCredential,
          ),
        ),
      );
    } else {
      print('fail login ');
    }

    // await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    //   print(value.user?.email);

    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //         builder: (context) => HomeScreen(
    //               userCredential: userCredential,
    //             )),
    //   );
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
  }
}
