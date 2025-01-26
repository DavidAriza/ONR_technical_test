import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onr_technical_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:onr_technical_test/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:onr_technical_test/features/auth/presentation/pages/login/login_page.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_detail/product_detail_page.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_list/product_list_page.dart';
import 'package:onr_technical_test/injection_container.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      name: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(sl<LoginUseCase>()),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/products',
      name: '/products',
      builder: (context, state) => const ProductListPage(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailPage(productId: int.parse(productId));
          },
        ),
      ],
    ),
  ],
  initialLocation: '/login', // Start with the login screen
);
