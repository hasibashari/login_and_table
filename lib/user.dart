// user.dart
class User {
  final String email;
  final String password;

  User(this.email, this.password);
}

mixin UserMixin {
  List<User> users = [];

  void addUser(String email, String password) {
    users.add(User(email, password));
  }
}
