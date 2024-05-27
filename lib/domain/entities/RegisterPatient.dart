class RegisterPatientDataRequest {
  final String name;
  final String nationalId;
  final String phoneNumber;
  final String email;
  final String password;

  RegisterPatientDataRequest({
    required this.name,
    required this.nationalId,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
