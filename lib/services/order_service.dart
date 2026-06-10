import '../models/order.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';
import 'storage_service.dart';

class OrderService {
  int createOrder({
    required int userId,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String shippingType,
    required int shippingFee,
    required int totalAmount,
    required String paymentMethod,
    required List<CartItem> items,
  }) {
    return StorageService.createOrder(
      userId: userId,
      customerName: customerName,
      customerPhone: customerPhone,
      customerAddress: customerAddress,
      shippingType: shippingType,
      shippingFee: shippingFee,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      items: items,
    );
  }

  List<Order> getAllOrders() {
    return StorageService.getAllOrders();
  }

  List<Order> getOrdersByUserId(int userId) {
    return StorageService.getOrdersByUserId(userId);
  }

  List<OrderItem> getOrderItems(int orderId) {
    return StorageService.getOrderItems(orderId);
  }

  bool updateOrderStatus(int orderId, String status, {String? cancelReason}) {
    return StorageService.updateOrderStatus(orderId, status, cancelReason: cancelReason);
  }

  Order? getOrderById(int id) {
    return StorageService.getOrderById(id);
  }
}
