import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onr_technical_test/core/error_handling/exception.dart';
import 'package:onr_technical_test/core/use_case/login_params.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';
import 'package:onr_technical_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:onr_technical_test/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late AuthCubit authCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authCubit = AuthCubit(mockLoginUseCase);
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  tearDown(() {
    authCubit.close();
  });
  test('initial state should be AuthInitial', () {
    expect(authCubit.state, AuthInitial());
  });

  group('login', () {
    const loginResponse =
        LoginResponseEntity(id: 1, email: 'email', token: 'token');

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthLoaded] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any<LoginParams>()))
            .thenAnswer((_) async => const Right(loginResponse));
        return authCubit;
      },
      act: (cubit) => cubit.login('email', 'password'),
      expect: () => [
        AuthLoading(),
        const AuthLoaded(loginResponse),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any<LoginParams>())).called(1);
      },
    );
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthError] when login fails',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer((_) async => Left(
            DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: '')))));
        return authCubit;
      },
      act: (cubit) => cubit.login('email', 'password'),
      expect: () => [
        AuthLoading(),
        const AuthError(''),
      ],
    );
  });
}
