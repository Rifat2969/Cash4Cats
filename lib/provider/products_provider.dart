import 'package:cash4cats/repository/products_repo.dart';
import 'package:flutter/material.dart';

import '../model/products_api.dart';

class ProductsProvider extends ChangeNotifier {
  bool loader = true;
  ProductsApi products = ProductsApi();

  // Async initViewModel — sets loader delay before ready
  void initViewModel(int categoryId) async {
    await _initLoader();
    await fetchProducts(categoryId: categoryId);
  }

  Future<void> _initLoader() async {
    await Future.delayed(const Duration(milliseconds: 700));
    loader = false;
    notifyListeners();
  }

  Future<void> fetchProducts({required int categoryId}) async {
    loader = true;
    notifyListeners();

    var response = await ProductsRepository().fetchProducts(categoryId: categoryId, page: 1);
    if (response != null) {
      products = response;
    }

    loader = false;
    notifyListeners();
  }

  void incrementQuantity(int index) {
    products.data![index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (products.data![index].quantity > 1) {
      products.data![index].quantity--;
      notifyListeners();
    }
  }

  void disposeController() {
    products.data = null;
    loader = true;
  }
}
