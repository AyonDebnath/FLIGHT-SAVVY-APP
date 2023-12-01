import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String username;

  User(
      {this.id,
      required this.username});

  static User fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: map['username'] ?? 'testing',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }
}
