import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:test_app/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/screens/test_google_map/test_google_map.dart';
import 'package:test_app/screens/test_soket.dart';
import 'package:test_app/screens/test_soket_screens/test_one_screen.dart';
import 'package:test_app/screens/test_soket_screens/web_socket_test.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      home: Scaffold(
        //appbar 수정
        resizeToAvoidBottomInset: false,
        //body: WebSoketScreen(), //LoginSignScreen(), TestSocketScreen()
        body: TestOneScreen(),
      ),
    );
  }
}
