import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_asynchronous/screen/room/fs_get.dart';
import 'package:flutter_asynchronous/screen/room/room_model.dart';
import 'fs_set.dart';

///Firebase와 Future, Stream을 활용한 채팅방 스크린
class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final String collectionName = "room";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Room")), body: _body());
  }

  Widget _body() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: FSGet.readData(collection: collectionName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          List<RoomModel> data = snapshot.data!
              .map<RoomModel>((json) => RoomModel.fromJson(json))
              .toList();
          return _listView(data: data);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ///리스트 위젯
  Widget _listView({required List<RoomModel> data}) {
    return ListView.separated(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        var model = data[index];
        return _listItem(
          name: model.name!,
          num: model.num!,
          plus: () async => await _plusData(roomModel: model),
          reset: () async => await _resetData(roomModel: model),
        );
      },
      separatorBuilder: (_, __) => _divider(),
    );
  }

  ///구분선
  Widget _divider() =>
      Divider(height: 2, thickness: 2, color: Colors.grey.shade300);

  ///리스트 아이템 위젯
  Widget _listItem({
    required String name,
    required int num,
    required VoidCallback plus,
    required VoidCallback reset,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ///숫자 증가 버튼
          ElevatedButton(onPressed: plus, child: const Text("증가")),
          const SizedBox(width: 10),

          ///숫자 초기화 버튼
          ElevatedButton(onPressed: reset, child: const Text("초기화")),

          ///대화방 이름과 숫자
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("$name : $num", style: const TextStyle(fontSize: 20))
            ]),
          )
        ],
      ),
    );
  }

  ///숫자 플러스 api 호출
  Future _plusData({required RoomModel roomModel}) async {
    int num = roomModel.num!;
    num++;
    await FSSet.set(
        collection: "room",
        doc: roomModel.doc!,
        json: {"doc": roomModel.doc!, "name": roomModel.name!, "num": num});
  }

  ///숫자 초기화 api 호출
  Future _resetData({required RoomModel roomModel}) async {
    await FSSet.set(
        collection: collectionName,
        doc: roomModel.doc!,
        json: {"doc": roomModel.doc!, "name": roomModel.name!, "num": 0});
  }
}
