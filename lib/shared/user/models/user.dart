import 'dart:convert';

class User {
  final String displayName;
  final String email;
  final String id;
  final String? photoUrl;

  User({
    required this.displayName,
    required this.email,
    required this.id,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'User(displayName: $displayName, email: $email, id: $id, photoUrl: $photoUrl)';
  }
}
