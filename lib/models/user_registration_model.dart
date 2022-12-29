class UserRegistrationModel {
  String email;
  String password1;
  String password2;
  String firstName;
  String lastName;

  UserRegistrationModel(
      {required this.email,
      required this.password1,
      required this.password2,
      required this.firstName,
      required this.lastName,});

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
        email: json['email'],
        password1: json['password1'],
        password2: json['password2'],
        firstName: json['first_name'],
        lastName: json['last_name'],);
  }

}
