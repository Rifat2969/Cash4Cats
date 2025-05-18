// cart_model.dart
import 'products_data.dart';

class CartItem {
  final ProductsData product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice {
    // Handle cases where price might be null or not a double
    final price =
        product.price is double ? product.price : (product.price is int ? (product.price as int).toDouble() : 0.0);
    return price * quantity;
  }
}

class Cart {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(ProductsData product, int quantity) {
    final existingIndex = _items.indexWhere((item) => item.product.catalogueId == product.catalogueId);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }

  void removeItem(int catalogueId) {
    _items.removeWhere((item) => item.product.catalogueId == catalogueId);
  }

  void clearCart() {
    _items.clear();
  }

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
