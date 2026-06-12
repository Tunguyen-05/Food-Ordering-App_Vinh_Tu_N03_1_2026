# 🍜 Ứng Dụng Đặt Thức Ăn – Food Ordering App

## Thông tin nhóm

| Họ tên | MSSV | Vai trò |
|---|---|---|
| Lê Quang Vinh | 23010507 | User screens, giao diện người dùng, quản lý đơn hàng |
| Nguyễn Anh Tú | 23010645 | Admin screens |

---

## 1. User Stories – Câu Chuyện Người Dùng

### 1.1. Người dùng (Khách hàng)

| ID | Mô tả nghiệp vụ | Tiêu chí hoàn thành (Definition of Done) |
|---|---|---|
| US-01 | Là khách hàng, tôi muốn **đăng ký tài khoản** bằng số điện thoại và mật khẩu để có thể sử dụng ứng dụng | - Nhập số điện thoại chưa đăng ký + mật khẩu → tài khoản được tạo, chuyển sang màn hình chính<br>- Nhập số điện thoại đã tồn tại → hiển thị thông báo lỗi |
| US-02 | Là khách hàng, tôi muốn **đăng nhập** bằng số điện thoại và mật khẩu để truy cập vào ứng dụng | - Thông tin đúng → chuyển sang màn hình chính<br>- Thông tin sai → hiển thị thông báo "Số điện thoại hoặc mật khẩu không đúng" |
| US-03 | Là khách hàng, tôi muốn **xem danh sách món ăn** theo danh mục để chọn món phù hợp | - Hiển thị danh sách món với hình ảnh, tên, giá, mô tả<br>- Có thể lọc theo danh mục: Phở, Bún, Cơm, Đồ Uống |
| US-04 | Là khách hàng, tôi muốn **xem chi tiết món ăn** để biết thêm thông tin trước khi đặt | - Màn hình chi tiết hiển thị hình ảnh lớn, tên, giá, mô tả đầy đủ |
| US-05 | Là khách hàng, tôi muốn **thêm món vào giỏ hàng** để chuẩn bị đặt hàng | - Nhấn nút "Thêm vào giỏ" → món được thêm, giỏ hàng cập nhật số lượng item<br>- Tăng/giảm số lượng trong giỏ hàng<br>- Xóa món khỏi giỏ hàng |
| US-06 | Là khách hàng, tôi muốn **đặt hàng** với thông tin giao hàng và phương thức thanh toán | - Nhập tên, số điện thoại, địa chỉ giao hàng<br>- Chọn loại giao hàng (Thường / Nhanh / Siêu tốc)<br>- Xác nhận đặt hàng → đơn hàng được tạo, giỏ hàng được xóa |
| US-07 | Là khách hàng, tôi muốn **xem lịch sử đơn hàng** để theo dõi các đơn đã đặt | - Hiển thị danh sách đơn hàng với trạng thái: pending, cooking, delivering, completed, cancelled |
| US-08 | Là khách hàng, tôi muốn **hủy đơn hàng** đang chờ xác nhận | - Chỉ đơn hàng ở trạng thái "pending" mới có thể hủy<br>- Nhập lý do hủy → đơn được cập nhật trạng thái "cancelled" |
| US-09 | Là khách hàng, tôi muốn **xem và chỉnh sửa thông tin cá nhân** | - Hiển thị tên, số điện thoại, địa chỉ hiện tại<br>- Có thể cập nhật thông tin và lưu lại |

### 1.2. Quản trị viên (Admin)

| ID | Mô tả nghiệp vụ | Tiêu chí hoàn thành (Definition of Done) |
|---|---|---|
| US-10 | Là quản trị viên, tôi muốn **đăng nhập admin** để truy cập trang quản trị | - Đăng nhập bằng tài khoản admin cố định (admin / admin123) → chuyển sang màn hình quản trị |
| US-11 | Là quản trị viên, tôi muốn **xem danh sách sản phẩm** để theo dõi thực đơn | - Hiển thị toàn bộ sản phẩm với hình ảnh, tên, giá, danh mục |
| US-12 | Là quản trị viên, tôi muốn **xem danh sách đơn hàng** để quản lý đơn hàng từ khách | - Hiển thị tất cả đơn hàng với trạng thái, thông tin khách hàng, tổng tiền |
| US-13 | Là quản trị viên, tôi muốn **cập nhật trạng thái đơn hàng** để thông báo tiến độ cho khách | - Chuyển trạng thái: pending → cooking → delivering → completed<br>- Hủy đơn hàng kèm lý do |

---

## 2. Phân Tích Yêu Cầu, Đối Tượng Và Quan Hệ

### 2.1. Yêu cầu chức năng (Functional Requirements)

| Mã | Yêu cầu | User Story |
|---|---|---|
| FR-01 | Hệ thống cho phép người dùng đăng ký và đăng nhập bằng số điện thoại + mật khẩu | US-01, US-02 |
| FR-02 | Hệ thống hiển thị danh sách món ăn theo danh mục (Phở, Bún, Cơm, Đồ Uống) | US-03 |
| FR-03 | Hệ thống cho phép xem chi tiết từng món ăn | US-04 |
| FR-04 | Hệ thống hỗ trợ giỏ hàng: thêm, tăng/giảm, xóa món | US-05 |
| FR-05 | Hệ thống cho phép đặt hàng với thông tin giao hàng và phương thức thanh toán COD | US-06 |
| FR-06 | Hệ thống cho phép xem và hủy đơn hàng của mình | US-07, US-08 |
| FR-07 | Hệ thống cho phép người dùng xem và cập nhật thông tin cá nhân | US-09 |
| FR-08 | Hệ thống cho phép admin quản lý đơn hàng (cập nhật trạng thái) và xem sản phẩm | US-11, US-12, US-13 |
| FR-09 | Hệ thống lưu trữ dữ liệu cục bộ bằng Hive NoSQL để hoạt động offline | – |

### 2.2. Yêu cầu phi chức năng (Non-Functional Requirements)

| Mã | Yêu cầu |
|---|---|
| NFR-01 | Ứng dụng chạy trên nền tảng Android |
| NFR-02 | Giao diện thân thiện, dễ sử dụng trên thiết bị di động |
| NFR-03 | Dữ liệu lưu trữ cục bộ bằng Hive, truy xuất nhanh |
| NFR-04 | Phân tách rõ ràng giữa người dùng và quản trị viên |

### 2.3. Các lớp đối tượng (Classes), thuộc tính và phương thức

#### Lớp `Product`
- **Thuộc tính:** `id`, `name`, `price`, `description`, `imageUrl`, `category`
- **Phương thức:** `toMap()` (chuyển sang Map), `fromMap()` (tạo từ Map), `copyWith()` (tạo bản sao có chỉnh sửa)

#### Lớp `User`
- **Thuộc tính:** `id`, `phone`, `password`, `name`, `address`, `isAdmin`
- **Phương thức:** `toMap()`, `fromMap()`, `copyWith()`

#### Lớp `Order`
- **Thuộc tính:** `id`, `userId`, `customerName`, `customerPhone`, `customerAddress`, `shippingType`, `shippingFee`, `totalAmount`, `paymentMethod`, `status`, `cancelReason`, `createdAt`
- **Phương thức:** `toMap()`, `fromMap()`, `copyWith()`

#### Lớp `OrderItem`
- **Thuộc tính:** `id`, `orderId`, `productId`, `productName`, `price`, `quantity`
- **Phương thức:** `toMap()`, `fromMap()`, `get totalPrice`

#### Lớp `CartItem`
- **Thuộc tính:** `product` (liên kết Product), `quantity`
- **Phương thức:** `get totalPrice` (= price × quantity)

#### Lớp `CartProvider`
- **Thuộc tính:** `_items` (List<CartItem>), `itemCount`, `subtotal`, `shippingFee`, `total`
- **Phương thức:** `addToCart()`, `removeFromCart()`, `updateQuantity()`, `clear()`, `containsProduct()`, `getQuantity()`

#### Lớp `AuthProvider`
- **Thuộc tính:** `_currentUser`, `_isLoading`, `_error`
- **Phương thức:** `login()`, `register()`, `logout()`, `updateAddress()`, `clearError()`

#### Lớp `AuthService`
- **Phương thức:** `login()`, `register()`, `isPhoneExists()`, `getUserById()`, `updateAddress()`

#### Lớp `ProductService`
- **Phương thức:** `getAllProducts()`, `getProductsByCategory()`, `getCategories()`, `getProductById()`, `addProduct()`, `updateProduct()`, `deleteProduct()`

#### Lớp `OrderService`
- **Phương thức:** `createOrder()`, `getAllOrders()`, `getOrdersByUserId()`, `getOrderItems()`, `updateOrderStatus()`, `getOrderById()`

#### Lớp `StorageService`
- **Phương thức:** `init()`, `loginUser()`, `registerUser()`, `getUserById()`, `isPhoneExists()`, `updateUserAddress()`, `getAllProducts()`, `getProductsByCategory()`, `getCategories()`, `getProductById()`, `addProduct()`, `updateProduct()`, `deleteProduct()`, `createOrder()`, `getAllOrders()`, `getOrdersByUserId()`, `getOrderItems()`, `updateOrderStatus()`, `getOrderById()`

### 2.4. Mối quan hệ giữa các lớp

| Thực thể 1 | Quan hệ | Thực thể 2 | Mô tả |
|---|---|---|---|
| User | 1 : N | Order | Một người dùng có thể có nhiều đơn hàng |
| Order | 1 : N | OrderItem | Một đơn hàng chứa nhiều item |
| Product | 1 : N | OrderItem | Một sản phẩm có thể xuất hiện trong nhiều order item |
| Product | 1 : N | CartItem | Một sản phẩm có thể được thêm vào nhiều cart item |
| CartProvider | aggregation | CartItem | CartProvider quản lý danh sách CartItem (has-a) |
| AuthProvider | uses | AuthService | AuthProvider gọi các phương thức của AuthService |
| OrderService | uses | StorageService | OrderService ủy thác thao tác dữ liệu cho StorageService |
| StorageService | uses | Hive Boxes | StorageService đọc/ghi vào các Hive box (users, products, orders, order_items) |

### 2.5. Sơ đồ thực thể (Entity Relationship)

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
│ price            │
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

---

## 3. Sơ Đồ Cấu Trúc Lớp (Class Diagram)

### 3.1. Models

```
┌─────────────────────────────────────┐
│           Product                   │
├─────────────────────────────────────┤
│ - id: int?                          │
│ - name: String                      │
│ - price: int                        │
│ - description: String               │
│ - imageUrl: String                  │
│ - category: String                  │
├─────────────────────────────────────┤
│ + toMap(): Map<String,dynamic>      │
│ + fromMap(map): Product  [factory]  │
│ + copyWith(...): Product            │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│             User                    │
├─────────────────────────────────────┤
│ - id: int?                          │
│ - phone: String                     │
│ - password: String                  │
│ - name: String                      │
│ - address: String                   │
│ - isAdmin: bool                     │
├─────────────────────────────────────┤
│ + toMap(): Map<String,dynamic>      │
│ + fromMap(map): User   [factory]   │
│ + copyWith(...): User               │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│            Order                    │
├─────────────────────────────────────┤
│ - id: int?                          │
│ - userId: int                       │
│ - customerName: String              │
│ - customerPhone: String             │
│ - customerAddress: String           │
│ - shippingType: String              │
│ - shippingFee: int                  │
│ - totalAmount: int                  │
│ - paymentMethod: String             │
│ - status: String                    │
│ - cancelReason: String?             │
│ - createdAt: DateTime               │
├─────────────────────────────────────┤
│ + toMap(): Map<String,dynamic>      │
│ + fromMap(map): Order  [factory]   │
│ + copyWith(...): Order              │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│          OrderItem                  │
├─────────────────────────────────────┤
│ - id: int?                          │
│ - orderId: int                      │
│ - productId: int                    │
│ - productName: String               │
│ - price: int                        │
│ - quantity: int                     │
├─────────────────────────────────────┤
│ + totalPrice: int  [computed]       │
│ + toMap(): Map<String,dynamic>      │
│ + fromMap(map): OrderItem [factory] │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│          CartItem                   │
├─────────────────────────────────────┤
│ - product: Product                  │
│ - quantity: int                     │
├─────────────────────────────────────┤
│ + totalPrice: int  [computed]       │
└─────────────────────────────────────┘
```

### 3.2. Services

```
┌──────────────────────────────────────────┐
│           StorageService                 │
│            (Singleton)                    │
├──────────────────────────────────────────┤
│ - _usersBox, _productsBox                │
│ - _ordersBox, _orderItemsBox             │
│ - _initialized: bool                     │
├──────────────────────────────────────────┤
│ + init(): Future<void>                   │
│ ─ User: getUserById(), loginUser(),      │
│   registerUser(), isPhoneExists(),        │
│   updateUserAddress()                    │
│ ─ Product: getAllProducts(),             │
│   getProductsByCategory(),               │
│   getProductById(), addProduct(),         │
│   updateProduct(), deleteProduct()       │
│ ─ Order: createOrder(), getAllOrders(),  │
│   getOrdersByUserId(), getOrderItems(),   │
│   updateOrderStatus(), getOrderById()    │
└──────────────────────────────────────────┘
        │
        │ uses
        ▼
┌──────────────────────────────────────────┐
│            AuthService                   │
├──────────────────────────────────────────┤
│ + login(phone, pw): User?               │
│ + register(phone, pw, name): User?      │
│ + isPhoneExists(phone): bool            │
│ + getUserById(id): User?                │
│ + updateAddress(id, addr): bool         │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│          ProductService                  │
├──────────────────────────────────────────┤
│ + getAllProducts(): List<Product>        │
│ + getProductsByCategory(cat): List       │
│ + getCategories(): List<String>          │
│ + getProductById(id): Product?           │
│ + addProduct(p): int                    │
│ + updateProduct(p): bool                 │
│ + deleteProduct(id): bool                │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│           OrderService                   │
├──────────────────────────────────────────┤
│ + createOrder(...): int                 │
│ + getAllOrders(): List<Order>           │
│ + getOrdersByUserId(uid): List          │
│ + getOrderItems(oid): List<OrderItem>   │
│ + updateOrderStatus(...): bool           │
│ + getOrderById(id): Order?              │
└──────────────────────────────────────────┘
```

### 3.3. Providers

```
┌──────────────────────────────────────────┐
│         AuthProvider                     │
│       (ChangeNotifier)                   │
├──────────────────────────────────────────┤
│ - _currentUser: User?                    │
│ - _isLoading: bool                      │
│ - _error: String?                        │
│ - _authService: AuthService             │
├──────────────────────────────────────────┤
│ + login(phone, pw): bool                │
│ + register(phone, pw, name): bool       │
│ + logout(): void                        │
│ + updateAddress(addr): bool              │
│ + clearError(): void                    │
│ + currentUser: User?   [get]             │
│ + isLoggedIn: bool     [get]             │
│ + isAdmin: bool        [get]             │
└──────────────────────────────────────────┘
        │
        │ uses
        ▼
┌──────────────────────────────────────────┐
│          CartProvider                    │
│       (ChangeNotifier)                   │
├──────────────────────────────────────────┤
│ - _items: List<CartItem>                │
├──────────────────────────────────────────┤
│ + addToCart(product, qty): void        │
│ + removeFromCart(id): void              │
│ + updateQuantity(id, qty): void         │
│ + clear(): void                         │
│ + containsProduct(id): bool             │
│ + getQuantity(id): int                  │
│ + itemCount: int       [get]             │
│ + subtotal: int        [get]            │
│ + shippingFee: int     [get]             │
│ + total: int           [get]             │
└──────────────────────────────────────────┘
```

---

## 4. Sơ Đồ Thuật Toán (Sequence & Activity Diagrams)

### 4.1. Sơ đồ tuần tự – Đăng nhập (Login Sequence Diagram)

```
Actor          LoginScreen      AuthProvider      AuthService      StorageService
  │                  │                │                │                │
  │  1.Nhập TK/MK    │                │                │                │
  │─────────────────▶│                │                │                │
  │                  │                │                │                │
  │  2.Nhấn Đăng nhập│                │                │                │
  │─────────────────▶│                │                │                │
  │                  │ 3.login(phone,pw)               │                │
  │                  │───────────────▶│                │                │
  │                  │                │ 4.login(phone,pw)              │
  │                  │                │───────────────▶│                │
  │                  │                │                │ 5.getUserByPhone(phone)
  │                  │                │                │───────────────▶│
  │                  │                │                │◀───────────────│ (trả về User hoặc null)
  │                  │                │◀───────────────│                │
  │                  │ 6.trả về User  │                │                │
  │                  │◀───────────────│                │                │
  │ 7.Trả kết quả    │                │                │                │
  │◀────────────────│                │                │                │
  │                  │                │                │                │
  │  (Đúng)→Chuyển màn hình User / Admin              │                │
  │  (Sai) →Hiển thị thông báo lỗi                   │                │
```

### 4.2. Sơ đồ tuần tự – Thêm món vào giỏ (Add to Cart Sequence Diagram)

```
Actor      ProductDetail    CartProvider      Product
  │               │               │              │
  │ 1.Nhấn +     │               │              │
  │   Thêm vào giỏ│              │              │
  │─────────────▶│               │              │
  │               │ 2.addToCart(product, qty=1) │
  │               │──────────────▶│              │
  │               │               │              │
  │               │ 3.indexWhere(p.id == product.id)
  │               │               │──▶Kiểm tra đã có trong giỏ?
  │               │               │              │
  │               │ ◀───Có────────│              │
  │               │ 4.tăng quantity += 1         │
  │               │               │              │
  │               │ ◀───Chưa có────│              │
  │               │ 5._items.add(CartItem)       │
  │               │               │              │
  │               │ 6.notifyListeners()          │
  │               │◀──────────────│              │
  │ 7.Cập nhật số lượng badge giỏ hàng        │
  │◀─────────────│               │              │
```

### 4.3. Sơ đồ tuần tự – Đặt hàng (Place Order Sequence Diagram)

```
Actor       CheckoutScreen   CartProvider   OrderService   StorageService
  │                │              │              │               │
  │ 1.Nhấn Đặt hàng│              │              │               │
  │──────────────▶│              │              │               │
  │                │ 2. Validate form            │              │
  │                │──▶Form hợp lệ?──▶Không──────│──▶Báo lỗi    │
  │                │◀──────────────Có              │              │
  │                │              │              │               │
  │                │ 3._items (danh sách cart)   │               │
  │                │◀─────────────│              │               │
  │                │              │              │               │
  │                │ 4.createOrder(...)           │               │
  │                │──────────────▶│              │               │
  │                │              │ 5.createOrder(...)            │
  │                │              │─────────────▶│               │
  │                │              │              │ 6.Tạo Order   │
  │                │              │              │ 7.Tạo OrderItems
  │                │              │              │ 8.Lưu vào Hive│
  │                │              │              │◀─────────────│
  │                │              │◀───orderId──│               │
  │                │◀──orderId────│              │               │
  │                │              │              │               │
  │                │ 9.clear() (xóa giỏ)         │               │
  │                │──────────────▶│              │               │
  │                │◀──────────────│              │               │
  │ 10.Dialog thành công, orderId               │               │
  │◀──────────────│              │              │               │
```

### 4.4. Sơ đồ tuần tự – Đăng ký tài khoản (Register Sequence Diagram)

```
Actor        RegisterScreen    AuthProvider      AuthService      StorageService
  │                │                │                │                │
  │  1.Nhập thông tin│              │                │                │
  │   (TK, MK, Tên) │              │                │                │
  │─────────────────▶│                │                │                │
  │                  │                │                │                │
  │  2.Nhấn Đăng ký │                │                │                │
  │─────────────────▶│                │                │                │
  │                  │ 3.register(phone,pw,name)      │                │
  │                  │───────────────▶│                │                │
  │                  │                │ 4.isPhoneExists(phone)           │
  │                  │                │───────────────▶│                │
  │                  │                │                │ 5.containsKey(phone)
  │                  │                │                │───────────────▶│
  │                  │                │                │◀──true/false──│
  │                  │                │◀────true/false│                │
  │                  │ 6.trả về User hoặc null       │                │
  │                  │◀───────────────│                │                │
  │                  │                │                │                │
  │  7.Kết quả       │                │                │                │
  │◀────────────────│                │                │                │
  │                  │                │                │                │
│  (Thành công)───▶ Đăng ký thành công ──▶ Chuyển màn hình chính   │
│  (Trùng SDT)───▶ Hiển thị "Số điện thoại đã được đăng ký"      │
```

### 4.5. Sơ đồ tuần tự – Admin Cập Nhật Trạng Thái Đơn Hàng

```
Actor          AdminOrdersScreen   OrderService   StorageService
  │                  │                │               │
  │ 1.Mở màn hình quản lý đơn hàng  │               │
  │─────────────────▶│                │               │
  │                  │                │               │
  │                  │ 2.getAllOrders()               │
  │                  │───────────────▶│               │
  │                  │                │ 3.Lấy tất cả đơn từ Hive     │
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ List<Order>
  │                  │◀──────────────│               │
  │ 4.Hiển thị danh sách đơn hàng   │               │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 5.Nhấn "Cập nhật" trên đơn #X   │               │
  │─────────────────▶│                │               │
  │                  │ 6.showStatusDialog(order)       │
  │ 7.Chọn hành động (duyệt/ship/hủy)              │
  │─────────────────▶│                │               │
  │                  │                │               │
  │ 8.updateOrderStatus(id, newStatus, cancelReason?)│
  │                  │───────────────▶│               │
  │                  │                │ 9.Tìm và cập nhật đơn trong Hive│
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ true
  │                  │◀──────────────│               │
  │                  │                │               │
  │ 10.Refresh danh sách đơn hàng    │               │
  │◀─────────────────│                │               │
  │                  │                │               │
  │  (pending)───▶ Chọn "Duyệt đơn"───▶ status = "approved"
  │  (approved)──▶ Chọn "Bắt đầu giao"───▶ status = "shipping"
  │  (shipping)──▶ Chọn "Hoàn thành"───▶ status = "completed"
  │  (any)───────▶ Chọn "Hủy đơn"───▶ status = "cancelled" + lý do
```

### 4.6. Sơ đồ tuần tự – User Xem Lịch Sử Đơn Hàng

```
Actor          UserOrdersScreen   OrderService   StorageService
  │                  │                │               │
  │ 1.Mở màn hình "Đơn hàng của tôi"             │
  │─────────────────▶│                │               │
  │                  │                │               │
  │                  │ 2._loadOrders()               │
  │                  │ 3.getOrdersByUserId(userId)   │
  │                  │───────────────▶│               │
  │                  │                │ 4.Lọc đơn theo userId         │
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ List<Order>
  │                  │◀──────────────│               │
  │ 5.Hiển thị danh sách đơn (hoặc "Chưa có đơn")  │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 6.Tap vào đơn #X để xem chi tiết               │
  │─────────────────▶│                │               │
  │                  │ 7.getOrderItems(orderId)       │
  │                  │───────────────▶│               │
  │                  │                │ 8.Lấy items từ Hive            │
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ List<OrderItem>
  │                  │◀──────────────│               │
  │ 9.Dialog hiển thị chi tiết: món, tổng tiền, trạng thái
  │◀─────────────────│                │               │
```

### 4.7. Sơ đồ tuần tự – User Hủy Đơn Hàng

```
Actor          UserOrdersScreen   OrderService   StorageService
  │                  │                │               │
  │ 1.Tap đơn hàng → Xem chi tiết   │               │
  │─────────────────▶│                │               │
  │                  │ 2.Kiểm tra trạng thái = "pending"?         │
  │                  │◀──────────────│               │
  │                  │                │               │
  │ 3.(Nếu pending) Hiển thị nút "Hủy đơn"        │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 4.Nhấn "Hủy đơn"│                │               │
  │─────────────────▶│                │               │
  │ 5.Dialog yêu cầu nhập lý do hủy               │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 6.Nhập lý do + Xác nhận       │               │
  │─────────────────▶│                │               │
  │                  │                │               │
  │ 7.updateOrderStatus(id, "cancelled", cancelReason: "...")
  │                  │───────────────▶│               │
  │                  │                │ 8.Cập nhật status + lý do    │
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ true
  │                  │◀──────────────│               │
  │ 9._loadOrders() refresh danh sách              │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ (Lý do rỗng)───▶ Báo lỗi "Vui lòng nhập lý do"│
```

### 4.8. Sơ đồ tuần tự – Xem Danh Sách Sản Phẩm

```
Actor          UserHomeScreen   ProductService   StorageService
  │                  │                │               │
  │ 1.Mở màn hình chính (Trang chủ) │               │
  │─────────────────▶│                │               │
  │                  │                │               │
  │                  │ 2._loadData()  │               │
  │                  │ 3.getAllProducts()            │
  │                  │───────────────▶│               │
  │                  │                │ 4.Lấy tất cả sản phẩm từ Hive │
  │                  │                │───────────────▶│
  │                  │                │◀──────────────│ List<Product>
  │                  │◀──────────────│               │
  │                  │                │               │
  │                  │ 5.getCategories()             │
  │                  │───────────────▶│               │
  │                  │◀──────────────│ List<String>  │
  │                  │                │               │
  │ 6.Hiển thị Grid sản phẩm         │               │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 7.Chọn danh mục (Phở/Bún/Cơm/Đồ Uống)          │
  │─────────────────▶│                │               │
  │                  │ 8.setState() → _filteredProducts    │
  │                  │ 9.Lọc theo category              │
  │                  │◀──────────────│               │
  │ 10.Cập nhật Grid (sản phẩm mới) │               │
  │◀─────────────────│                │               │
  │                  │                │               │
  │ 11.Nhập từ khóa tìm kiếm         │               │
  │─────────────────▶│                │               │
  │                  │ 12.Lọc theo tên sản phẩm       │
  │                  │◀──────────────│               │
  │ 13.Cập nhật Grid (kết quả tìm kiếm)             │
  │◀─────────────────│                │               │
```

### 4.9. Sơ đồ tuần tự – Xem Chi Tiết Sản Phẩm

```
Actor          ProductDetailScreen   CartProvider
  │                  │                    │
  │ 1.Tap sản phẩm từ Grid            │
  │─────────────────▶│                    │
  │                  │                    │
  │ 2.Mở ProductDetailScreen với product         │
  │                  │                    │
  │ 3.Hiển thị: hình ảnh, tên, giá, mô tả       │
  │◀─────────────────│                    │
  │                  │                    │
  │ 4.Nhấn "+" hoặc "-" để chọn số lượng        │
  │─────────────────▶│                    │
  │                  │ 5.setState() → cập nhật _quantity    │
  │ 6.Cập nhật "Tổng: price × quantity"         │
  │◀─────────────────│                    │
  │                  │                    │
  │ 7.Nhấn "Thêm vào giỏ hàng"       │
  │─────────────────▶│                    │
  │                  │ 8.addToCart(product, _quantity)       │
  │                  │──────────────────▶│
  │                  │                    │
  │ 9.SnackBar "Đã thêm X vào giỏ hàng"          │
  │◀─────────────────────────────────────│
  │                  │                    │
  │ 10.Tự động quay về sau 500ms      │
  │◀─────────────────│                    │
```

---


## 5. Kiểm Thử Và Kiểm Định

### 5.1. Mô tả các test đã thực hiện

Dự án sử dụng **Flutter Test** để viết unit test và widget test. Các test tập trung vào những nghiệp vụ thực tế:

| STT | Test | File | Ý nghĩa nghiệp vụ |
|-----|------|------|--------------------|
| 1 | Thêm món vào giỏ → số lượng = 1 | `cart_provider_test.dart` | Nhấn "Thêm vào giỏ" → món xuất hiện trong giỏ |
| 2 | Thêm cùng món 2 lần → số lượng = 2 | `cart_provider_test.dart` | Thêm 2 lần cùng món → tăng số lượng, không trùng |
| 3 | Xóa món khỏi giỏ → giỏ trống | `cart_provider_test.dart` | Nhấn xóa → món biến mất khỏi giỏ |
| 4 | Tính tổng tiền: subtotal + phí ship | `cart_provider_test.dart` | Giỏ hàng tính đúng tổng = tiền món + 10.000 VNĐ phí ship |
| 5 | Bỏ trống tài khoản → báo lỗi | `login_screen_test.dart` | Form đăng nhập bắt lỗi khi bỏ trống |
| 6 | Bỏ trống mật khẩu → báo lỗi | `login_screen_test.dart` | Form đăng nhập bắt lỗi khi bỏ trống |

### 5.2. Cách chạy test

```powershell
# Chạy tất cả test
flutter test

# Chạy một file test cụ thể
flutter test test/cart_provider_test.dart
flutter test test/login_screen_test.dart
```

### 5.3. Kết quả chạy test

```
00:00 +1: cart_provider_test.dart: Thêm món vào giỏ → số lượng = 1
00:00 +2: cart_provider_test.dart: Thêm cùng món 2 lần → số lượng = 2
00:00 +3: cart_provider_test.dart: Xóa món khỏi giỏ → giỏ trống
00:00 +4: cart_provider_test.dart: Tính tổng tiền đúng: (45000 × 2) + phí ship
00:00 +5: login_screen_test.dart: Bỏ trống tài khoản → báo lỗi
00:00 +6: login_screen_test.dart: Bỏ trống mật khẩu → báo lỗi
00:01 +6: All tests passed!
```

**Tổng kết: 6/6 tests passed.**

### 5.4. Cấu trúc file test

```
test/
├── cart_provider_test.dart   # Unit test: CartProvider (4 tests)
└── login_screen_test.dart    # Widget test: LoginScreen form validation (2 tests)
```

### 5.5. Chiến lược kiểm thử

| Cấp độ | Mô tả | Phạm vi |
|--------|--------|---------|
| Unit Test | Kiểm thử từng phương thức riêng lẻ | CartProvider, AuthProvider |
| Widget Test | Kiểm thử giao diện người dùng | LoginScreen form validation |

> **Ghi chú:** Các test service (AuthService, OrderService, ProductService) yêu cầu Hive được khởi tạo đầy đủ trong môi trường test runner. Trong phạm vi bài tập, các test tập trung vào nghiệp vụ thực tế nhất: **giỏ hàng** và **form đăng nhập**.

---

## 6. Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### 6.1. Yêu cầu hệ thống

- **Flutter SDK:** 3.11.4 trở lên
- **Dart SDK:** 3.11.4 trở lên
- **Android SDK** (nếu build APK Android)

### 6.2. Các bước cài đặt

```powershell
# Clone và cài đặt
git clone <repo-url>
cd Food-Ordering-App_Vinh_Tu_N03_1_2026
flutter pub get

# Chạy ứng dụng
flutter run

# Build APK
flutter build apk --debug
```

### 6.3. Tài khoản mặc định

- **Admin:** `admin` / `admin123`
- **Người dùng:** đăng ký mới bằng số điện thoại + mật khẩu

---

## 7. Kiến Trúc Ứng Dụng

```
lib/
├── main.dart
├── models/
│   ├── product.dart
│   ├── user.dart
│   ├── order.dart
│   ├── cart_item.dart
│   └── order_item.dart
├── providers/
│   ├── auth_provider.dart
│   └── cart_provider.dart
├── services/
│   ├── storage_service.dart
│   ├── auth_service.dart
│   ├── product_service.dart
│   └── order_service.dart
├── screens/
│   ├── login_screen.dart
│   └── register_screen.dart
├── user/
│   ├── main_user_screen.dart
│   ├── user_home_screen.dart
│   ├── user_cart_screen.dart
│   ├── checkout_screen.dart
│   ├── user_orders_screen.dart
│   └── user_profile_screen.dart
└── admin/
    ├── admin_main_screen.dart
    ├── admin_products_screen.dart
    └── admin_orders_screen.dart
```

