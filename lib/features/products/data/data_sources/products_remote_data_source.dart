import 'package:dio/dio.dart';
import 'package:onr_technical_test/core/error_handling/error.dart';
import 'package:onr_technical_test/core/error_handling/exception.dart';
import 'package:onr_technical_test/features/products/data/models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio httpClient;

  ProductsRemoteDataSourceImpl({required this.httpClient});
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await httpClient.get('/products');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await httpClient.get('/products/$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ExceptionFailure.decode(
          Exception('Failed to load product: ${response.statusCode}'),
        );
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
