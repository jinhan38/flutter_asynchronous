import 'package:cloud_firestore/cloud_firestore.dart';

class FSSet {
  ///FireStore Database의 room collection 업데이트
  static Future set({
    required String collection,
    required String doc,
    required Map<String, dynamic> json,
  }) async {
    await FirebaseFirestore.instance.collection(collection).doc(doc).set(json);
  }
}
