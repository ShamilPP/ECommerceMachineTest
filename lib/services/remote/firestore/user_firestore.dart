import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/user.dart';

class UserFirestore {
  CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('users');

  Future<User> getUserWithDocId(String docId) async {
    var user = await collection.doc(docId).get();
    if (user.exists) {
      // returning user data
      var usr = User.fromDocument(user);
      return usr;
    } else {
      throw Exception("User not exists");
    }
  }

  Future<User> addUser(User user) async {
    var result = await collection.doc(user.id).set((User.toMap(user)));
    return user;
  }
}
