import 'package:alga/data/styles.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final double? width;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onPressed;

  const AppOutlinedButton({
    Key? key,
    required this.text,
    this.width,
    this.color,
    this.margin,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? AppThemeData.secondTextColor.withOpacity(0.5);
    Widget widget = OutlinedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: _color)),
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: _color),
      ),
    );
    if (width != null || margin != null || padding != null)
      widget = Container(
        width: width,
        margin: margin,
        child: widget,
      );

    return widget;
  }
}
