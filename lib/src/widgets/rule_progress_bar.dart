import 'package:flutter/widgets.dart';

class RuleProgressBar extends StatelessWidget {
  const RuleProgressBar({
    Key? key,
    required this.length,
    required this.errors,
    required this.errorColor,
    required this.successColor,
    required this.height,
    required this.radius,
    required this.spacing,
  }) : super(key: key);

  final int length;
  final int errors;
  final Color errorColor;
  final Color successColor;
  final double height;
  final BorderRadiusGeometry radius;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
            length,
            (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index != length - 1 ? spacing : 0,
                    ),
                    child: _BarPill(
                      color:
                          index < length - errors ? successColor : errorColor,
                      radius: radius,
                    ),
                  ),
                ),
            growable: false),
      ),
    );
  }
}

class _BarPill extends StatelessWidget {
  const _BarPill({
    Key? key,
    required this.color,
    required this.radius,
  }) : super(key: key);

  final Color color;
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
      color: color,
      borderRadius: radius,
    ));
  }
}
