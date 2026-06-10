import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  User? login(String phone, String password) {
    return StorageService.loginUser(phone, password);
  }

  User? register(String phone, String password, String name) {
    if (StorageService.isPhoneExists(phone)) return null;
    return StorageService.registerUser(phone, password, name);
  }

  bool updateAddress(int userId, String address) {
    return StorageService.updateUserAddress(userId, address);
  }

  User? getUserById(int id) {
    return StorageService.getUserById(id);
  }

  bool isPhoneExists(String phone) {
    return StorageService.isPhoneExists(phone);
  }
}
