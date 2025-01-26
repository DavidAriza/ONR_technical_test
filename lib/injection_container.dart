import 'package:get_it/get_it.dart';
import 'package:onr_technical_test/core/http/dio_http_client.dart';
import 'package:onr_technical_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:onr_technical_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:onr_technical_test/features/auth/domain/repository/auth_repository.dart';
import 'package:onr_technical_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:onr_technical_test/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:onr_technical_test/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:onr_technical_test/features/products/data/repositories/products_repository_impl.dart';
import 'package:onr_technical_test/features/products/domain/repositories/products_repository.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:onr_technical_test/features/products/presentation/cubits/products_cubit/products_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ProductsCubit(sl(), sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  sl.registerLazySingleton(() => GetProductsUseCase(productRepository: sl()));
  sl.registerLazySingleton(
      () => GetProductByIdUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));

  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(productsRemoteDataSource: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));

  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(httpClient: DioHttpClient()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(httpClient: DioHttpClient()));
}
