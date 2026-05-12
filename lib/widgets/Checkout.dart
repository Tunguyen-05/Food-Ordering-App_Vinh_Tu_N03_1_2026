import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  String _address = "";

  String _deliveryTime = "Giao ngay (15-30 phút)";
  final List<String> _timeOptions = [
    "Giao ngay (15-30 phút)",
    "Trong 1 giờ",
    "Chiều nay (14:00 - 16:00)",
    "Tối nay (18:00 - 20:00)"
  ];

  bool _isCashPayment = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đơn hàng"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin giao hàng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // YÊU CẦU 1: TextFieldForm lấy dữ liệu khi đang gõ
            TextField(
              decoration: const InputDecoration(
                labelText: "Địa chỉ giao hàng",
                border: OutlineInputBorder(),
                hintText: "Nhập số nhà, tên đường...",
                prefixIcon: Icon(Icons.location_on),
              ),
              onChanged: (value) {
                setState(() {
                  _address = value;
                });
              },
            ),
            const SizedBox(height: 20),

            const Text(
              "Chọn thời gian giao (Lê Vinh thực hiện)",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _deliveryTime,
              items: _timeOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _deliveryTime = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Thanh toán tiền mặt? (Nguyễn Tú thực hiện)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Switch(
                    value: _isCashPayment,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        _isCashPayment = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const Divider(height: 40),

            const Text(
              "Dữ liệu đã thu thập được:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text("📍 Địa chỉ: $_address"),
            Text("⏰ Thời gian: $_deliveryTime"),
            Text("💳 Thanh toán: ${_isCashPayment ? "Tiền mặt" : "Chuyển khoản"}"),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đặt hàng thành công!")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("XÁC NHẬN ĐẶT HÀNG", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
