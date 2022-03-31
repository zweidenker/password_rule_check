import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StubMaterialLocalizationDelegate
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

class StubCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return DefaultCupertinoLocalizations();
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}
