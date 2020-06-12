import 'package:flutter/material.dart';
import 'app_localization.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
