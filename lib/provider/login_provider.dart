import 'package:cash4cats/model/pgm_price_api.dart';
import 'package:cash4cats/repository/pgm_price_repo.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool loader = true;
  String selectedCountry = "Select Country";
  String selectedFlag = "🌍";
  PgmPriceAPI pgmprices = PgmPriceAPI();
  List<int> _pgmlist = [];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isChecked = false;
  bool isLoading = false;

  List<int> get pgmlist => _pgmlist;
  Future<void> initViewModel() async {
    loader = true;
    notifyListeners();
    await getPgmPrice();
    loader = false;
    notifyListeners();
  }

  Future<void> getPgmPrice() async {
    try {
      final response = await PgmPriceRepository().fetchPgmPrices();
      if (response != null) {
        pgmprices = response;
        _pgmlist = [
          pgmprices.data?.pt ?? 0,
          pgmprices.data?.pd ?? 0,
          pgmprices.data?.rh ?? 0,
        ];
      }
    } catch (e) {
      debugPrint("Failed to fetch PGM prices: $e");
    }
  }

  void setChecked(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }

  void setLanguage(String country, String flag) {
    selectedCountry = country;
    selectedFlag = flag;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  /*Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
    debugPrint("Login executed with ${emailController.text}");
  }*/

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2)); // simulate API call

      // Simulate login check:
      if (emailController.text.trim() == "admin" && passwordController.text == "1234") {
        debugPrint("Login successful for ${emailController.text}");
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        debugPrint("Login failed for ${emailController.text}");
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Login error: $e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  bool get isValid => emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
