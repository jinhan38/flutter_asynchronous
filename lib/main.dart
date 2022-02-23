import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'route_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) {
          return MediaQuery(

              ///유저가 디바이스에서 텍스트 폰트 변경해도 반영 안되도록 설정
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!);
        },
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: RoutePage.MAIN,
        getPages: RoutePage.getPageList);
  }
}
