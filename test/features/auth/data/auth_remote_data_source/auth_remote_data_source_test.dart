import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onr_technical_test/core/error_handling/exception.dart';
import 'package:onr_technical_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:onr_technical_test/features/auth/data/models/login_response_model.dart';

class MockDioHttpCliente extends Mock implements Dio {}

void main() {
  late MockDioHttpCliente mockDioHttpCliente;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDioHttpCliente = MockDioHttpCliente();
    dataSource = AuthRemoteDataSourceImpl(httpClient: mockDioHttpCliente);
  });

  group('auth remote data source', () {
    test('should return a [LoginResponseModel] when dio request is successful',
        () async {
      const loginResponse =
          LoginResponseModel(id: 1, email: 'email', token: 'token');

      ///Arrange
      when(() => mockDioHttpCliente.post(
                any(),
                data: any(named: 'data'),
              ))
          .thenAnswer((_) async => Response(
              data: {'id': 1, 'email': 'email', 'token': 'token'},
              requestOptions: RequestOptions(path: ''),
              statusCode: 200));

      ///Act
      final result = await dataSource.login('email', 'password');

      ///Assert
      expect(result, equals(loginResponse));
    });
  });

  test("should return a [DioFailure] when dio request fails", () async {
    ///Arrange
    when(() => mockDioHttpCliente.post(
              any(),
              data: any(named: 'data'),
            ))
        .thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
                data: {'error': 'error'},
                statusCode: 400,
                requestOptions: RequestOptions(path: ''))));

    ///Act
    Object? error;
    try {
      await dataSource.login('email', 'password');
    } catch (e) {
      error = e;
    }

    ///Assert
    expect(error, isA<DioFailure>());
  });
}
