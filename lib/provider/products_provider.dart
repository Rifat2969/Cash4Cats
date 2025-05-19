import 'package:cash4cats/repository/products_repo.dart';
import 'package:flutter/material.dart';

import '../model/products_api.dart';
import '../model/products_data.dart';

class ProductsProvider extends ChangeNotifier {
  bool loader = true;
  ProductsApi products = ProductsApi();
  String _searchQuery = "";

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
      for (var product in products.data!) {
        product.quantity = 1;
      }
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

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<ProductsData> get filteredProducts {
    if (products.data == null) return [];

    if (_searchQuery.isEmpty) {
      return products.data!;
    } else {
      return products.data!
          .where((product) =>
              (product.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
              (product.sampleCode?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false))
          .toList();
    }
  }

  void disposeController() {
    products.data = null;
    loader = true;
    _searchQuery = "";
  }
}
