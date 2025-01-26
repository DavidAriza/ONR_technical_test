import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onr_technical_test/core/utils/app_colors.dart';
import 'package:onr_technical_test/core/utils/constants.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:onr_technical_test/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:onr_technical_test/features/products/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/leading.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_category.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_description.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_image.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_price.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_rating.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/widgets/product_title.dart';
import 'package:onr_technical_test/injection_container.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(
        sl<GetProductsUseCase>(),
        sl<GetProductByIdUseCase>(),
      )..getProductById(productId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is ProductDetailLoaded) {
              final product = state.product;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    leading: Leading(onTap: () => context.pop()),
                    backgroundColor: AppColors.background,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ProductImage(
                        imageUrl: product.image ?? Constants.noImage,
                        heroTag: product.id.toString(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitle(title: product.title ?? ''),
                          const SizedBox(height: 8),
                          ProductCategory(category: product.category ?? ''),
                          const SizedBox(height: 8),
                          ProductRating(
                            rate: product.rating?.rate ?? 0.0,
                            count: product.rating?.count ?? 0,
                          ),
                          const SizedBox(height: 16),
                          ProductPrice(price: product.price ?? 0.0),
                          const SizedBox(height: 16),
                          ProductDescription(
                              description: product.description ?? ''),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProductDetailError) {
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
                  'Unknown state',
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
