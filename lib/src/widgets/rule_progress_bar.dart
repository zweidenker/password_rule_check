import 'package:flutter/widgets.dart';

class RuleProgressBar extends StatelessWidget {
  const RuleProgressBar(
      {Key? key,
      required this.length,
      required this.errors,
      required this.errorColor,
      required this.successColor,
      required this.height})
      : super(key: key);

  final int length;
  final int errors;
  final Color errorColor;
  final Color successColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
            length,
            (index) => Expanded(
                  child: _BarPill(
                      color:
                          index < length - errors ? successColor : errorColor),
                ),
            growable: false),
      ),
    );
  }
}

class _BarPill extends StatelessWidget {
  const _BarPill({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
      color: color,
    ));
  }
}
