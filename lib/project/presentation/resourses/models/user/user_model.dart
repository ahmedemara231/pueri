class User_Model {
  String? first_name;
  String? last_name;
  String? id; // You can use either int or String, depending on your use case
  String? password;
   List<String>? favorites;
  String? email;
  String? phone;
  String? date_birth;

  // Constructor
  User_Model({
    required this.first_name,
    required this.last_name,
    required this.id,
    required this.date_birth,
    required this.phone,
    required this.password,
    required this.email,
    required this.favorites,
  });

  // Factory method to create a User object from a JSON map
  factory User_Model.fromJson(Map<String, dynamic> json) {
    return User_Model(
      first_name: json['first_name'],
      last_name: json['last_name'],
      id: json['id'],
      date_birth: json['date_birth'],
      phone: json['phone'],
      password: json['password'],
      email: json['email'],
      favorites: List<String>.from(json['favorites'] as List<dynamic>),
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date_birth': date_birth,
      'phone': phone,
      'last_name': last_name,
      'favorites': favorites,
      'first_name': first_name,
      'id': id,
      'password': password,
      'email': email,
    };
  }
}
