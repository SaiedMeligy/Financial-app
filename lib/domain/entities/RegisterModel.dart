class RegisterDataRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
   String? rule;

  RegisterDataRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
     this.rule,
  });
}
