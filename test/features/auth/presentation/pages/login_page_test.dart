import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onr_technical_test/features/auth/presentation/pages/login/login_page.dart';
import 'package:onr_technical_test/features/products/presentation/pages/product_list/product_list_page.dart';
import 'package:onr_technical_test/features/shared/presentation/routes/app_router.dart';
import 'package:onr_technical_test/injection_container.dart' as di;

class MockDio extends Mock implements Dio {}

void main() {
  setUpAll(() {
    di.init();
  });

  testWidgets(
      'should expect the login page at the beggining since in this test we dont have data perssistance',
      (tester) async {
    final app = MaterialApp.router(
      routerConfig: appRouter,
    );

    await tester.pumpWidget(app);

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('should find the textfield for email and password',
      (tester) async {
    final app = MaterialApp.router(
      routerConfig: appRouter,
    );

    await tester.pumpWidget(app);

    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.byKey(const Key('password-field')), findsOneWidget);
  });

  testWidgets('should find error text when the email is invalid',
      (tester) async {
    final app = MaterialApp.router(
      routerConfig: appRouter,
    );

    await tester.pumpWidget(app);

    await tester.enterText(find.byKey(const Key('email-field')), 'email');
    await tester.enterText(find.byKey(const Key('password-field')), 'password');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets(
      'should find a [ProductListPage] when email is correct and password is not empty',
      (tester) async {
    final app = MaterialApp.router(
      routerConfig: appRouter,
    );

    await tester.pumpWidget(app);

    await tester.enterText(
        find.byKey(const Key('email-field')), 'email@email.com');
    await tester.enterText(find.byKey(const Key('password-field')), 'password');
    await tester.tap(find.byKey(const Key('login-button')));
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.byType(ProductListPage), findsOneWidget);
  });
}
