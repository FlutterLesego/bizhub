class User {
  final String bizName;
  final String emailAddress;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String imagePath;

  const User({
    required this.bizName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': bizName,
        'email': emailAddress,
        'phoneNumber': phoneNumber,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
