class User {
  final int? id;
  final String name;
  final String type;
  final String password;
  final int allow;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      password: map['password'] as String,
      type: map['type'] as String,
      allow: map['allow'] as int,
    );
  }

  User(
      {this.id,
      required this.name,
      required this.type,
      required this.password,
      required this.allow});
}
