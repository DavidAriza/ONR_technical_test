import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onr_technical_test/core/utils/app_colors.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:onr_technical_test/features/products/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_list/widgets/product_card.dart';
import 'package:onr_technical_test/injection_container.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.background,
        child: BlocBuilder<ProductsCubit, ProductsState>(
          bloc: sl<ProductsCubit>(),
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return const Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ProductCard(
                      product: product,
                      onTap: () => context.push('/products/${product.id}'),
                    ),
                  );
                },
              );
            } else if (state is ProductsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
