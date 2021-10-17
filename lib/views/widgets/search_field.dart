import 'package:alga/user_controller.dart';
import 'package:alga/utils/app_box.dart';
import 'package:alga/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/styles.dart';
import 'app_icon.dart';

class SearchField extends StatelessWidget {
  final Function(String text)? onSubmitted;
  final Function()? filterTap;

  SearchField({
    Key? key,
    this.onSubmitted,
    this.filterTap,
  }) : super(key: key);

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          TextField(
            controller: _searchTextController,
            style: TextStyle(color: AppThemeData.inverseTextColor),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'search'.tr,
              hintStyle: TextStyle(color: AppThemeData.inverseTextColor),
              border: InputBorder.none,
              icon: IconButton(
                onPressed: () {},
                icon: AppIcon(AppIcons.search, color: Colors.white),
              ),
            ),
            onChanged: (String text) {},
            onSubmitted: (String text) {
              if (!text.contains('admin:') || AppBox.isLogin) {
                onSubmitted?.call(text);
              } else {
                text = text.replaceAll('admin:', '').replaceFirst(' ', '');
                if (text == 'login') {
                  _searchTextController.text = ' ';
                  Get.to(LoginPage());
                }
              }
            },
          ),
          Positioned(
            top: 3,
            right: 5,
            child: IconButton(
              onPressed: () {
                filterTap?.call();
              },
              icon: AppIcon(
                AppIcons.filter,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
