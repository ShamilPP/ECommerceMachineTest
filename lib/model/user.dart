import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  /// Creates a `User` instance from a Firestore document.
  factory User.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      id: doc.id,
      name: doc.data()?['name'] ?? 'Unknown',
      email: doc.data()?['email'] ?? 'Unknown',
    );
  }

  /// Converts a `User` instance into a map suitable for Firestore.
  static Map<String, dynamic> toMap(User user) {
    return {
      'name': user.name,
      'email': user.email,
    };
  }
}
