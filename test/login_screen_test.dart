import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:foodorderingapp_vinh_tu_n03_1_2026/screens/login_screen.dart';
import 'package:foodorderingapp_vinh_tu_n03_1_2026/providers/auth_provider.dart';

Widget wrapWithMaterial(Widget child, AuthProvider auth) {
  return MaterialApp(
    home: ChangeNotifierProvider<AuthProvider>.value(
      value: auth,
      child: child,
    ),
  );
}

void main() {
  group('LoginScreen - Đăng nhập', () {
    testWidgets('Bỏ trống tài khoản → báo lỗi', (tester) async {
      final auth = AuthProvider();
      await tester.pumpWidget(wrapWithMaterial(const LoginScreen(), auth));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Đăng nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng nhập tài khoản'), findsOneWidget);
    });

    testWidgets('Bỏ trống mật khẩu → báo lỗi', (tester) async {
      final auth = AuthProvider();
      await tester.pumpWidget(wrapWithMaterial(const LoginScreen(), auth));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'admin');
      await tester.tap(find.text('Đăng nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    });
  });
}
