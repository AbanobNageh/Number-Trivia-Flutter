import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) async {
    final String localeName =
        locale.countryCode == null || locale.countryCode.isEmpty
            ? locale.languageCode
            : locale.toString();

    final String canonicalLocaleName = Intl.canonicalizedLocale(localeName);
    Intl.defaultLocale = canonicalLocaleName;
    await initializeMessages(canonicalLocaleName);

    return AppLocalization();
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  // to extract to arb file.
  // flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/core/localization lib/core/localization/app_localization.dart
  // then after creating arb files for each language:
  // flutter pub pub run intl_translation:generate_from_arb lib/src/lang/sit_localizations.dart lib/l10n/*.arb  --output-dir=lib/l10n

  String get title => Intl.message(
        'Number Trivia',
        name: 'title',
        desc: 'App title',
      );

  String get triviaError => Intl.message(
    'An error occurred!!',
    name: 'triviaError',
    desc: 'Trivia error',
  );

  String get triviaStartSearch => Intl.message(
    'Start Searching!!',
    name: 'triviaStartSearch',
    desc: 'Trivia search initial state',
  );

  String get enterNumberHint => Intl.message(
    'Enter a number',
    name: 'enterNumberHint',
    desc: 'Trivia number text field hint',
  );

  String get searchButtonText => Intl.message(
    'Search',
    name: 'searchButtonText',
    desc: 'Trivia search button text',
  );

  String get getRandomTriviaButtonText => Intl.message(
    'Get random trivia',
    name: 'getRandomTriviaButtonText',
    desc: 'Trivia get random button text',
  );
}
