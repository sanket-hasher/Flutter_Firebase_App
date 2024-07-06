import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .set(studentInfoMap);
  }

  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return await FirebaseFirestore.instance.collection('Student').snapshots();
  }

  Future updateStudentDetails(
      String id, Map<String, dynamic> updateInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('Student')
        .doc(id)
        .update(updateInfoMap);
  }
   Future deleteStudentDetails(
      String id) async {
    return await FirebaseFirestore.instance
        .collection('Student')
        .doc(id)
        .delete();
  }
  
}
