import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onr_technical_test/core/use_case/no_params.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_products_use_case.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  ProductsCubit(this.getProductsUseCase, this.getProductByIdUseCase)
      : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductsLoading());

    final result = await getProductsUseCase.call(NoParams());
    result.fold(
      (l) => emit(ProductsError(l.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> getProductById(int id) async {
    emit(ProductDetailLoading());

    final result = await getProductByIdUseCase.call(id);
    result.fold(
      (failure) => emit(ProductDetailError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
