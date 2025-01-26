part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductDetailLoading extends ProductsState {}

class ProductDetailLoaded extends ProductsState {
  final ProductEntity product;

  const ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductsState {
  final String message;

  const ProductDetailError(this.message);
}
