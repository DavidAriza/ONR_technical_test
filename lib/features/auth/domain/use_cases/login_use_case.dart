import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/core/use_case/login_params.dart';
import 'package:onr_technical_test/core/use_case/use_case.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';
import 'package:onr_technical_test/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponseEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, LoginResponseEntity>> call(LoginParams params) async {
    return await authRepository.login(params.email, params.password);
  }
}
