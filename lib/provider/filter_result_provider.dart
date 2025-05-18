import 'package:cash4cats/repository/products_repo.dart';
import 'package:flutter/material.dart';

import '../model/cart_service.dart';
import '../model/category_data.dart';
import '../model/products_api.dart';

class FilterResultProvider extends ChangeNotifier {
  List<ProductsApi> allProducts = [];
  final Cart cart = Cart();
  bool loader = true;

  // Async ViewModel initialization
  void initViewModel() => _initLoader();

  Future<void> _initLoader() async {
    await Future.delayed(const Duration(milliseconds: 700));
    loader = false;
    notifyListeners();
  }

  Future<void> fetchFilteredProducts(List<CategoryData> categories) async {
    loader = true;
    notifyListeners();

    List<ProductsApi> productsList = [];
    for (var category in categories) {
      var response = await ProductsRepository().fetchProducts(categoryId: category.id!, page: 1);
      if (response != null) {
        for (var product in response.data ?? []) {
          product.quantity = 1;
        }
        productsList.add(response);
      }
    }
    allProducts = productsList;

    loader = false;
    notifyListeners();
  }

  void incrementQuantity(int categoryIndex, int productIndex) {
    allProducts[categoryIndex].data![productIndex].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int categoryIndex, int productIndex) {
    if (allProducts[categoryIndex].data![productIndex].quantity > 1) {
      allProducts[categoryIndex].data![productIndex].quantity--;
      notifyListeners();
    }
  }

  int get totalProductCount => allProducts.fold(0, (sum, api) => sum + (api.data?.length ?? 0));

  void disposeController() {
    allProducts.clear();
    loader = true;
  }
}
