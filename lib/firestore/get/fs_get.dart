import 'package:cloud_firestore/cloud_firestore.dart';

class FSGet {
  static Future<Map<String, dynamic>?> get({
    required String collection,
    required String doc,
    int limit = 1,
    int? isGreaterThan,
    bool descending = true,
  }) async {
    final f = FirebaseFirestore.instance;
    try {
      var result = await f.collection(collection).doc(doc).get();
      return result.data();
    } catch (e) {
      print("FSGet get error : $e");
      return null;
    }
  }

  ///유저 정보 가져오기
  ///snapshot은 모든 document를 가져온다
  ///Stream으로 선언했기 때문에 fireStore의 user 데이터가 바뀌면 변경된 데이터를 전달받는다
  static Stream<List<Map<String,dynamic>>> readData() => FirebaseFirestore.instance
      .collection("room")
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  // static Future<dynamic> get(
  //     {required String collection,
  //     int limit = 1,
  //     int? isGreaterThan,
  //     String where = 'uploadTime',
  //     String orderBy = 'uploadTime',
  //     bool descending = true}) async {
  //   final f = FirebaseFirestore.instance;
  //   dynamic result;
  //   await f
  //       .collection(collection)
  //       .where(where,
  //           isGreaterThan:
  //               isGreaterThan ?? DateTime.now().millisecondsSinceEpoch)
  //       .orderBy(orderBy, descending: true)
  //       .get()
  //       .then((value) => result = value)
  //       .onError((error, stackTrace) {
  //     BaseController.to.logger
  //         .e("firebase get error : $error, stackTrace : $stackTrace ");
  //     result = null;
  //   });
  //   return result;
  // }

  static Future<dynamic> getSnapshot(
      {required String collection,
      int limit = 1,
      String orderBy = 'uploadTime',
      bool descending = true}) async {
    final f = FirebaseFirestore.instance;

    return f
        .collection(collection)
        .limit(limit)
        .orderBy(orderBy, descending: descending)
        .snapshots();
  }
}
