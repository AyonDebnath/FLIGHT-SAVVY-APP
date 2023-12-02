import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String username;
  String? Name;
  String? Phone;
  String? Address;
  String? imageUrl;

  User({this.id, required this.username, this.imageUrl, this.Name, this.Phone, this.Address});

  static User fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: map['username']?? 'testing',
      Name: map['Name'] ?? '',
      Phone: map['Phone'] ?? '',
      Address: map['Address'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }
}
