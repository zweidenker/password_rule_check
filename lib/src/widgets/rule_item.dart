import 'package:flutter/material.dart';
import 'package:password_rule_check/password_rule_check.dart';

class RuleItem extends StatelessWidget {
  const RuleItem({
    Key? key,
    required this.rule,
    required this.value,
    required this.translation,
    required this.color,
    this.textStyle,
    this.icon,
  }) : super(key: key);

  final Rule rule;
  final int value;
  final PasswordRuleCheckTranslation translation;

  final Color color;
  final TextStyle? textStyle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ?? TextStyle();
    late final String message;
    switch (rule) {
      case Rule.uppercaseLetters:
        message = translation.uppercase(value);
        break;
      case Rule.lowercaseLetters:
        message = translation.lowercase(value);
        break;
      case Rule.minLength:
        message = translation.minLength(value);
        break;
      case Rule.maxLength:
        message = translation.maxLength(value);
        break;
      case Rule.digits:
        message = translation.digits(value);
        break;
      case Rule.specialCharacters:
        message = translation.specialCharacters(value);
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              icon,
              size: textStyle.height,
              color: color,
            ),
          ),
        Expanded(
          child: Text(
            message,
            style: textStyle.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
