import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';
import 'package:onr_technical_test/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({required this.productsRemoteDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final response = await productsRemoteDataSource.getProducts();
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final productModel = await productsRemoteDataSource.getProductById(id);
      return Right(productModel);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
