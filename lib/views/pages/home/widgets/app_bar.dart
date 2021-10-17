import 'package:alga/data/app_routes.dart';
import 'package:alga/data/const.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/user_controller.dart';
import 'package:alga/views/pages/home/controller.dart';
import 'package:alga/views/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  final _controller = Get.find<HomePageController>();

  HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140.0,
      backgroundColor: AppThemeData.primary,
      leading: SizedBox(),
      actions: <Widget>[
        /*Obx(() {
          if (UserController.I.isLogin.value)
            return IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Get.toNamed(AppRoutes.user);
              },
            );

          return Container();
        }),*/
      ],
      floating: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Assets.headerBackground),
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 60.0),
            SearchField(
              onSubmitted: (text) {
                _controller.searchProducts(text);
              },
              filterTap: () {
                _controller.openFilter.value = !_controller.openFilter.value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
