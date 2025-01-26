import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseEntity>> login(
      String email, String password);
}
