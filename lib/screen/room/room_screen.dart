import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_asynchronous/firestore/get/fs_get.dart';
import 'package:flutter_asynchronous/firestore/set/fs_set.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Room")),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: FSGet.readData(),
          builder: (context, snapshot) {
            List<int> value = [];
            if (snapshot.hasData) {
              value = snapshot.data!.map((e) {
                int result = e["num"] ?? 0;
                return result;
              }).toList();
            }
            return _listView(value: value);
          },
        )
      ],
    );
  }

  Widget _listView({required List<int> value}) {
    return ListView.separated(
      itemCount: value.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 60,
            child: Text(
              "대화방 $index번 : ${value[index]}",
              style: const TextStyle(fontSize: 20),
            ));
      },
      separatorBuilder: (context, index) => Divider(
        height: 2,
        thickness: 2,
        color: Colors.grey.shade500,
      ),
    );
  }
}
