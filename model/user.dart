class User {
  final int id;
  final int post_id;
  final String name;
  final String email;
  final String body;

  User({
    required this.id,
    required this.post_id,
    required this.name,
    required this.email,
    required this.body,
  });

  static User fromJson(json) => User(
        id: json['id'],
        post_id: json['post_id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );
}
