import 'package:flutter/material.dart';
import 'package:flutter_asynchronous/route_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
              text: "Future",
              onTap: () => RoutePage.movePage(RoutePage.FUTURE)),
          _button(
              text: "stream",
              onTap: () => RoutePage.movePage(RoutePage.STREAM)),
          _button(
              text: "room",
              onTap: () => RoutePage.movePage(RoutePage.ROOM)),
        ],
      ),
    );
  }

  Widget _button({required String text, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity - 100,
      height: 50,
      child: ElevatedButton(onPressed: onTap, child: Text(text)),
    );
  }
}
