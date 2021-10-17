import 'package:alga/data/styles.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';

class CustomCard extends StatelessWidget {
  final AppIcons? icon;
  final String? title;
  final Widget child;
  final Color? iconColor;
  final EdgeInsets? padding;

  const CustomCard({
    this.icon,
    this.title,
    required this.child,
    this.iconColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(20, 14, 20, 24),
      decoration: BoxDecoration(
        color: AppThemeData.surface,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: AppThemeData.mainTextColor.withOpacity(0.2),
            spreadRadius: 0.2,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          if (title != null || icon != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  AppIcon(icon!, size: 20, color: iconColor),
                  const SizedBox(width: 15),
                ],
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppThemeData.mainTextColor.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 15),
          ],
          child,
        ],
      ),
    );
  }
}
