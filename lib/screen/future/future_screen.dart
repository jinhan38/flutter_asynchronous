import 'dart:async';

import 'package:flutter/material.dart';

import 'future_note.dart';
import 'note.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({Key? key}) : super(key: key);

  @override
  _FutureScreenState createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Future")),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Note().start(),
              child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text("note", style: TextStyle(fontSize: 24)))),

          ///간격
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () async => await FutureNote().start(),
              child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text("Future note",
                      style: TextStyle(fontSize: 24)))),

          ///간격
          const SizedBox(height: 40),

          ///동기 작업
          ElevatedButton(
              onPressed: () => _synchronous(),
              child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child:
                      const Text("동기 작업 실행", style: TextStyle(fontSize: 24)))),

          ///간격
          const SizedBox(height: 40),

          ///비동기 작업
          ElevatedButton(
              onPressed: () => _asynchronous(),
              child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child:
                      const Text("비동기 작업 실행", style: TextStyle(fontSize: 24)))),
        ],
      ),
    );
  }

  ///동기 작업 함수
  _synchronous() {
    Stopwatch stopwatch = Stopwatch()..start();
    print("동기 시작 : ${stopwatch.elapsed}");
    _futureDelay(stopwatch: stopwatch);
    _futureMicroTask(stopwatch: stopwatch);
    print("동기 끝 : ${stopwatch.elapsed}");
  }

  ///비동기 작업 함수
  Future _asynchronous() async {
    Stopwatch stopwatch = Stopwatch()..start();
    stopwatch.start();
    print("비동기 시작 : ${stopwatch.elapsed}");
    await _futureDelay(stopwatch: stopwatch);
    await _futureMicroTask(stopwatch: stopwatch);
    await _futureDelay(stopwatch: stopwatch);
    print("비동기 끝 : ${stopwatch.elapsed}");
  }

  ///비동기 작업은 일반적인 동기 작업들이 실행되고 난 후에 실행된다.
  Future _futureMicroTask({required Stopwatch stopwatch}) {
    return Future.microtask(() {
      print("_microtask : ${stopwatch.elapsed}");
    });
  }

  ///Future delay는 동기 작업이 마무리된 후부터 실행
  Future _futureDelay({required Stopwatch stopwatch}) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      print("_futureDelay : ${stopwatch.elapsed}");
    });
  }
}
