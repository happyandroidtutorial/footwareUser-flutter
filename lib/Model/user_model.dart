class UserModel {
  String id;
  String name;
  String phone;
  String email;
  String password;

  UserModel({required this.id, required this.name, required this.phone,required this.email,required this.password});

  // Convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email' : email,
      'password':password
    };
  }
}
