import 'package:flutter/material.dart';

class StubLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<MaterialLocalizations> old) {
    return false;
  }
}
