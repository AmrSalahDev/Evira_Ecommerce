import 'package:flutter/material.dart';

class LanguageModel {
  final String name;
  final Locale locale;

  LanguageModel({required this.name, required this.locale});

  static List<LanguageModel> get suggestedLanguages => [
    LanguageModel(name: 'English', locale: Locale('en', 'US')),
    LanguageModel(name: 'Arabic', locale: Locale('ar', 'EG')),
  ];

  static List<LanguageModel> get languages => [
    LanguageModel(name: 'French', locale: Locale('fr', 'FR')),
    LanguageModel(name: 'Spanish', locale: Locale('es', 'ES')),
    LanguageModel(name: 'Russian', locale: Locale('ru', 'RU')),
  ];

  static String getLanguageName(String languageCode) {
    final allLanguages = [...suggestedLanguages, ...languages];

    final lang = allLanguages.firstWhere(
      (element) => element.locale.languageCode == languageCode,
      orElse: () => suggestedLanguages.first,
    );

    final countryCode = lang.locale.countryCode ?? '';
    return countryCode.isNotEmpty ? '${lang.name} ($countryCode)' : lang.name;
  }
}
