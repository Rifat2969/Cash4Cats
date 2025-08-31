import 'package:flutter/material.dart';

class ProductDetailsProvider with ChangeNotifier {
  int activeIndex = 0;
  int quantity = 1;
  bool showAll = false;
  final int totalImages = 9;
  final int initialDisplay = 5;
  bool loader = true;

  void initViewModel() => _initLoader();

  Future<void> _initLoader() async {
    await Future.delayed(const Duration(milliseconds: 700));
    activeIndex = 0;
    quantity = 1;
    showAll = false;
    loader = false;
    notifyListeners();
  }

  void incrementUnit() {
    quantity++;
    notifyListeners();
  }

  void decrementUnit() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void setActiveIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }

  void showAllImages() {
    showAll = true;
    notifyListeners();
  }

  void disposeController() {
    activeIndex = 0;
    quantity = 1;
    showAll = false;
    loader = true;
  }
}
