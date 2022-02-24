import 'package:cloud_firestore/cloud_firestore.dart';

class FSGet {
  ///파이어베이스의 room collection에 있는 모든 데이터 불러오기
  static Stream<List<Map<String, dynamic>>> readData({required String collection}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
