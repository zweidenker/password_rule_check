class PasswordRuleSet {
  PasswordRuleSet(
      {this.uppercase,
      this.minLength,
      this.maxLength,
      this.digits,
      this.specialCharacters})
      : _rules = (<Rule, int?>{
          Rule.uppercaseLetters: uppercase,
          Rule.minLength: minLength,
          Rule.maxLength: maxLength,
          Rule.digits: digits,
          Rule.specialCharacters: specialCharacters,
        }..removeWhere((key, value) => value == null))
            .cast<Rule, int>();

  final int? uppercase;
  final int? minLength;
  final int? maxLength;
  final int? digits;
  final int? specialCharacters;

  final Map<Rule, int> _rules;
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
  uppercaseLetters,
  minLength,
  maxLength,
  digits,
  specialCharacters,
}
