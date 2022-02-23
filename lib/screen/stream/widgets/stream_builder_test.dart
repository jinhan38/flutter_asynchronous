import 'dart:async';

import 'package:flutter/material.dart';


///StreamController와 StreamBuilder를 사용한 count 예제
class StreamBuilderTest extends StatefulWidget {
  const StreamBuilderTest({Key? key}) : super(key: key);

  @override
  _StreamBuilderTestState createState() => _StreamBuilderTestState();
}

class _StreamBuilderTestState extends State<StreamBuilderTest> {
  final StreamController<int> _controller = StreamController();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _builder(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _plusButton(),
          _minusButton(),
        ]),
      ],
    );
  }

  Widget _plusButton() {
    return ElevatedButton(
        onPressed: () {
          _controller.sink.add(++count);
        },
        child: Text("plus"));
  }

  Widget _minusButton() {
    return ElevatedButton(
        onPressed: () {
          _controller.sink.add(--count);
        },
        child: Text("minus"));
  }

  StreamBuilder _builder() {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        print("count $count");
        return Text("StreamBuilder : $count",
            style: const TextStyle(fontSize: 20));
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
