import 'package:dartz/dartz.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';
import 'package:onr_technical_test/features/products/domain/repositories/products_repository.dart';

import '../../../../core/error_handling/failure.dart';
import '../../../../core/use_case/use_case.dart';

class GetProductByIdUseCase implements UseCase<ProductEntity, int> {
  final ProductsRepository productRepository;

  GetProductByIdUseCase({required this.productRepository});
  @override
  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await productRepository.getProductById(id);
  }
}
