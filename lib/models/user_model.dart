class User {
  final String name;
  final String emailAddress;
  final int phoneNumber;
  final String password;
  final String confirmPassword;
  final String imagePath;

  const User({
    required this.name,
    required this.emailAddress,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': emailAddress,
        'phoneNumber': phoneNumber,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
