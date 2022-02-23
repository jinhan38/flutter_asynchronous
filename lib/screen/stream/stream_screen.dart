import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_asynchronous/screen/future/future_note.dart';
import 'package:flutter_asynchronous/screen/future/note.dart';
import 'package:flutter_asynchronous/screen/stream/widgets/stream_basic.dart';
import 'package:flutter_asynchronous/screen/stream/widgets/stream_builder_test.dart';
import 'package:flutter_asynchronous/screen/stream/widgets/stream_progress.dart';
import 'package:flutter_asynchronous/screen/stream/widgets/stream_with_future.dart';

import '../ScaleAnimationWidget.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({Key? key}) : super(key: key);

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen>
    with TickerProviderStateMixin {
  //https://dart.dev/tutorials/language/streams

  int sum = 0;
  late Stream<int> stream;

  final Divider _divider =
      Divider(height: 3, thickness: 3, color: Colors.grey.shade300);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stream")),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        ElevatedButton(
            onPressed: () {
              Note().start();
            },
            child: Text("note")),
        const SizedBox(height: 50),
        ElevatedButton(
            onPressed: () async{
              await FutureNote().start();
            },
            child: Text("Future note")),
        const SizedBox(height: 50),

        const StreamBasic(),
        const SizedBox(height: 50),

        _divider,

        const SizedBox(height: 50),

        ///stream과 future를 같이 사용한 예제
        const StreamWithFuture(),

        const SizedBox(height: 50),

        _divider,
        const SizedBox(height: 50),

        ///Stream을 활용한 progress 예제
        StreamProgress(),

        const SizedBox(height: 50),

        _divider,
        const SizedBox(height: 50),
        ScaleAnimationWidget(
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          child_2: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
          ),
        ),

        const SizedBox(height: 50),
        _divider,
        const SizedBox(height: 50),
        const StreamBuilderTest(),
        const SizedBox(height: 50),
      ],
    );
  }
}
