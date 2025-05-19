import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationConfig {
  static Widget init({required Widget child}) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('it'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: child,
    );
  }
}
