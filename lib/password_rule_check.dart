library password_rule_check;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_rule_check/src/rules.dart';
import 'package:password_rule_check/src/translations/password_rule_check_translations.dart';
import 'package:password_rule_check/src/widgets/rule_item.dart';
import 'package:password_rule_check/src/widgets/rule_progress_bar.dart';

export 'package:password_rule_check/src/rules.dart';
export 'package:password_rule_check/src/translations/password_rule_check_translations.dart';

class PasswordRuleCheck extends StatefulWidget {
  const PasswordRuleCheck({
    Key? key,
    required this.controller,
    required this.ruleSet,
    this.successColor,
    this.errorColor,
    this.textStyle,
    this.translation,
    this.showIcon = false,
    this.textPadding = const EdgeInsets.symmetric(vertical: 4.0),
  }) : super(key: key);

  final TextEditingController controller;

  final Color? successColor;
  final Color? errorColor;

  final TextStyle? textStyle;

  final PasswordRuleSet ruleSet;

  final PasswordRuleCheckTranslation? translation;

  final bool showIcon;

  final EdgeInsets textPadding;

  @override
  PasswordRuleCheckState createState() => PasswordRuleCheckState();
}

class PasswordRuleCheckState extends State<PasswordRuleCheck> {
  void Function()? _textChangeListener;

  Set<Rule> _validationErrors = {};

  PasswordRuleCheckTranslation _translation = EnglishTranslation();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _translation = widget.translation ??
          translations[Localizations.localeOf(context).languageCode] ??
          EnglishTranslation();
    });

    widget.controller.removeListener(_textChangeListener ?? () {});

    _textChangeListener = () {
      setState(() {
        _validationErrors = widget.ruleSet.validate(widget.controller.text);
      });
    };
    widget.controller.addListener(_textChangeListener!);
    _textChangeListener?.call();
  }

  bool validate() => _validationErrors.isEmpty;

  @override
  Widget build(BuildContext context) {
    final errorColor = widget.errorColor ?? Theme.of(context).errorColor;
    final successColor = widget.successColor ?? Colors.green;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RuleProgressBar(
          errors: _validationErrors.length,
          length: widget.ruleSet.rules.length,
          errorColor: errorColor,
          successColor: successColor,
          height: 16,
        ),
        ...widget.ruleSet.rules.entries.map(
          (rule) {
            final valid = !_validationErrors.contains(rule.key);
            return Padding(
              padding: widget.textPadding,
              child: RuleItem(
                rule: rule.key,
                value: rule.value,
                translation: _translation,
                color: valid ? successColor : errorColor,
                icon: widget.showIcon
                    ? valid
                        ? Icons.check_circle
                        : Icons.remove_circle_outline
                    : null,
                textStyle: widget.textStyle,
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
