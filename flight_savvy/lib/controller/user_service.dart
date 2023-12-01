import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../model/user.dart' as LoggedInUser;


class UserService {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection;

  UserService()
      : userCollection = FirebaseFirestore.instance
            .collection('users');


  Future<void> updateDiaryEntry(LoggedInUser.User user) async {
    return await userCollection
        .doc(user.id)
        .update(user.toMap());
  }

  Future<void> deleteDiaryEntry(String id) async {
    return await userCollection.doc(id).delete();
  }

  Stream<List<LoggedInUser.User>> getUsers() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => LoggedInUser.User.fromMap(doc)).toList();
    });
  }
}
