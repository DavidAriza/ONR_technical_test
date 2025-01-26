class LoginResponseEntity {
  final int id;
  final String email;
  final String? token;

  const LoginResponseEntity({
    required this.id,
    required this.email,
    this.token,
  });
}
