import 'package:firstapp/widgets/radio_button.dart';

class User {
  final String bizLogo;
  final String name;
  final String emailAddress;
  final String phoneNumber;
  final BusinessTypeEnum businessType;
  String? cipcNumber;
  String? idNumber;
  final String location;
  final String password;
  final String confirmPassword;
  final String imagePath;

  User({
    required this.bizLogo,
    required this.name,
    required this.emailAddress,
    required this.phoneNumber,
    required this.businessType,
    this.idNumber,
    this.cipcNumber,
    required this.location,
    required this.password,
    required this.confirmPassword,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'bizLogo': bizLogo,
        'name': name,
        'email': emailAddress,
        'phoneNumber': phoneNumber,
        'businessType': businessType,
        'cipcNumber': cipcNumber!,
        'idNumber': idNumber!,
        'location': location,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
