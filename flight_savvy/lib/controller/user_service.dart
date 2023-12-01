import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import '../model/user.dart' as LoggedInUser;

class UserService {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection;

  UserService()
      : userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateName(String id, String name) async {
    return await userCollection.doc(id).update({'Name': name});
  }

  Future<String> getName(String id) async {
    DocumentSnapshot user = await userCollection.doc(id).get();
    String Name =  user['Name'];
    return Name;
  }

  Future<void> updatePhone(String id, String name) async {
    return await userCollection.doc(id).update({'Phone': name});
  }

  Future<void> updateAddress(String id, String name) async {
    return await userCollection.doc(id).update({'Address': name});
  }

  Future<void> deleteDiaryEntry(String id) async {
    return await userCollection.doc(id).delete();
  }

  Stream<List<LoggedInUser.User>> getUsers() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => LoggedInUser.User.fromMap(doc))
          .toList();
    });
  }
}
