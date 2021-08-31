library password_rule_check_translations;

part 'package:password_rule_check/src/translations/en.dart';
part 'package:password_rule_check/src/translations/de.dart';

abstract class PasswordRuleCheckTranslation {
  String uppercase(int amount);
  String minLength(int length);
  String maxLength(int length);
  String digits(int amount);
  String specialCharacters(int amount);
}

Map<String, PasswordRuleCheckTranslation> get translations => {
      'en': EnglishTranslation(),
      'de': GermanTranslation(),
    };
