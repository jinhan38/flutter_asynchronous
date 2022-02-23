import 'package:cloud_firestore/cloud_firestore.dart';

class FSSet {
  static Future<bool> set({
     String collection ="",
     String doc ="" ,
    required Map<String, dynamic> json,
  }) async {
    final f = FirebaseFirestore.instance;
    var result = true;
    if(doc.isEmpty){
      await f.collection(collection).doc().set(json).then((value) {
        result = true;
      }).onError((error, stackTrace) {
        print("firebase set error : $error, stackTrace : $stackTrace ");
        result = false;
      });
    }else{
      await f.collection(collection).doc(doc).set(json).then((value) {
        result = true;
      }).onError((error, stackTrace) {
        print("firebase set error : $error, stackTrace : $stackTrace ");
        result = false;
      });
    }

    return result;
  }
}
