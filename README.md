# Food-Ordering-App_Vinh_Tu_N03_1_2026
<<<<<<< HEAD
=======
# Bài giữa kỳ phân công
Lê Quang Vinh-23010507: làm phần Content

Nguyễn Anh Tú-23010645: làm phần About

Bài tập thực hành số 6:
1. Tổng quát hóa (Generalization) - Nguyễn Tú
   Tiến hành tách các thành phần giao diện lặp lại thành các lớp (class) dùng chung trong tệp common_widgets.dart.
   
   • Các lớp đã áp dụng:
   - BaseCard: Đóng gói logic về đổ bóng (boxShadow), bo góc (borderRadius) và hiệu ứng chạm (GestureDetector).
   - BaseInputField: Tổng quát hóa thành phần nhập liệu bao gồm nhãn (Label) và ô nhập (TextField).
   - SectionTitle: Chuẩn hóa hiển thị tiêu đề các phân đoạn.
   
   • Tác dụng: Giảm thiểu mã nguồn thừa (boilerplate code), đảm bảo tính nhất quán (Consistency) về giao diện trên toàn bộ ứng dụng và dễ dàng bảo trì, nâng cấp.

2. Chuyên biệt hóa (Specialization) - Vinh Lê
   • Tại màn hình About (about_screen.dart):
   - Chuyên biệt hóa nội dung bên trong BaseCard để hiển thị thẻ thành viên nhóm (_memberCard) và biểu mẫu liên hệ.
   - Xây dựng _buildAboutBanner riêng biệt để xử lý hiệu ứng hình ảnh đặc thù của trang giới thiệu.
   
   • Tại màn hình Checkout (Test.dart):
   - Chuyên biệt hóa các đối tượng lấy dữ liệu (Get Value) để phục vụ yêu cầu bài tập thực hành.
> >>>>>>> 620e16d04cc2bb3541c239b3d9dfb01087a94d58
buổi 1:
![z7703303914195_34fb47a91c10b9f0c0bd3866ecf12551](https://github.com/user-attachments/assets/a6bbb816-ec9f-47e4-9802-c6a1fbe7003a)

buổi 2:
<img width="1920" height="1080" alt="Screenshot (1149)" src="https://github.com/user-attachments/assets/3ffe419b-7c43-46ab-9f2b-df52f1440b97" />

buổi 3:
<img width="1920" height="1080" alt="Screenshot (1180)" src="https://github.com/user-attachments/assets/aafa16a3-d611-4da5-b23a-639801ef9c27" />

