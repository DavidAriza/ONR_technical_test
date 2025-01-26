import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
