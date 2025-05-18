import 'package:cash4cats/repository/category_repo.dart';
import 'package:cash4cats/repository/pgm_price_repo.dart';
import 'package:flutter/material.dart';

import '../model/category_api.dart';
import '../model/category_data.dart';
import '../model/pgm_price_api.dart';

class CategoryProvider extends ChangeNotifier {
  bool loader = true;
  PgmPriceAPI pgmprices = PgmPriceAPI();
  List<int> pgmlist = [];
  CategoryApi categories = CategoryApi();
  List<CategoryData> filteredCategories = [];

  final TextEditingController searchController = TextEditingController();

  Future<void> initData() async {
    loader = true;
    notifyListeners();
    await Future.wait([getPgmPrice(), getCategory()]);
    loader = false;
    notifyListeners();
  }

  Future<void> getPgmPrice() async {
    try {
      final response = await PgmPriceRepository().fetchPgmPrices();
      if (response != null) {
        pgmprices = response;
        pgmlist = [
          pgmprices.data?.pt ?? 0,
          pgmprices.data?.pd ?? 0,
          pgmprices.data?.rh ?? 0,
        ];
      }
    } catch (e) {
      debugPrint("Error fetching PGM prices: $e");
    }
  }

  Future<void> getCategory() async {
    try {
      final response = await CategoryRepository().fetchCategories();
      if (response != null) {
        categories = response;
        filteredCategories = categories.data ?? [];
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  void filterCategories(String query) {
    final results = categories.data!.where((category) {
      final name = (category.name ?? '').toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();

    filteredCategories = results;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
