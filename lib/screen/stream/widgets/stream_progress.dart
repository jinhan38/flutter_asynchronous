import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Stream을 활용한 progress 예제
class StreamProgress extends StatefulWidget {
  StreamProgress({Key? key}) : super(key: key);

  @override
  _StreamProgressState createState() => _StreamProgressState();
}

class _StreamProgressState extends State<StreamProgress> {
  ///프로그레스 값
  final RxInt _progress = 0.obs;

  ///프로그레스바의 현재 가로 넓이
  final RxDouble _width = 0.0.obs;

  ///프로그레스바의 가로 최대 넓이
  final double _maxWidth = 300;

  ///stream이 마무리 됐는지 안됐는지 체크
  final RxBool _streamComplete = false.obs;

  ///스트림이 실행중인 경우 false,
  bool _streamEnable = true;

  ///stream for문에 사용될 index 값
  int to = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///초기화 버튼
            _reset(),

            ///시작 버튼
            _start(),
          ],
        ),

        ///프로그레스 수치 값 보여주는 text 위젯
        _progressValue(),
        const SizedBox(height: 20),

        ///프로그레스 막대 위젯
        _progressBar(),
      ],
    );
  }

  ///초기화
  Widget _reset() {
    return ElevatedButton(onPressed: _initData, child: const Text("초기화"));
  }

  _initData() {
    if (_streamComplete.value) {
      _progress.value = 0;
      _width.value = 0;
    }
  }

  ///시작
  Widget _start() {
    return ElevatedButton(
        onPressed: () {
          if (_streamEnable) {
            _streamEnable = false;
            _initData();
            _streamComplete.value = false;
            _countStream(to: to, duration: const Duration(milliseconds: 10))
                .listen((event) {
              print(event);
              _progress.value = event;
              if (_width.value >= _maxWidth) {
                _width.value = _maxWidth;
              } else {
                _width.value += _calcWidth(maxWidth: _maxWidth, to: to);
              }
            }).onDone(() {
              _streamEnable = true;
              _streamComplete.value = true;
            });
          }
        },
        child: const Text("프로그레스 시작"));
  }

  ///프로그레스 밸류
  Widget _progressValue() {
    return Obx(() {
      String completeText = "";
      if (_progress.value != 0) {
        completeText = _streamComplete.value ? "완료" : "진행중";
      }
      return Text("${_progress.value} $completeText",
          style: const TextStyle(fontSize: 24));
    });
  }

  ///막대 프로그레스바
  Widget _progressBar() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 50),
            Container(
              height: 20,
              width: _width.value,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.grey.shade400),
              ),
            ),
          ],
        ));
  }

  ///프로그레스 가로 길이 계산
  double _calcWidth({required double maxWidth, required int to}) =>
      maxWidth / to;

  ///스트림
  Stream<int> _countStream({
    required int to,
    required Duration duration,
  }) async* {
    for (int i = 0; i <= to; i++) {
      await Future.delayed(duration);
      yield i;
    }
  }
}
