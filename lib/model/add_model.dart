class AddModel {
  final int? id;
  final String username;
  final String email;
  final String password;

  const AddModel({
    this.id = null,
    required this.username,
    required this.password,
    required this.email,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'TodoModel{id: $id, username: $username, email: $email, password: $password}';
  }
}
