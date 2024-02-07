import 'package:flutter/material.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Center(
        child: Text(
          '화면 확인용',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
