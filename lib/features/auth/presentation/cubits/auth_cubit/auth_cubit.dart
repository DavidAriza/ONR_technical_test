import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onr_technical_test/core/use_case/login_params.dart';
import 'package:onr_technical_test/features/auth/domain/entities/login_response_entity.dart';
import 'package:onr_technical_test/features/auth/domain/use_cases/login_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    final result =
        await loginUseCase.call(LoginParams(email: email, password: password));
    result.fold(
      (l) => emit(AuthError(l.message)),
      (loginResponse) => emit(AuthLoaded(loginResponse)),
    );
  }
}
