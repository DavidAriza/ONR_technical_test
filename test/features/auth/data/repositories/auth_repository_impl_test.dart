import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onr_technical_test/core/error_handling/exception.dart';
import 'package:onr_technical_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:onr_technical_test/features/auth/data/models/login_response_model.dart';
import 'package:onr_technical_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:onr_technical_test/features/auth/domain/repository/auth_repository.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepository =
        AuthRepositoryImpl(authRemoteDataSource: mockAuthRemoteDataSource);
  });

  group("AuthRepository", () {
    const loginResponseModel =
        LoginResponseModel(id: 1, email: 'email', token: 'token');
    test(
        'should return a login response when the call to the auth remote data source is successful',
        () async {
      ///Arrange
      when(() => mockAuthRemoteDataSource.login(any(), any()))
          .thenAnswer((_) async => loginResponseModel);

      ///Act
      final result = await authRepository.login('email', 'password');

      ///Assert
      verify(() => mockAuthRemoteDataSource.login('email', 'password'));
      expect(result, isA<Right>());
      expect(result, Right(loginResponseModel.toEntity()));
    });
  });

  test(
      'should return a failure when the call to the auth remote data source is unsuccessful',
      () async {
    ///Arrange
    when(() => mockAuthRemoteDataSource.login(any(), any())).thenThrow(
        DioFailure.decode(
            DioException(requestOptions: RequestOptions(path: ''))));

    ///Act
    final result = await authRepository.login('email', 'password');

    ///Assert
    expect(result, isA<Left>());
  });
}
