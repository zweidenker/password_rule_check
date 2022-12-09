# PasswordRuleCheck
[![Pub](https://img.shields.io/pub/v/password_rule_check.svg)](https://pub.dartlang.org/packages/password_rule_check)
[![pub points](https://img.shields.io/pub/points/password_rule_check?logo=dart)](https://pub.dev/packages/password_rule_check/score)
[![Build](https://github.com/zweidenker/password_rule_check/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/zweidenker/password_rule_check/actions/workflows/main.yml?query=branch%3Amain)

A Flutter Widget to show if a Password matches a specific Rule Set

| <img src="https://github.com/zweidenker/password_rule_check/blob/main/.github/assets/standard.png?raw=true" width="500px"> | <img src="https://github.com/zweidenker/password_rule_check/blob/main/.github/assets/customized.png?raw=true" width="500px"> |
|----------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|


## Supported Checks

* minimum Length
* maximum Length
* minimum number of uppercase Letters
* minimum number of lowercase Letters
* minimum number of digits
* minimum number of special characters

## Localizations

Supported Languages:
* English 🇺🇸🇬🇧
* German 🇩🇪
* Portuguese 🇵🇹

Feel free to add a new language via a Pull Request
Alternatively you can specify custom translations/texts by passing in a custom `PasswordRuleCheckTranslation`
```dart
class MyCustomTranslation extends PasswordRuleCheckTranslation {
  // Override for your custom Translations
}

PasswordRuleCheck(
  ruleSet: RuleSet(),
  translation: MyCustomTranslation(),
);
```
