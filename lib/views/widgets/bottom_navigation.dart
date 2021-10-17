import 'package:alga/data/app_routes.dart';
import 'package:alga/data/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_icon.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function()? onMenuTap;

  BottomNavigation({
    Key? key,
    this.currentIndex = 0,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppThemeData.primary,
      unselectedItemColor: AppThemeData.mainTextColor,
      onTap: (index) {
        switch (index) {
          case 0:
            if (Get.currentRoute == AppRoutes.home) {
            } else {
              Get.offAllNamed(AppRoutes.home);
            }
            break;
          case 1:
            Get.toNamed(AppRoutes.addProduct);
            break;
          case 2:
            onMenuTap?.call();
            break;
          default:
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: AppIcon(AppIcons.house, color: _selectColor(0)),
          title: const SizedBox(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppThemeData.primary,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Icon(Icons.add, color: AppThemeData.onPrimary),
          ),
          title: const SizedBox(),
        ),
        BottomNavigationBarItem(
          icon: AppIcon(AppIcons.hamburger_menu, color: _selectColor(2)),
          title: const SizedBox(),
        ),
      ],
    );
  }

  Color _selectColor(int index) {
    return currentIndex == index
        ? AppThemeData.primary
        : AppThemeData.mainTextColor;
  }
}
