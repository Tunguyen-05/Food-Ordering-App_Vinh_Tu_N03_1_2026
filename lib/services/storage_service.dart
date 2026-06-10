import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';

class StorageService {
  static const String _usersBox = 'users';
  static const String _productsBox = 'products';
  static const String _ordersBox = 'orders';
  static const String _orderItemsBox = 'order_items';
  static const String _initBox = 'app_init';

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Hive.openBox(_usersBox);
    await Hive.openBox(_productsBox);
    await Hive.openBox(_ordersBox);
    await Hive.openBox(_orderItemsBox);
    await Hive.openBox(_initBox);
    _initialized = true;

    final initBox = Hive.box(_initBox);
    if (initBox.get('seeded') != true) {
      await _seedData();
      await initBox.put('seeded', true);
    }
  }

  static Future<void> _seedData() async {
    final usersBox = Hive.box(_usersBox);
    if (usersBox.isEmpty) {
      final admin = User(
        id: 1,
        phone: 'admin',
        password: 'admin123',
        name: 'Quản trị viên',
        isAdmin: true,
      );
      await usersBox.put(admin.phone, jsonEncode(admin.toMap()));
    }

    final productsBox = Hive.box(_productsBox);
    if (productsBox.isEmpty) {
      final defaultProducts = [
        Product(
          name: 'Phở Bò',
          price: 45000,
          description: 'Phở bò truyền thống với nước dùng đậm đà, thịt bò tái, nạm và bánh phở mềm mại.',
          imageUrl: 'https://cdn.tgdd.vn/Files/2022/01/25/1412805/cach-nau-pho-bo-nam-dinh-chuan-vi-thom-ngon-nhu-hang-quan-202201250313281452.jpg',
          category: 'Phở',
        ),
        Product(
          name: 'Phở Trâu',
          price: 55000,
          description: 'Phở trâu với thịt trâu mềm, nước dùng thanh ngọt, hấp dẫn.',
          imageUrl: 'https://i0.wp.com/amthucntfood.io.vn/wp-content/uploads/2025/10/thap-cam-dac-biet-bap-hoa.jpeg?fit=1184%2C880&ssl=1',
          category: 'Phở',
        ),
        Product(
          name: 'Phở Vịt',
          price: 60000,
          description: 'Phở vịt với thịt vịt mềm ngọt, nước dùng thơm ngon đặc biệt.',
          imageUrl: 'https://cdn-i2.congthuong.vn/stores/news_dataimages/2024/072024/04/21/phovit20240704210017.jpg?rt=20240704210018',
          category: 'Phở',
        ),
        Product(
          name: 'Bún Bò Huế',
          price: 50000,
          description: 'Bún bò Huế với nước dùng cay nồng, giò heo, thịt bò và rau muống chẻ.',
          imageUrl: 'https://vnaroma.com/wp-content/uploads/2020/10/bi-quyet-chuan-bi-gia-vi-nau-bun-bo-hue-chuan-vi-01.jpg',
          category: 'Bún',
        ),
        Product(
          name: 'Bún Chả',
          price: 45000,
          description: 'Bún chả Hà Nội với thịt nướng thơm lừng, nước mắm pha chua ngọt, đu đủ xanh.',
          imageUrl: 'https://cdn.zsoft.solutions/poseidon-web/app/media/uploaded-files/090724-bun-cha-ha-noi-buffet-poseidon-1.jpeg',
          category: 'Bún',
        ),
        Product(
          name: 'Bún Cá',
          price: 40000,
          description: 'Bún cá với cá thác lác tươi ngon, nước dùng thanh đạm.',
          imageUrl: 'https://cdn.tgdd.vn/Files/2021/09/11/1381884/cach-nau-bun-ca-ha-noi-thom-ngon-chuan-vi-202109111452323215.jpg',
          category: 'Bún',
        ),
        Product(
          name: 'Bún Đậu',
          price: 40000,
          description: 'Bún đậu mắm tôm với đậu rán giòn, thịt chân giò, dồi sụn.',
          imageUrl: 'https://cdn.tgdd.vn/2021/12/CookDish/cach-lam-bun-dau-mam-tom-ngon-ngat-ngay-an-mot-lan-la-ghien-avt-1200x675.jpg',
          category: 'Bún',
        ),
        Product(
          name: 'Cơm Gà',
          price: 40000,
          description: 'Cơm gà xào hấp dẫn với thịt gà mềm, rau củ tươi ngon.',
          imageUrl: 'https://beptruong.edu.vn/wp-content/uploads/2020/02/com-ga-tam-ky.jpg',
          category: 'Cơm',
        ),
        Product(
          name: 'Cơm Rang Dương Bò',
          price: 50000,
          description: 'Cơm rang dương bò với thịt bò mềm, trứng chiên và rau củ.',
          imageUrl: 'https://file.hstatic.net/200000700229/article/com-rang-dua-bo-1_c78e1d6016584fad95b103c52b999856.jpg',
          category: 'Cơm',
        ),
        Product(
          name: 'Trà Chanh',
          price: 5000,
          description: 'Trà chanh tươi mát, giải khát hoàn hảo cho ngày hè nóng bức.',
          imageUrl: 'https://www.unileverfoodsolutions.com.vn/dam/global-ufs/mcos/phvn/vietnam/calcmenu/recipes/VN-recipes/other/energizing-lemon-tea/main-header.jpg',
          category: 'Đồ Uống',
        ),
        Product(
          name: 'Nước Cam',
          price: 25000,
          description: 'Nước cam vắt tươi, giàu vitamin C, thơm ngon bổ dưỡng.',
          imageUrl: 'https://raumamix.com.vn/wp-content/uploads/2025/03/Nuoc-ep-Cam-Tuoi-1024x1024.png',
          category: 'Đồ Uống',
        ),
        Product(
          name: 'Nước Ép Dưa Hấu',
          price: 30000,
          description: 'Nước ép dưa hấu mát lạnh, ngọt tự nhiên, cực kỳ giải khát.',
          imageUrl: 'https://raumamix.com.vn/wp-content/uploads/2025/03/Nuoc-ep-Dua-Hau-Tuoi.png',
          category: 'Đồ Uống',
        ),
      ];

      for (int i = 0; i < defaultProducts.length; i++) {
        final p = defaultProducts[i];
        final productWithId = p.copyWith(id: i + 1);
        await productsBox.put(i + 1, jsonEncode(productWithId.toMap()));
      }
    }
  }

  // === USERS ===
  static Box get _users => Hive.box(_usersBox);

  static User? getUserByPhone(String phone) {
    final data = _users.get(phone);
    if (data == null) return null;
    return User.fromMap(jsonDecode(data));
  }

  static User? getUserById(int id) {
    for (final key in _users.keys) {
      final user = User.fromMap(jsonDecode(_users.get(key)));
      if (user.id == id) return user;
    }
    return null;
  }

  static User? loginUser(String phone, String password) {
    final user = getUserByPhone(phone);
    if (user != null && user.password == password) return user;
    return null;
  }

  static bool isPhoneExists(String phone) {
    return _users.containsKey(phone);
  }

  static int _nextUserId() {
    int maxId = 0;
    for (final key in _users.keys) {
      final user = User.fromMap(jsonDecode(_users.get(key)));
      if (user.id != null && user.id! > maxId) maxId = user.id!;
    }
    return maxId + 1;
  }

  static User registerUser(String phone, String password, String name) {
    final id = _nextUserId();
    final user = User(
      id: id,
      phone: phone,
      password: password,
      name: name,
      isAdmin: false,
    );
    _users.put(phone, jsonEncode(user.toMap()));
    return user;
  }

  static bool updateUserAddress(int userId, String address) {
    for (final key in _users.keys) {
      final map = jsonDecode(_users.get(key));
      if (map['id'] == userId) {
        map['address'] = address;
        _users.put(key, jsonEncode(map));
        return true;
      }
    }
    return false;
  }

  // === PRODUCTS ===
  static Box get _products => Hive.box(_productsBox);

  static List<Product> getAllProducts() {
    return _products.keys.map((key) {
      return Product.fromMap(jsonDecode(_products.get(key)));
    }).toList();
  }

  static List<Product> getProductsByCategory(String category) {
    return getAllProducts().where((p) => p.category == category).toList();
  }

  static List<String> getCategories() {
    final cats = getAllProducts().map((p) => p.category).toSet().toList();
    cats.sort();
    return cats;
  }

  static Product? getProductById(int id) {
    final data = _products.get(id);
    if (data == null) return null;
    return Product.fromMap(jsonDecode(data));
  }

  static int _nextProductId() {
    int maxId = 0;
    for (final key in _products.keys) {
      final id = int.tryParse(key.toString()) ?? 0;
      if (id > maxId) maxId = id;
    }
    return maxId + 1;
  }

  static int addProduct(Product product) {
    final id = _nextProductId();
    final pWithId = product.copyWith(id: id);
    _products.put(id, jsonEncode(pWithId.toMap()));
    return id;
  }

  static bool updateProduct(Product product) {
    if (product.id == null) return false;
    _products.put(product.id, jsonEncode(product.toMap()));
    return true;
  }

  static bool deleteProduct(int id) {
    _products.delete(id);
    return true;
  }

  // === ORDERS ===
  static Box get _orders => Hive.box(_ordersBox);
  static Box get _orderItems => Hive.box(_orderItemsBox);

  static int _nextOrderId() {
    int maxId = 0;
    for (final key in _orders.keys) {
      final id = int.tryParse(key.toString()) ?? 0;
      if (id > maxId) maxId = id;
    }
    return maxId + 1;
  }

  static int createOrder({
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
    final id = _nextOrderId();
    final order = Order(
      id: id,
      userId: userId,
      customerName: customerName,
      customerPhone: customerPhone,
      customerAddress: customerAddress,
      shippingType: shippingType,
      shippingFee: shippingFee,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      status: 'pending',
      createdAt: DateTime.now(),
    );
    _orders.put(id, jsonEncode(order.toMap()));

    for (final item in items) {
      final orderItem = OrderItem(
        orderId: id,
        productId: item.product.id!,
        productName: item.product.name,
        price: item.product.price,
        quantity: item.quantity,
      );
      _orderItems.add(jsonEncode(orderItem.toMap()));
    }

    return id;
  }

  static List<Order> getAllOrders() {
    final orders = _orders.keys.map((key) {
      return Order.fromMap(jsonDecode(_orders.get(key)));
    }).toList();
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return orders;
  }

  static List<Order> getOrdersByUserId(int userId) {
    return getAllOrders().where((o) => o.userId == userId).toList();
  }

  static List<OrderItem> getOrderItems(int orderId) {
    return _orderItems.keys.map((key) {
      final map = jsonDecode(_orderItems.get(key));
      if (map['order_id'] == orderId) {
        return OrderItem.fromMap(map);
      }
      return null;
    }).whereType<OrderItem>().toList();
  }

  static bool updateOrderStatus(int orderId, String status, {String? cancelReason}) {
    final data = _orders.get(orderId);
    if (data == null) return false;
    final map = jsonDecode(data);
    map['status'] = status;
    if (cancelReason != null) map['cancel_reason'] = cancelReason;
    _orders.put(orderId, jsonEncode(map));
    return true;
  }

  static Order? getOrderById(int id) {
    final data = _orders.get(id);
    if (data == null) return null;
    return Order.fromMap(jsonDecode(data));
  }
}
