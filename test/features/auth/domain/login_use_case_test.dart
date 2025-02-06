import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onr_technical_test/core/use_case/login_params.dart';
import 'package:onr_technical_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';
import 'package:onr_technical_test/features/auth/domain/use_cases/login_use_case.dart';

class MockAuthRepositoryImpl extends Mock implements AuthRepositoryImpl {}

void main() {
  group('login use case', () {
    late LoginUseCase loginUseCase;
    late AuthRepositoryImpl mockAuthRepositoryImpl;

    setUp(() {
      mockAuthRepositoryImpl = MockAuthRepositoryImpl();
      loginUseCase = LoginUseCase(authRepository: mockAuthRepositoryImpl);
    });

    const params = LoginParams(email: 'email', password: 'password');
    const loginResponse =
        LoginResponseEntity(id: 1, email: 'email', token: 'token');

    test("should return a login response from the repository", () async {
      ///Arrange
      when(() => mockAuthRepositoryImpl.login(any(), any())).thenAnswer(
          (_) async => const Right(
              LoginResponseEntity(id: 1, email: 'email', token: 'token')));

      ///Act
      final result = await loginUseCase.call(params);

      ///Assert
      expect(result, const Right(loginResponse));
      verify(() => mockAuthRepositoryImpl.login(params.email, params.password));
      verifyNoMoreInteractions(mockAuthRepositoryImpl);
    });
  });
}
