class AccountResource {
  final String email;
  final String password;
  final String name;
  final String role;
  final String uid;

  AccountResource(
      {required this.email,
      required this.password,
      required this.name,
      required this.role,
      required this.uid});

  factory AccountResource.fromJson(Map<String, dynamic> json) {
    return AccountResource(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        role: json['role'],
        uid: 'uid');
  }
}
