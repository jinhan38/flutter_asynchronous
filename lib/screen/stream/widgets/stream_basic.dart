import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StreamBasic extends StatefulWidget {
  const StreamBasic({Key? key}) : super(key: key);

  @override
  _StreamBasicState createState() => _StreamBasicState();
}

class _StreamBasicState extends State<StreamBasic> {
  RxInt sum = 0.obs;

  bool _pageDispose = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///초기화
            _reset(),

            ///시작
            _start(),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() =>
            Text("value : ${sum.value}", style: const TextStyle(fontSize: 20))),
      ],
    );
  }

  ///초기화
  Widget _reset() {
    return ElevatedButton(
        onPressed: () => sum.value = 0,
        child: const Text("초기화", style: TextStyle(fontSize: 20)));
  }

  @override
  void dispose() {
    _pageDispose = true;
    super.dispose();
  }

  Widget _start() {
    return ElevatedButton(
        onPressed: () async {
          _stream = countStream(10);

          ///take를 활용하면 take에 입력된 숫자 만큼만 listen함수로 들어온다.
          _stream.take(9).takeWhile((element) {
            ///takeWhile에서 false를 리턴하면 stream을 종료시킨다
            if (element == 8) {
              return false;
            } else if (_pageDispose) {
              return false;
            } else {
              return true;
            }
          }).where((event) {
            ///where에서 false를 return하면 stream의 listener는 계속 붙어있지만
            ///listen 함수로 진입하지는 않는다
            return !(event > 6);
          }).listen((v) {
            sum.value += v;
            print("sum : ${sum.value}");
          });
        },
        child: Container(
            alignment: Alignment.center,
            child: const Text("Stream basic", style: TextStyle(fontSize: 20))));
  }

  late Stream<int> _stream;

  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield i;
    }
  }
}
