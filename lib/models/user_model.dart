class UserModel {
  final String userId;
  final String email;
  final String phoneNumber;
  final DateTime registrationDate;
  final String username;

  UserModel({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.registrationDate,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'RegistrationDate': registrationDate,
      'Username': username,
    };
  }
}
