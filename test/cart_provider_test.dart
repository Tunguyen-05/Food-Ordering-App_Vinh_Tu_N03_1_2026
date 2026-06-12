import 'package:flutter_test/flutter_test.dart';
import 'package:foodorderingapp_vinh_tu_n03_1_2026/models/product.dart';
import 'package:foodorderingapp_vinh_tu_n03_1_2026/providers/cart_provider.dart';

void main() {
  group('CartProvider - Giỏ hàng', () {
    late CartProvider cart;
    late Product pho;

    setUp(() {
      cart = CartProvider();
      pho = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        category: 'Phở',
        imageUrl: '',
        description: '',
      );
    });

    test('Thêm món vào giỏ → số lượng = 1', () {
      cart.addToCart(pho);
      expect(cart.itemCount, 1);
      expect(cart.items.first.product.name, 'Phở Bò');
    });

    test('Thêm cùng món 2 lần → số lượng = 2', () {
      cart.addToCart(pho);
      cart.addToCart(pho);
      expect(cart.itemCount, 2);
    });

    test('Xóa món khỏi giỏ → giỏ trống', () {
      cart.addToCart(pho);
      cart.removeFromCart(pho.id!);
      expect(cart.itemCount, 0);
    });

    test('Tính tổng tiền đúng: (45000 × 2) + phí ship', () {
      cart.addToCart(pho, quantity: 2);
      expect(cart.subtotal, 90000);
      expect(cart.shippingFee, 10000);
      expect(cart.total, 100000);
    });
  });
}
