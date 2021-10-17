import 'package:alga/data/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Function()? onBackPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppThemeData.surface,
      leading: IconButton(
        onPressed: onBackPressed ??
            () {
              Get.back();
            },
        icon: Icon(Icons.arrow_back_ios, color: AppThemeData.mainTextColor),
      ),
      title: DefaultTextStyle(
        style: TextStyle(color: AppThemeData.mainTextColor, fontSize: 18),
        child: title ?? const SizedBox(),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
