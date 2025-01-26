import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/core/error_handling/failure.dart';
import 'package:onr_technical_test/core/use_case/no_params.dart';
import 'package:onr_technical_test/core/use_case/use_case.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';
import 'package:onr_technical_test/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductsRepository productRepository;

  GetProductsUseCase({required this.productRepository});
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await productRepository.getProducts();
  }
}
