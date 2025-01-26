import 'package:dio/dio.dart';
import 'package:onr_technical_test/core/error_handling/error.dart';
import 'package:onr_technical_test/core/error_handling/exception.dart';
import 'package:onr_technical_test/features/auth/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio httpClient;

  AuthRemoteDataSourceImpl({required this.httpClient});
  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return LoginResponseModel(
        id: 1,
        email: email,
        token: 'token',
      );
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
