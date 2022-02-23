
import 'package:flutter_asynchronous/screen/main/main_screen.dart';
import 'package:flutter_asynchronous/screen/room/room_screen.dart';
import 'package:get/get.dart';

import 'screen/future/future_screen.dart';
import 'screen/stream/stream_screen.dart';

class RoutePage {
  static int ROUTE_DURATION_TIME = 300;
  static int ROUTE_DURATION_TIME_SHORT = 200;

  static const Transition baseTransition = Transition.native;
  static const Transition transitionHorizontal = Transition.cupertino;

  static movePage(String pageName) => Get.toNamed(pageName);

  static movePageWithArgument(String pageName, dynamic arguments) =>
      Get.toNamed(pageName, arguments: arguments);

  static Future<dynamic> movePageWithArgumentCallBack(
          String pageName, dynamic arguments) async =>
      Get.toNamed(pageName, arguments: arguments);

  ///현재 page 지우고 다음 페이지로 이동
  static offAndToNamed(String pageName, {dynamic argument}) =>
      Get.offAndToNamed(pageName, arguments: argument);

  ///기존에 쌓여있던 모든 stack 지우고 이동하려는 페이지만 stack이 남는다
  static moveOffAllNamed(String pageName) => Get.offAllNamed(pageName);

  ///현재 페이지 제거하고 입력받은 페이지로 이동
  static off(String pageName) => Get.off(pageName);

  static offAllNamed(String pageName) => Get.offAllNamed(pageName);

  static getBack() => Get.back();


  ///특정 페이지까지 돌아가면서 그 사이에 있는 페이지들은 종료
  static offUntil(String routeName) =>
      Get.until((route) => Get.currentRoute == routeName);

  static const String MAIN = "/main";
  static const String FUTURE = "/future";
  static const String STREAM = "/stream";
  static const String ROOM = "/room";


  static final List<GetPage> getPageList = [
    GetPage(
      name: MAIN,
      page: () => const MainScreen(),
      transition: baseTransition,
    ),
    GetPage(
      name: FUTURE,
      page: () => const FutureScreen(),
      transition: baseTransition,
    ),
    GetPage(
      name: STREAM,
      page: () => const StreamScreen(),
      transition: baseTransition,
    ),
    GetPage(
      name: ROOM,
      page: () => const RoomScreen(),
      transition: baseTransition,
    ),
  ];
}
