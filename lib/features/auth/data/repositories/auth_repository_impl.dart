import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';
import 'package:onr_technical_test/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
      String email, String password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
