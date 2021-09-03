class PasswordRuleSet {
  PasswordRuleSet(
      {this.uppercase,
      this.lowercase,
      this.minLength,
      this.maxLength,
      this.digits,
      this.specialCharacters})
      : _rules = (<Rule, int?>{
          Rule.uppercaseLetters: uppercase,
          Rule.lowercaseLetters: lowercase,
          Rule.minLength: minLength,
          Rule.maxLength: maxLength,
          Rule.digits: digits,
          Rule.specialCharacters: specialCharacters,
        }..removeWhere((key, value) => value == null))
            .cast<Rule, int>();

  /// Number of uppercase Letters required
  final int? uppercase;

  /// Number of lowercase Letters required
  final int? lowercase;

  /// Minimum length of the password (inclusive)
  final int? minLength;

  /// Maximum length of the password (inclusive)
  final int? maxLength;

  /// Number of digits required
  final int? digits;

  /// Number of special characters required
  final int? specialCharacters;

  final Map<Rule, int> _rules;

  /// Get the rules included in this [PasswordRuleSet]
  /// Returns a Map of [Rule]s and the corresponding amount/length
  Map<Rule, int> get rules => _rules;

  /// Validates a given [input] against the parameters defined at creation
  /// Returns a [Set] of [Rule]s that are not matching
  /// if it returns an empty set it means that the [input] is satisfying all specified rules
  Set<Rule> validate(String input) {
    final errors = <Rule>{};

    for (final rule in _rules.entries) {
      bool matching = false;

      switch (rule.key) {
        case Rule.uppercaseLetters:
          final regExp = RegExp(r'[A-Z]{1}');
          matching = regExp.allMatches(input).length >= rule.value;
          break;
        case Rule.lowercaseLetters:
          final regExp = RegExp(r'[a-z]{1}');
          matching = regExp.allMatches(input).length >= rule.value;
          break;
        case Rule.minLength:
          matching = input.length >= rule.value;
          break;
        case Rule.maxLength:
          matching = input.length <= rule.value;
          break;
        case Rule.digits:
          final regExp = RegExp(r'[0-9]{1}');
          matching = regExp.allMatches(input).length >= rule.value;
          break;
        case Rule.specialCharacters:
          final regExp = RegExp(r'[-+_!@#$%^&*:;.,?⁄€‹›`°…]{1}');
          matching = regExp.allMatches(input).length >= rule.value;
          break;
      }
      if (!matching) {
        errors.add(rule.key);
      }
    }

    return errors;
  }
}

enum Rule {
  /// Checks for uppercase Letters
  uppercaseLetters,

  /// Checks for lowercase Letters
  lowercaseLetters,

  /// Checks for minimum length (inclusive)
  minLength,

  /// Checks for maximum length (inclusive)
  maxLength,

  /// Checks for digits
  digits,

  /// Checks for special Characters
  specialCharacters,
}
