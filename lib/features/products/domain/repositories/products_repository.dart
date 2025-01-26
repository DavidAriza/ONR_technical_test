import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> getProductById(int id);
}
