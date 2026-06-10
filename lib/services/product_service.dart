import '../models/product.dart';
import 'storage_service.dart';

class ProductService {
  List<Product> getAllProducts() {
    return StorageService.getAllProducts();
  }

  List<Product> getProductsByCategory(String category) {
    return StorageService.getProductsByCategory(category);
  }

  List<String> getCategories() {
    return StorageService.getCategories();
  }

  Product? getProductById(int id) {
    return StorageService.getProductById(id);
  }

  int addProduct(Product product) {
    return StorageService.addProduct(product);
  }

  bool updateProduct(Product product) {
    return StorageService.updateProduct(product);
  }

  bool deleteProduct(int id) {
    return StorageService.deleteProduct(id);
  }
}
