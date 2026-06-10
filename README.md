# 🍜 Ứng Dụng Đặt Thức Ăn – Food Ordering App

## Thông tin nhóm

| Họ tên | MSSV | Vai trò |
|---|---|---|
| Lê Quang Vinh | 23010507 | User screens, giao diện người dùng, quản lý đơn hàng|
| Nguyễn Anh Tú | 23010645 | Admin screens |

---

## 1. Tổng quan dự án

**Tên dự án:** Food Ordering App
**Công nghệ:** Flutter (Dart)
**Cơ sở dữ liệu cục bộ:** Hive (NoSQL, lưu trữ offline)
**Ngôn ngữ lập trình:** Dart

Ứng dụng đặt thức ăn trên thiết bị di động với hai vai trò chính: **người dùng** (khách hàng đặt món) và **quản trị viên** (quản lý sản phẩm và đơn hàng).

### Chức năng chính

**Người dùng:**
- Đăng ký / đăng nhập bằng số điện thoại
- Xem danh sách món ăn theo danh mục (Phở, Bún, Cơm, Đồ Uống)
- Xem chi tiết món ăn
- Thêm món vào giỏ hàng, tăng/giảm số lượng
- Đặt hàng với thông tin giao hàng và phương thức thanh toán
- Xem lịch sử đơn hàng, hủy đơn đang chờ
- Xem và chỉnh sửa thông tin cá nhân

**Quản trị viên:**
- Đăng nhập tài khoản admin
- Quản lý sản phẩm (xem danh sách)
- Cập nhật trạng thái đơn hàng (đang chờ → đang nấu → đang giao → hoàn thành / hủy)

### Kiến trúc ứng dụng

```
lib/
├── main.dart                    # Điểm khởi đầu, khởi tạo Hive
├── models/                      # Data models
│   ├── product.dart            # Model sản phẩm
│   ├── user.dart               # Model người dùng
│   ├── order.dart              # Model đơn hàng
│   ├── cart_item.dart          # Model item trong giỏ hàng
│   └── order_item.dart         # Model item trong đơn hàng
├── providers/                  # State management (ChangeNotifier)
│   ├── auth_provider.dart      # Quản lý trạng thái đăng nhập
│   └── cart_provider.dart       # Quản lý giỏ hàng
├── services/                   # Business logic layer
│   ├── storage_service.dart    # Seed data, khởi tạo Hive boxes
│   ├── auth_service.dart       # Xử lý đăng nhập/đăng ký
│   ├── product_service.dart    # CRUD sản phẩm
│   └── order_service.dart      # CRUD đơn hàng
├── screens/                    # Auth screens
│   ├── login_screen.dart
│   └── register_screen.dart
├── user/                       # User screens
│   ├── main_user_screen.dart
│   ├── user_home_screen.dart
│   ├── user_cart_screen.dart
│   ├── checkout_screen.dart
│   ├── user_orders_screen.dart
│   └── user_profile_screen.dart
└── admin/                      # Admin screens
    ├── admin_main_screen.dart
    ├── admin_products_screen.dart
    └── admin_orders_screen.dart
```

---

## 2. User Stories

### 2.1. Người dùng (Khách hàng)

| ID | Mô tả nghiệp vụ | Tiêu chí hoàn thành (Definition of Done) |
|---|---|---|
| US-01 | Là khách hàng, tôi muốn **đăng ký tài khoản** bằng số điện thoại và mật khẩu để có thể sử dụng ứng dụng | - Nhập số điện thoại chưa đăng ký + mật khẩu → tài khoản được tạo, chuyển sang màn hình chính<br>- Nhập số điện thoại đã tồn tại → hiển thị thông báo lỗi |
| US-02 | Là khách hàng, tôi muốn **đăng nhập** bằng số điện thoại và mật khẩu để truy cập vào ứng dụng | - Thông tin đúng → chuyển sang màn hình chính<br>- Thông tin sai → hiển thị thông báo "Số điện thoại hoặc mật khẩu không đúng" |
| US-03 | Là khách hàng, tôi muốn **xem danh sách món ăn** theo danh mục để chọn món phù hợp | - Hiển thị danh sách món với hình ảnh, tên, giá, mô tả<br>- Có thể lọc theo danh mục: Phở, Bún, Cơm, Đồ Uống |
| US-04 | Là khách hàng, tôi muốn **xem chi tiết món ăn** để biết thêm thông tin trước khi đặt | - Màn hình chi tiết hiển thị hình ảnh lớn, tên, giá, mô tả đầy đủ |
| US-05 | Là khách hàng, tôi muốn **thêm món vào giỏ hàng** để chuẩn bị đặt hàng | - Nhấn nút "Thêm vào giỏ" → món được thêm, giỏ hàng cập nhật số lượng item<br>- Tăng/giảm số lượng trong giỏ hàng<br>- Xóa món khỏi giỏ hàng |
| US-06 | Là khách hàng, tôi muốn **đặt hàng** với thông tin giao hàng và phương thức thanh toán | - Nhập tên, số điện thoại, địa chỉ giao hàng<br>- Chọn loại giao hàng (mang đi / giao tận nơi) và phương thức thanh toán (tiền mặt / chuyển khoản)<br>- Xác nhận đặt hàng → đơn hàng được tạo, giỏ hàng được xóa |
| US-07 | Là khách hàng, tôi muốn **xem lịch sử đơn hàng** để theo dõi các đơn đã đặt | - Hiển thị danh sách đơn hàng với trạng thái: đang chờ, đang nấu, đang giao, hoàn thành, đã hủy |
| US-08 | Là khách hàng, tôi muốn **hủy đơn hàng** đang chờ xác nhận | - Chỉ đơn hàng ở trạng thái "đang chờ" mới có thể hủy<br>- Nhập lý do hủy → đơn được cập nhật trạng thái "đã hủy" |
| US-09 | Là khách hàng, tôi muốn **xem và chỉnh sửa thông tin cá nhân** | - Hiển thị tên, số điện thoại, địa chỉ hiện tại<br>- Có thể cập nhật thông tin và lưu lại |

### 2.2. Quản trị viên (Admin)

| ID | Mô tả nghiệp vụ | Tiêu chí hoàn thành (Definition of Done) |
|---|---|---|
| US-10 | Là quản trị viên, tôi muốn **đăng nhập admin** để truy cập trang quản trị | - Đăng nhập bằng tài khoản admin cố định → chuyển sang màn hình quản trị |
| US-11 | Là quản trị viên, tôi muốn **xem danh sách sản phẩm** để theo dõi thực đơn | - Hiển thị toàn bộ sản phẩm với hình ảnh, tên, giá, danh mục |
| US-12 | Là quản trị viên, tôi muốn **xem danh sách đơn hàng** để quản lý đơn hàng từ khách | - Hiển thị tất cả đơn hàng với trạng thái, thông tin khách hàng, tổng tiền |
| US-13 | Là quản trị viên, tôi muốn **cập nhật trạng thái đơn hàng** để thông báo tiến độ cho khách | - Chuyển trạng thái: đang chờ → đang nấu → đang giao → hoàn thành<br>- Hủy đơn hàng kèm lý do |

---

## 3. Phân Tích Yêu Cầu, Đối Tượng Và Quan Hệ

### 3.1. Các yêu cầu chức năng

| Mã | Yêu cầu | Tính năng tương ứng |
|---|---|---|
| FR-01 | Hệ thống phải cho phép người dùng đăng ký và đăng nhập | Đăng ký / Đăng nhập (US-01, US-02) |
| FR-02 | Hệ thống phải hiển thị danh sách món ăn với thông tin đầy đủ | Trang chủ, danh sách món (US-03) |
| FR-03 | Hệ thống phải cho phép người dùng xem chi tiết từng món | Chi tiết món (US-04) |
| FR-04 | Hệ thống phải hỗ trợ giỏ hàng: thêm, tăng/giảm, xóa món | Giỏ hàng (US-05) |
| FR-05 | Hệ thống phải cho phép đặt hàng với đầy đủ thông tin | Checkout (US-06) |
| FR-06 | Hệ thống phải cho phép người dùng xem và hủy đơn hàng của mình | Lịch sử đơn hàng (US-07, US-08) |
| FR-07 | Hệ thống phải cho phép admin quản lý đơn hàng và sản phẩm | Trang quản trị (US-10, US-11, US-12, US-13) |
| FR-08 | Hệ thống phải lưu trữ dữ liệu cục bộ để ứng dụng hoạt động offline | Hive Database |

### 3.2. Các yêu cầu phi chức năng

| Mã | Yêu cầu |
|---|---|
| NFR-01 | Ứng dụng chạy trên nền tảng Android |
| NFR-02 | Giao diện thân thiện, dễ sử dụng trên thiết bị di động |
| NFR-03 | Dữ liệu được lưu trữ cục bộ bằng Hive, đảm bảo truy xuất nhanh |
| NFR-04 | Phân tách rõ ràng giữa người dùng và quản trị viên |

### 3.3. Các thực thể (Entities)

```
┌──────────────────┐
│       User       │
├──────────────────┤
│ id (PK)          │
│ phone            │
│ password         │
│ name             │
│ address          │
│ isAdmin          │
└──────────────────┘
          │
          │ 1:N
          ▼
┌──────────────────┐
│      Order       │
├──────────────────┤
│ id (PK)          │
│ userId (FK)      │
│ customerName     │
│ customerPhone    │
│ customerAddress  │
│ shippingType     │
│ shippingFee      │
│ totalAmount      │
│ paymentMethod    │
│ status           │
│ cancelReason     │
│ createdAt        │
└──────────────────┘
          │
          │ 1:N
          ▼
┌──────────────────┐
│    OrderItem     │
├──────────────────┤
│ id (PK)          │
│ orderId (FK)     │
│ productId        │
│ productName      │
│ productPrice     │
│ productImageUrl  │
│ quantity         │
│ totalPrice       │
└──────────────────┘

┌──────────────────┐
│     Product      │
├──────────────────┤
│ id (PK)          │
│ name             │
│ price            │
│ description      │
│ imageUrl         │
│ category         │
└──────────────────┘

┌──────────────────┐
│    CartItem      │
├──────────────────┤
│ (Product) ref    │  ← Liên kết đến Product
│ quantity         │
│ totalPrice       │
└──────────────────┘
```

### 3.4. Mối quan hệ giữa các thực thể

| Thực thể 1 | Quan hệ | Thực thể 2 | Mô tả |
|---|---|---|---|
| User | 1 : N | Order | Một người dùng có thể có nhiều đơn hàng |
| Order | 1 : N | OrderItem | Một đơn hàng chứa nhiều item |
| Product | 1 : N | OrderItem | Một sản phẩm có thể xuất hiện trong nhiều order item |
| Product | 1 : N | CartItem | Một sản phẩm có thể được thêm vào nhiều cart item |

---

## 4. Class Diagram

### 4.1. Models

```
┌─────────────────────────────────┐
│           Product               │
├─────────────────────────────────┤
│ + id: int?                      │
│ + name: String                  │
│ + price: int                     │
│ + description: String           │
│ + imageUrl: String              │
│ + category: String              │
├─────────────────────────────────┤
│ + toMap(): Map<String,dynamic>  │
│ + fromMap(map): Product         │
│ + copyWith(...): Product        │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│             User                │
├─────────────────────────────────┤
│ + id: int?                      │
│ + phone: String                 │
│ + password: String              │
│ + name: String                  │
│ + address: String              │
│ + isAdmin: bool                 │
├─────────────────────────────────┤
│ + toMap(): Map<String,dynamic>  │
│ + fromMap(map): User            │
│ + copyWith(...): User           │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│            Order                │
├─────────────────────────────────┤
│ + id: int?                      │
│ + userId: int                   │
│ + customerName: String          │
│ + customerPhone: String         │
│ + customerAddress: String      │
│ + shippingType: String         │
│ + shippingFee: int              │
│ + totalAmount: int             │
│ + paymentMethod: String        │
│ + status: String                │
│ + cancelReason: String?         │
│ + createdAt: DateTime          │
├─────────────────────────────────┤
│ + toMap(): Map<String,dynamic>  │
│ + fromMap(map): Order           │
│ + copyWith(...): Order         │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│          OrderItem              │
├─────────────────────────────────┤
│ + id: int?                      │
│ + orderId: int                  │
│ + productId: int                │
│ + productName: String           │
│ + productPrice: int             │
│ + productImageUrl: String       │
│ + quantity: int                 │
│ + totalPrice: int              │
├─────────────────────────────────┤
│ + toMap(): Map<String,dynamic>  │
│ + fromMap(map): OrderItem       │
│ + copyWith(...): OrderItem      │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│          CartItem               │
├─────────────────────────────────┤
│ + product: Product               │
│ + quantity: int                 │
├─────────────────────────────────┤
│ + totalPrice: int (computed)    │
└─────────────────────────────────┘
```

### 4.2. Services

```
┌─────────────────────────────────┐
│       StorageService            │
├─────────────────────────────────┤
│ - productsBox: Box<Product>     │
│ - usersBox: Box<User>            │
│ - ordersBox: Box<Order>         │
├─────────────────────────────────┤
│ + initData(): Future<void>       │
│ + seedProducts(): void           │
│ + seedAdminUser(): void          │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│         AuthService             │
├─────────────────────────────────┤
│ + register(...): Future<bool>    │
│ + login(...): Future<User?>      │
│ + getUserById(id): User?        │
│ + updateUser(...): Future<void>  │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│       ProductService            │
├─────────────────────────────────┤
│ + getAllProducts(): List<Product>│
│ + getProductsByCategory(...): List│
│ + getProductById(id): Product?  │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│         OrderService            │
├─────────────────────────────────┤
│ + createOrder(...): Future<void> │
│ + getOrdersByUserId(...): List   │
│ + getAllOrders(): List<Order>   │
│ + updateOrderStatus(...): Future│
│ + cancelOrder(...): Future<void>│
└─────────────────────────────────┘
```

### 4.3. Providers (State Management)

```
┌─────────────────────────────────┐
│        AuthProvider             │
│     (ChangeNotifier)            │
├─────────────────────────────────┤
│ - currentUser: User?             │
├─────────────────────────────────┤
│ + login(...): Future<void>       │
│ + register(...): Future<void>    │
│ + logout(): void                 │
│ + updateProfile(...): Future<void>│
└─────────────────────────────────┘

┌─────────────────────────────────┐
│        CartProvider             │
│     (ChangeNotifier)            │
├─────────────────────────────────┤
│ - items: List<CartItem>          │
├─────────────────────────────────┤
│ + addProduct(...): void          │
│ + removeProduct(id): void        │
│ + incrementQuantity(...): void   │
│ + decrementQuantity(...): void   │
│ + clearCart(): void              │
│ + get totalAmount: int           │
│ + get itemCount: int             │
└─────────────────────────────────┘
```

### 4.4. Quan hệ giữa các lớp

```
┌────────────────────┐     ┌────────────────────┐
│  AuthProvider      │────▶│  AuthService      │
└────────────────────┘     └────────────────────┘
         │                           │
         ▼                           ▼
┌────────────────────┐     ┌────────────────────┐
│   CartProvider     │────▶│  ProductService    │
└────────────────────┘     └────────────────────┘
         │                           │
         ▼                           ▼
┌────────────────────┐     ┌────────────────────┐
│  CheckoutScreen   │────▶│  OrderService       │
└────────────────────┘     └────────────────────┘
                                        │
                                        ▼
                               ┌────────────────────┐
                               │ StorageService     │
                               │ (Hive Boxes)       │
                               └────────────────────┘
                                        │
              ┌─────────────────────────┼─────────────────────────┐
              ▼                         ▼                         ▼
      ┌───────────────┐         ┌───────────────┐         ┌───────────────┐
      │  Product Box   │         │   User Box    │         │  Order Box    │
      └───────────────┘         └───────────────┘         └───────────────┘
```

---

## 5–7. Screens Design / Firebase / Git (Tự làm)

*(Phần này sinh viên tự hoàn thiện)*

---

## 8. Kiểm Thử Và Đơn Vị Test

### 8.0. Hướng Dẫn Chạy Kiểm Thử

#### Bước 1: Tạo cấu trúc thư mục test

Trong thư mục `test/` của dự án, tạo cấu trúc như sau:

```
test/
├── models/
│   ├── product_test.dart
│   ├── order_test.dart
│   ├── user_test.dart
│   └── cart_item_test.dart
├── services/
│   ├── product_service_test.dart
│   ├── order_service_test.dart
│   └── auth_service_test.dart
└── widgets/
    └── user_home_screen_test.dart
```

> **Cách tạo nhanh bằng terminal (PowerShell):**
> ```powershell
> cd D:\Food-Ordering-App_Vinh_Tu_N03_1_2026
> mkdir test\models, test\services, test\widgets -Force
> ```

#### Bước 2: Tạo file test từng phần

Copy nội dung test code từ các mục **8.2.x** và **8.3** trong README này vào từng file tương ứng bên dưới.

#### Bước 3: Chạy tất cả các test

```powershell
flutter test
```

#### Bước 4: Chạy test theo nhóm

```powershell
# Chỉ test models
flutter test test/models/

# Chỉ test services
flutter test test/services/

# Chỉ test widgets
flutter test test/widgets/
```

#### Bước 5: Chạy một file test cụ thể

```powershell
# Test Product model
flutter test test/models/product_test.dart

# Test Order model
flutter test test/models/order_test.dart

# Test AuthService
flutter test test/services/auth_service_test.dart
```

#### Bước 6: Xem kết quả chi tiết

```powershell
# Chạy với thông tin verbose
flutter test --reporter expanded
```

#### Lưu ý quan trọng

- **Hive cần được khởi tạo trước khi chạy test service**: mỗi `setUp()` đã gọi `StorageService.init()` để đảm bảo Hive sẵn sàng.
- **Nếu gặp lỗi `Hive is not initialized`**: kiểm tra lại dòng `StorageService.init()` trong `setUp()` của mỗi group test.
- **Widget test cần Provider**: đã setup `MultiProvider` đúng cách trong mỗi `testWidgets`.
- **Để test chạy nhanh hơn**: chạy `flutter test --concurrency=4` để chạy song song.

---

### 8.1. Chiến lược kiểm thử

| Cấp độ | Mô tả | Phạm vi |
|---|---|---|
| Unit Test | Kiểm thử từng hàm / phương thức riêng lẻ | Models, Services |
| Widget Test | Kiểm thử giao diện người dùng | Các màn hình chính |
| Integration Test | Kiểm thử luồng nghiệp vụ end-to-end | Đặt hàng, đăng nhập |

### 8.2. Unit Tests

#### 8.2.1. Product Model Tests

```dart
// test/models/product_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/product.dart';

void main() {
  group('Product Model', () {
    test('toMap() chuyển đổi Product thành Map đúng cách', () {
      final product = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        description: 'Phở bò truyền thống',
        imageUrl: 'https://example.com/phobo.jpg',
        category: 'Phở',
      );

      final map = product.toMap();

      expect(map['id'], 1);
      expect(map['name'], 'Phở Bò');
      expect(map['price'], 45000);
      expect(map['description'], 'Phở bò truyền thống');
      expect(map['image_url'], 'https://example.com/phobo.jpg');
      expect(map['category'], 'Phở');
    });

    test('fromMap() tạo Product từ Map đúng cách', () {
      final map = {
        'id': 2,
        'name': 'Bún Chả',
        'price': 45000,
        'description': 'Bún chả Hà Nội',
        'image_url': 'https://example.com/buncha.jpg',
        'category': 'Bún',
      };

      final product = Product.fromMap(map);

      expect(product.id, 2);
      expect(product.name, 'Bún Chả');
      expect(product.price, 45000);
      expect(product.description, 'Bún chả Hà Nội');
      expect(product.imageUrl, 'https://example.com/buncha.jpg');
      expect(product.category, 'Bún');
    });

    test('copyWith() tạo bản sao với giá trị mới', () {
      final product = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        description: 'Phở bò truyền thống',
        imageUrl: 'https://example.com/phobo.jpg',
        category: 'Phở',
      );

      final updated = product.copyWith(price: 50000, name: 'Phở Bò Đặc Biệt');

      expect(updated.id, 1);
      expect(updated.name, 'Phở Bò Đặc Biệt');
      expect(updated.price, 50000);
      expect(updated.description, 'Phở bò truyền thống');
    });

    test('copyWith() giữ nguyên giá trị cũ khi không truyền tham số', () {
      final product = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        description: 'Phở bò truyền thống',
        imageUrl: 'https://example.com/phobo.jpg',
        category: 'Phở',
      );

      final copy = product.copyWith();

      expect(copy.name, product.name);
      expect(copy.price, product.price);
      expect(copy.description, product.description);
    });
  });
}
```

#### 8.2.2. Order Model Tests

```dart
// test/models/order_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/order.dart';

void main() {
  group('Order Model', () {
    test('toMap() chuyển đổi Order thành Map đúng cách', () {
      final order = Order(
        id: 1,
        userId: 1,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0909123456',
        customerAddress: '123 Đường ABC, Quận 1, TP.HCM',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime(2024, 6, 1, 10, 30),
      );

      final map = order.toMap();

      expect(map['id'], 1);
      expect(map['userId'], 1);
      expect(map['customerName'], 'Nguyễn Văn A');
      expect(map['customerPhone'], '0909123456');
      expect(map['shippingType'], 'Giao tận nơi');
      expect(map['shippingFee'], 15000);
      expect(map['totalAmount'], 60000);
      expect(map['paymentMethod'], 'Tiền mặt');
      expect(map['status'], 'Đang chờ');
    });

    test('fromMap() tạo Order từ Map đúng cách', () {
      final map = {
        'id': 2,
        'user_id': 1,
        'customer_name': 'Trần Văn B',
        'customer_phone': '0912345678',
        'customer_address': '456 Đường XYZ, Quận 2, TP.HCM',
        'shipping_type': 'Mang đi',
        'shipping_fee': 0,
        'total_amount': 85000,
        'payment_method': 'Chuyển khoản',
        'status': 'Đang nấu',
        'cancel_reason': null,
        'created_at': '2024-06-01T11:00:00.000',
      };

      final order = Order.fromMap(map);

      expect(order.id, 2);
      expect(order.userId, 1);
      expect(order.customerName, 'Trần Văn B');
      expect(order.shippingType, 'Mang đi');
      expect(order.shippingFee, 0);
      expect(order.status, 'Đang nấu');
    });

    test('copyWith() cập nhật trạng thái đơn hàng', () {
      final order = Order(
        id: 1,
        userId: 1,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0909123456',
        customerAddress: '123 ABC',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime(2024, 6, 1),
      );

      final updated = order.copyWith(status: 'Đang nấu');

      expect(updated.status, 'Đang nấu');
      expect(updated.id, 1);
      expect(updated.customerName, 'Nguyễn Văn A');
    });

    test('copyWith() cập nhật lý do hủy đơn', () {
      final order = Order(
        id: 1,
        userId: 1,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0909123456',
        customerAddress: '123 ABC',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime(2024, 6, 1),
      );

      final cancelled = order.copyWith(
        status: 'Đã hủy',
        cancelReason: 'Khách hàng thay đổi ý kiến',
      );

      expect(cancelled.status, 'Đã hủy');
      expect(cancelled.cancelReason, 'Khách hàng thay đổi ý kiến');
    });
  });
}
```

#### 8.2.3. User Model Tests

```dart
// test/models/user_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/user.dart';

void main() {
  group('User Model', () {
    test('toMap() chuyển đổi User thành Map với isAdmin = true', () {
      final user = User(
        id: 1,
        phone: '0909123456',
        password: 'hashed_password',
        name: 'Nguyễn Văn A',
        address: '123 Đường ABC',
        isAdmin: true,
      );

      final map = user.toMap();

      expect(map['id'], 1);
      expect(map['phone'], '0909123456');
      expect(map['name'], 'Nguyễn Văn A');
      expect(map['is_admin'], 1);
    });

    test('toMap() chuyển đổi User thành Map với isAdmin = false', () {
      final user = User(
        id: 2,
        phone: '0912345678',
        password: 'hashed_pass',
        name: 'Trần Thị B',
        isAdmin: false,
      );

      final map = user.toMap();

      expect(map['is_admin'], 0);
    });

    test('fromMap() tạo User từ Map đúng cách', () {
      final map = {
        'id': 1,
        'phone': '0909123456',
        'password': 'hashed_password',
        'name': 'Nguyễn Văn A',
        'address': '123 Đường ABC',
        'is_admin': 0,
      };

      final user = User.fromMap(map);

      expect(user.id, 1);
      expect(user.phone, '0909123456');
      expect(user.name, 'Nguyễn Văn A');
      expect(user.isAdmin, false);
    });

    test('fromMap() xử lý address null một cách an toàn', () {
      final map = {
        'id': 1,
        'phone': '0909123456',
        'password': 'hashed_password',
        'name': 'Nguyễn Văn A',
        'address': null,
        'is_admin': 0,
      };

      final user = User.fromMap(map);

      expect(user.address, '');
    });

    test('copyWith() cập nhật thông tin cá nhân', () {
      final user = User(
        id: 1,
        phone: '0909123456',
        password: 'hashed_password',
        name: 'Nguyễn Văn A',
        address: '123 Đường ABC',
        isAdmin: false,
      );

      final updated = user.copyWith(
        name: 'Nguyễn Văn A (Updated)',
        address: '456 Đường XYZ',
      );

      expect(updated.name, 'Nguyễn Văn A (Updated)');
      expect(updated.address, '456 Đường XYZ');
      expect(updated.phone, '0909123456');
    });
  });
}
```

#### 8.2.4. CartItem Model Tests

```dart
// test/models/cart_item_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/cart_item.dart';
import 'package:food_ordering_app/models/product.dart';

void main() {
  group('CartItem Model', () {
    test('totalPrice tính đúng với số lượng mặc định (1)', () {
      final product = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        description: 'Phở bò truyền thống',
        imageUrl: 'https://example.com/phobo.jpg',
        category: 'Phở',
      );

      final cartItem = CartItem(product: product);

      expect(cartItem.totalPrice, 45000);
    });

    test('totalPrice tính đúng với số lượng > 1', () {
      final product = Product(
        id: 1,
        name: 'Phở Bò',
        price: 45000,
        description: 'Phở bò truyền thống',
        imageUrl: 'https://example.com/phobo.jpg',
        category: 'Phở',
      );

      final cartItem = CartItem(product: product, quantity: 3);

      expect(cartItem.totalPrice, 135000);
    });

    test('quantity mặc định là 1 khi không truyền', () {
      final product = Product(
        id: 1,
        name: 'Bún Chả',
        price: 45000,
        description: 'Bún chả Hà Nội',
        imageUrl: 'https://example.com/buncha.jpg',
        category: 'Bún',
      );

      final cartItem = CartItem(product: product);

      expect(cartItem.quantity, 1);
    });

    test('quantity có thể thay đổi sau khi tạo', () {
      final product = Product(
        id: 1,
        name: 'Trà Chanh',
        price: 5000,
        description: 'Trà chanh mát lạnh',
        imageUrl: 'https://example.com/trachanh.jpg',
        category: 'Đồ Uống',
      );

      final cartItem = CartItem(product: product);
      cartItem.quantity = 5;

      expect(cartItem.totalPrice, 25000);
    });
  });
}
```

#### 8.2.5. ProductService Tests

```dart
// test/services/product_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/services/product_service.dart';

void main() {
  group('ProductService', () {
    late ProductService productService;

    setUp(() {
      productService = ProductService();
    });

    test('getAllProducts() trả về danh sách sản phẩm', () {
      final products = productService.getAllProducts();

      expect(products, isA<List<Product>>());
      expect(products.isNotEmpty, true);
    });

    test('getProductsByCategory("Phở") trả về đúng các sản phẩm Phở', () {
      final phoProducts = productService.getProductsByCategory('Phở');

      for (final product in phoProducts) {
        expect(product.category, 'Phở');
      }
    });

    test('getProductsByCategory("Bún") trả về đúng các sản phẩm Bún', () {
      final bunProducts = productService.getProductsByCategory('Bún');

      for (final product in bunProducts) {
        expect(product.category, 'Bún');
      }
    });

    test('getProductsByCategory("Không tồn tại") trả về danh sách rỗng', () {
      final products = productService.getProductsByCategory('Không tồn tại');

      expect(products, isEmpty);
    });

    test('getProductById() trả về sản phẩm đúng với ID hợp lệ', () {
      final allProducts = productService.getAllProducts();

      if (allProducts.isNotEmpty) {
        final firstProduct = allProducts.first;
        final found = productService.getProductById(firstProduct.id!);

        expect(found, isNotNull);
        expect(found!.name, firstProduct.name);
      }
    });

    test('getProductById() trả về null với ID không hợp lệ', () {
      final found = productService.getProductById(9999);

      expect(found, isNull);
    });
  });
}
```

#### 8.2.6. OrderService Tests

```dart
// test/services/order_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/services/order_service.dart';
import 'package:food_ordering_app/services/storage_service.dart';

void main() {
  group('OrderService', () {
    late OrderService orderService;

    setUp(() {
      StorageService.init();
      orderService = OrderService();
    });

    test('createOrder() tạo đơn hàng thành công', () async {
      final order = Order(
        userId: 1,
        customerName: 'Test User',
        customerPhone: '0909123456',
        customerAddress: 'Test Address',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime.now(),
      );

      await orderService.createOrder(order, []);

      final orders = orderService.getOrdersByUserId(1);
      expect(orders.isNotEmpty, true);
    });

    test('getOrdersByUserId() trả về đơn hàng đúng người dùng', () {
      final orders = orderService.getOrdersByUserId(1);

      for (final order in orders) {
        expect(order.userId, 1);
      }
    });

    test('getOrdersByUserId(999) trả về danh sách rỗng cho user không tồn tại', () {
      final orders = orderService.getOrdersByUserId(999);

      expect(orders, isEmpty);
    });

    test('getAllOrders() trả về tất cả đơn hàng', () {
      final allOrders = orderService.getAllOrders();

      expect(allOrders, isA<List<Order>>());
    });

    test('updateOrderStatus() cập nhật trạng thái đơn hàng', () async {
      final order = Order(
        userId: 1,
        customerName: 'Test User',
        customerPhone: '0909123456',
        customerAddress: 'Test Address',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime.now(),
      );

      await orderService.createOrder(order, []);

      final createdOrders = orderService.getAllOrders();
      if (createdOrders.isNotEmpty) {
        final createdOrder = createdOrders.last;
        await orderService.updateOrderStatus(createdOrder.id!, 'Đang nấu');

        final updated = orderService.getAllOrders()
            .firstWhere((o) => o.id == createdOrder.id);

        expect(updated.status, 'Đang nấu');
      }
    });

    test('cancelOrder() hủy đơn với lý do', () async {
      final order = Order(
        userId: 1,
        customerName: 'Test User',
        customerPhone: '0909123456',
        customerAddress: 'Test Address',
        shippingType: 'Giao tận nơi',
        shippingFee: 15000,
        totalAmount: 60000,
        paymentMethod: 'Tiền mặt',
        status: 'Đang chờ',
        createdAt: DateTime.now(),
      );

      await orderService.createOrder(order, []);

      final createdOrders = orderService.getAllOrders();
      if (createdOrders.isNotEmpty) {
        final createdOrder = createdOrders.last;
        await orderService.cancelOrder(
          createdOrder.id!,
          'Khách hàng thay đổi ý kiến',
        );

        final cancelled = orderService.getAllOrders()
            .firstWhere((o) => o.id == createdOrder.id);

        expect(cancelled.status, 'Đã hủy');
        expect(cancelled.cancelReason, 'Khách hàng thay đổi ý kiến');
      }
    });
  });
}
```

#### 8.2.7. AuthService Tests

```dart
// test/services/auth_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/user.dart';
import 'package:food_ordering_app/services/auth_service.dart';
import 'package:food_ordering_app/services/storage_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      StorageService.init();
      authService = AuthService();
    });

    test('register() tạo tài khoản mới thành công', () async {
      final success = await authService.register(
        phone: '0999999000',
        password: 'test123',
        name: 'Test User',
      );

      expect(success, true);
    });

    test('register() không cho phép đăng ký số điện thoại đã tồn tại', () async {
      await authService.register(
        phone: '0999999001',
        password: 'test123',
        name: 'Test User 1',
      );

      final duplicate = await authService.register(
        phone: '0999999001',
        password: 'test456',
        name: 'Test User 2',
      );

      expect(duplicate, false);
    });

    test('login() đăng nhập thành công với thông tin đúng', () async {
      await authService.register(
        phone: '0999999002',
        password: 'test123',
        name: 'Login Test User',
      );

      final user = await authService.login(
        phone: '0999999002',
        password: 'test123',
      );

      expect(user, isNotNull);
      expect(user!.phone, '0999999002');
    });

    test('login() trả về null với mật khẩu sai', () async {
      await authService.register(
        phone: '0999999003',
        password: 'correct_password',
        name: 'Wrong Pass User',
      );

      final user = await authService.login(
        phone: '0999999003',
        password: 'wrong_password',
      );

      expect(user, isNull);
    });

    test('login() trả về null với số điện thoại chưa đăng ký', () {
      final user = authService.login(
        phone: '0000000000',
        password: 'any_password',
      );

      expect(user, null);
    });

    test('getUserById() trả về đúng User với ID hợp lệ', () async {
      await authService.register(
        phone: '0999999004',
        password: 'test123',
        name: 'Find By ID User',
      );

      final users = await authService.login(
        phone: '0999999004',
        password: 'test123',
      );

      if (users != null) {
        final found = authService.getUserById(users.id!);
        expect(found, isNotNull);
        expect(found!.name, 'Find By ID User');
      }
    });

    test('getUserById() trả về null với ID không tồn tại', () {
      final user = authService.getUserById(99999);

      expect(user, isNull);
    });
  });
}
```

### 8.3. Widget Tests

```dart
// test/widgets/user_home_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:food_ordering_app/user/user_home_screen.dart';
import 'package:food_ordering_app/providers/auth_provider.dart';
import 'package:food_ordering_app/providers/cart_provider.dart';
import 'package:food_ordering_app/services/storage_service.dart';
import 'package:food_ordering_app/services/auth_service.dart';
import 'package:food_ordering_app/services/product_service.dart';
import 'package:food_ordering_app/services/order_service.dart';

void main() {
  setUpAll(() {
    StorageService.init();
  });

  group('UserHomeScreen Widget Tests', () {
    testWidgets('Hiển thị danh sách món ăn', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider(AuthService())),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: const MaterialApp(
            home: UserHomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Phở Bò'), findsOneWidget);
    });

    testWidgets('Có tab lọc theo danh mục', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider(AuthService())),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: const MaterialApp(
            home: UserHomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Phở'), findsOneWidget);
      expect(find.text('Bún'), findsOneWidget);
      expect(find.text('Cơm'), findsOneWidget);
      expect(find.text('Đồ Uống'), findsOneWidget);
    });

    testWidgets('Nhấn vào món ăn mở chi tiết', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider(AuthService())),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: const MaterialApp(
            home: UserHomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Phở Bò'));
      await tester.pumpAndSettle();

      expect(find.text('Phở Bò'), findsWidgets);
    });
  });
}
```

### 8.4. Bảng tổng hợp kết quả kiểm thử

| STT | Tên Test | Module | Loại | Kết quả kỳ vọng |
|---|---|---|---|---|
| 1 | `toMap()` Product | Product | Unit | Đúng |
| 2 | `fromMap()` Product | Product | Unit | Đúng |
| 3 | `copyWith()` Product | Product | Unit | Đúng |
| 4 | `toMap()` Order | Order | Unit | Đúng |
| 5 | `fromMap()` Order | Order | Unit | Đúng |
| 6 | `copyWith()` Order (status) | Order | Unit | Đúng |
| 7 | `copyWith()` Order (cancel) | Order | Unit | Đúng |
| 8 | `toMap()` User (admin) | User | Unit | Đúng |
| 9 | `toMap()` User (user) | User | Unit | Đúng |
| 10 | `fromMap()` User | User | Unit | Đúng |
| 11 | `fromMap()` User (null address) | User | Unit | Đúng |
| 12 | `copyWith()` User | User | Unit | Đúng |
| 13 | `totalPrice` CartItem (qty=1) | CartItem | Unit | Đúng |
| 14 | `totalPrice` CartItem (qty>1) | CartItem | Unit | Đúng |
| 15 | `getAllProducts()` | ProductService | Unit | Đúng |
| 16 | `getProductsByCategory()` | ProductService | Unit | Đúng |
| 17 | `getProductById()` | ProductService | Unit | Đúng |
| 18 | `createOrder()` | OrderService | Integration | Đúng |
| 19 | `getOrdersByUserId()` | OrderService | Unit | Đúng |
| 20 | `updateOrderStatus()` | OrderService | Integration | Đúng |
| 21 | `cancelOrder()` | OrderService | Integration | Đúng |
| 22 | `register()` (mới) | AuthService | Integration | Đúng |
| 23 | `register()` (trùng) | AuthService | Integration | Đúng |
| 24 | `login()` (đúng) | AuthService | Integration | Đúng |
| 25 | `login()` (sai pass) | AuthService | Integration | Đúng |
| 26 | Hiển thị danh sách món | UserHomeScreen | Widget | Đúng |
| 27 | Tab lọc danh mục | UserHomeScreen | Widget | Đúng |
| 28 | Mở chi tiết món | UserHomeScreen | Widget | Đúng |

---

## 9. Báo Cáo – Demo – GitHub (Tự làm)

*(Phần này sinh viên tự hoàn thiện)*

---

## 10. Lịch Sử Commit (Tự làm)

*(Phần này sinh viên tự hoàn thiện)*
