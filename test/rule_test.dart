import 'package:flutter_test/flutter_test.dart';
import 'package:password_rule_check/src/rules.dart';

void main() {
  test(
      'No specified rules '
      'has no validation Errors', () {
    final validator = PasswordRuleSet();

    expect(validator.validate('input'), <Rule>{});
  });

  group('Uppercase', () {
    test(
        'Not sufficient Uppercase Letters '
        'returns Set containing ValidationOption', () {
      final validator = PasswordRuleSet(uppercase: 3);

      expect(validator.validate('aAAa'), {Rule.uppercaseLetters});
    });

    test(
        'Sufficient Uppercase Letters '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(uppercase: 3);

      expect(validator.validate('aAAAa'), <Rule>{});
    });

    test(
        'More than required Uppercase Letters '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(uppercase: 3);

      expect(validator.validate('aAAaAaA'), <Rule>{});
    });
  });

  group('Digits', () {
    test(
        'Not sufficient Digits '
        'returns Set containing ValidationOption', () {
      final validator = PasswordRuleSet(digits: 3);

      expect(validator.validate('a15a'), {Rule.digits});
    });

    test(
        'Sufficient Digits '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(digits: 3);

      expect(validator.validate('a123a'), <Rule>{});
    });

    test(
        'More than required Digits '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(digits: 3);

      expect(validator.validate('a90a6a3'), <Rule>{});
    });
  });

  group('minLength', () {
    test(
        'Input too Short '
        'returns Set containing ValidationOptions', () {
      final validator = PasswordRuleSet(minLength: 3);

      expect(validator.validate('aa'), {Rule.minLength});
    });

    test(
        'Sufficient length '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(minLength: 3);

      expect(validator.validate('aaa'), <Rule>{});
    });

    test(
        'Longer than needed '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(minLength: 3);

      expect(validator.validate('aaaaa'), <Rule>{});
    });
  });

  group('maxLength', () {
    test(
        'Input too Long '
        'returns Set containing ValidationOptions', () {
      final validator = PasswordRuleSet(maxLength: 3);

      expect(validator.validate('aaaa'), {Rule.maxLength});
    });

    test(
        'Sufficient length '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(maxLength: 3);

      expect(validator.validate('aaa'), <Rule>{});
    });

    test(
        'Shorter than needed '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(maxLength: 3);

      expect(validator.validate('aa'), <Rule>{});
    });
  });

  group('Special Characters', () {
    test(
        'Not sufficient Special Characters '
        'returns Set containing ValidationOption', () {
      final validator = PasswordRuleSet(specialCharacters: 3);

      expect(validator.validate(r'a$1a'), {Rule.specialCharacters});
    });

    test(
        'Sufficient Special Characters '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(specialCharacters: 3);

      expect(validator.validate('a#€@a'), <Rule>{});
    });

    test(
        'More than required Special Characters '
        'has no validation Errors', () {
      final validator = PasswordRuleSet(specialCharacters: 3);

      expect(validator.validate('a,.a^a%'), <Rule>{});
    });
  });
}
