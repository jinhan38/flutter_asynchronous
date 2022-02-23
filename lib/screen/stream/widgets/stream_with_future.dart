import 'package:flutter/material.dart';
import 'package:get/get.dart';

///stream과 future를 같이 사용한 예제
class StreamWithFuture extends StatefulWidget {
  const StreamWithFuture({Key? key}) : super(key: key);

  @override
  _StreamWithFutureState createState() => _StreamWithFutureState();
}

class _StreamWithFutureState extends State<StreamWithFuture> {

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

  @override
  void dispose() {
    _pageDispose = true;
    super.dispose();
  }

  ///초기화
  Widget _reset() {
    return ElevatedButton(
        onPressed: () {
          sum.value = 0;
        },
        child: const Text("초기화"));
  }

  Widget _start() {
    return ElevatedButton(
      onPressed: () async {
        await sumStream(countStream(10));
      },
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          "Stream with future",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield i;
    }
  }

  ///Future함수를 이용한 방법
  Future sumStream(Stream<int> stream) async {
    await for (final value in stream) {
      if (_pageDispose) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 20));
      sum.value += value;
    }
  }
}
