import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../services/order_service.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final _orderService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    _orders = _orderService.getAllOrders();
    setState(() => _isLoading = false);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.blue;
      case 'shipping':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Chờ duyệt';
      case 'approved':
        return 'Đã duyệt';
      case 'shipping':
        return 'Đang ship';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status;
    }
  }

  void _showOrderDetails(Order order) async {
    final items = _orderService.getOrderItems(order.id!);
    if (!mounted) return;
    _showOrderDetailDialog(order, items);
  }

  void _showOrderDetailDialog(Order order, List<OrderItem> items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Đơn hàng #${order.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow('Khách hàng:', order.customerName),
              _buildInfoRow('SĐT:', order.customerPhone),
              _buildInfoRow('Địa chỉ:', order.customerAddress),
              _buildInfoRow('Ship:', order.shippingType),
              _buildInfoRow('Phí ship:', _formatPrice(order.shippingFee)),
              const Divider(),
              const Text(
                'Chi tiết đơn hàng:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('${item.productName} x${item.quantity}'),
                        ),
                        Text(_formatPrice(item.totalPrice)),
                      ],
                    ),
                  )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _formatPrice(order.totalAmount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              if (order.status == 'cancelled' && order.cancelReason != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Lý do hủy: ${order.cancelReason}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showCancelDialog(Order order) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hủy đơn hàng'),
        content: TextField(
          controller: reasonController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Lý do hủy',
            hintText: 'Nhập lý do hủy đơn...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              if (reasonController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập lý do hủy')),
                );
                return;
              }
              _orderService.updateOrderStatus(
                order.id!,
                'cancelled',
                cancelReason: reasonController.text,
              );
              if (context.mounted) {
                Navigator.pop(context);
                _loadOrders();
              }
            },
            child: const Text('Xác nhận hủy', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showStatusDialog(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập nhật trạng thái'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (order.status == 'pending')
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Duyệt đơn hàng'),
                onTap: () async {
                  _orderService.updateOrderStatus(order.id!, 'approved');
                  if (context.mounted) {
                    Navigator.pop(context);
                    _loadOrders();
                  }
                },
              ),
            if (order.status == 'approved')
              ListTile(
                leading: const Icon(Icons.local_shipping, color: Colors.purple),
                title: const Text('Bắt đầu giao hàng'),
                onTap: () async {
                  _orderService.updateOrderStatus(order.id!, 'shipping');
                  if (context.mounted) {
                    Navigator.pop(context);
                    _loadOrders();
                  }
                },
              ),
            if (order.status == 'shipping')
              ListTile(
                leading: const Icon(Icons.done_all, color: Colors.green),
                title: const Text('Hoàn thành đơn hàng'),
                onTap: () async {
                  _orderService.updateOrderStatus(order.id!, 'completed');
                  if (context.mounted) {
                    Navigator.pop(context);
                    _loadOrders();
                  }
                },
              ),
            if (order.status != 'cancelled' && order.status != 'completed')
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('Hủy đơn hàng'),
                onTap: () {
                  Navigator.pop(context);
                  _showCancelDialog(order);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
        title: const Text('Quản lý đơn hàng'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? const Center(child: Text('Chưa có đơn hàng nào'))
              : RefreshIndicator(
                  onRefresh: _loadOrders,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return Card(
                        child: InkWell(
                          onTap: () => _showOrderDetails(order),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '#${order.id} - ${order.customerName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(order.status),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        _getStatusText(order.status),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'SĐT: ${order.customerPhone}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  'Ship: ${order.shippingType} - ${_formatPrice(order.shippingFee)}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  'Tổng: ${_formatPrice(order.totalAmount)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                Text(
                                  _formatDate(order.createdAt),
                                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                                ),
                                if (order.status != 'cancelled' && order.status != 'completed')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: ElevatedButton(
                                      onPressed: () => _showStatusDialog(order),
                                      child: const Text('Cập nhật'),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} VNĐ';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
