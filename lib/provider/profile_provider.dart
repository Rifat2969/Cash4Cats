import 'package:cash4cats/repository/profile_repo.dart';
import 'package:flutter/material.dart';

import '../model/profile_api.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileApi? profile;
  bool isLoading = false;

  void initViewModel() {
    isLoading = true;
    notifyListeners();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final response = await ProfileRepository().fetchProfile();
    if (response != null) {
      profile = response;
    }
    isLoading = false;
    notifyListeners();
  }

  void disposeController() {
    profile = null;
    isLoading = false;
  }
}
