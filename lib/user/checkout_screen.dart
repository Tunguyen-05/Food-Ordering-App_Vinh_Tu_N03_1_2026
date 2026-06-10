import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final int total;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String _shippingType = 'Thường';
  String _paymentMethod = 'COD';
  bool _isLoading = false;
  int _shippingFee = 10000;

  final Map<String, int> _shippingOptions = {
    'Thường': 10000,
    'Nhanh': 20000,
    'Siêu tốc': 30000,
  };

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
      _addressController.text = user.address;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final auth = context.read<AuthProvider>();
      final orderService = OrderService();
      final orderTotal = widget.total - _shippingFee + _shippingFee;

      final orderId = await orderService.createOrder(
        userId: auth.currentUser!.id!,
        customerName: _nameController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        customerAddress: _addressController.text.trim(),
        shippingType: _shippingType,
        shippingFee: _shippingFee,
        totalAmount: widget.total - 10000 + _shippingFee,
        paymentMethod: _paymentMethod,
        items: widget.cartItems,
      );

      await auth.updateAddress(_addressController.text.trim());
      if (mounted) {
        context.read<CartProvider>().clear();
        _showSuccessDialog(orderId);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessDialog(int orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 12),
            Text('Đặt hàng thành công!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mã đơn hàng: #$orderId'),
            const SizedBox(height: 8),
            const Text('Cảm ơn bạn đã đặt hàng! Đơn hàng của bạn đang chờ được duyệt.'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Thông tin giao hàng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Vui lòng nhập họ tên';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Vui lòng nhập số điện thoại';
                if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Số điện thoại phải là 10 chữ số';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Địa chỉ giao hàng',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Vui lòng nhập địa chỉ';
                return null;
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Phương thức vận chuyển',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._shippingOptions.entries.map((entry) {
              return RadioListTile<String>(
                title: Text(entry.key),
                subtitle: Text(_formatPrice(entry.value)),
                value: entry.key,
                groupValue: _shippingType,
                onChanged: (value) {
                  setState(() {
                    _shippingType = value!;
                    _shippingFee = entry.value;
                  });
                },
                secondary: Icon(
                  entry.key == 'Thường'
                      ? Icons.local_shipping
                      : entry.key == 'Nhanh'
                          ? Icons.speed
                          : Icons.bolt,
                  color: Colors.orange,
                ),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
                color: Colors.orange[50],
              ),
              child: Row(
                children: [
                  const Icon(Icons.money, color: Colors.orange),
                  const SizedBox(width: 12),
                  const Text(
                    'Thanh toán khi nhận hàng (COD)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Radio<String>(
                    value: 'COD',
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(() => _paymentMethod = value!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Chi tiết đơn hàng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ...widget.cartItems.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.product.name} x${item.quantity}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(_formatPrice(item.totalPrice)),
                            ],
                          ),
                        )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phí vận chuyển:'),
                        Text(_formatPrice(_shippingFee)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tổng cộng:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          _formatPrice(widget.total - 10000 + _shippingFee),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _placeOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Đặt hàng - ${_formatPrice(widget.total - 10000 + _shippingFee)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} VNĐ';
  }
}
