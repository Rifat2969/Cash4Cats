import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/country_list.dart';

class LanguageSheet {
  static Future<Map<String, String>?> show(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a Country',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CountryListWidget(),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final localeMap = {
        "United States": const Locale('en'),
        "Spain": const Locale('es'),
        "France": const Locale('fr'),
        "Germany": const Locale('de'),
        "Italy": const Locale('it'),
        "Russia": const Locale('ru'),
      };

      context.setLocale(localeMap[result["name"]] ?? const Locale('en'));
    }

    return result;
  }
}
