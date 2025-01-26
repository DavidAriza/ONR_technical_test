import 'package:flutter/material.dart';
import 'package:onr_technical_test/core/utils/app_colors.dart';
import 'package:onr_technical_test/features/shared/presentation/routes/app_router.dart';
import 'package:onr_technical_test/injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ONR Tech Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
