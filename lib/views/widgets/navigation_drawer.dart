import 'package:alga/data/app_routes.dart';
import 'package:alga/data/const.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/navigaton_controller.dart';
import 'package:alga/user_controller.dart';
import 'package:alga/utils/app_box.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:share_it/share_it.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  final Function? callBack;
  final _controller = Get.find<NavigationController>();

  NavigationDrawer({this.callBack});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          createDrawerHeader(),
          const SizedBox(height: 10),
          createDrawerBodyItem(
            icon: AppIcons.grid,
            text: 'ads'.tr,
            onTap: () {},
          ),
          createDrawerBodyItem(
            icon: AppIcons.plus_circle,
            text: 'give_ads'.tr,
            onTap: () {
              launch(
                  'http://api.whatsapp.com/send?phone=${_controller.phone.value}');
            },
          ),
          Obx(() {
            if (UserController.I.isLogin.value)
              return Column(
                children: [
                  createDrawerBodyItem(
                    icon: AppIcons.checks_grid,
                    text: 'categories'.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.categories);
                    },
                  ),
                  createDrawerBodyItem(
                    icon: AppIcons.notifications,
                    text: 'notifications'.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.notification);
                    },
                  ),
                ],
              );

            return const SizedBox();
          }),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: AppThemeData.mainTextColor),
          ),
          const SizedBox(height: 25),
          createDrawerBodyItem(
            icon: AppIcons.share,
            text: 'soc_share'.tr,
            onTap: () async {
              ShareIt.link(
                url:
                    'https://play.google.com/store/apps/details?id=kg.com.alga',
              );
            },
          ),
          createDrawerBodyItem(
            icon: AppIcons.info_circle,
            text: 'about_app'.tr,
            onTap: () async {
              Get.toNamed(AppRoutes.aboutApp);
            },
          ),
          createDrawerBodyItem(
            icon: AppIcons.globe,
            text: 'change_language'.tr,
            onTap: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Сменить язык',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppThemeData.mainTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          changeLocale(Locale('kg', 'KG'), context);
                        },
                        leading: Radio(
                          groupValue: AppBox.locale,
                          value: Locale('kg', 'KG'),
                          onChanged: (Locale? value) {
                            changeLocale(Locale('kg', 'KG'), context);
                          },
                        ),
                        title: Text(
                          'Кыргызча',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppThemeData.mainTextColor,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          changeLocale(Locale('ru', 'RU'), context);
                        },
                        leading: Radio(
                          groupValue: AppBox.locale,
                          value: Locale('ru', 'RU'),
                          onChanged: (Locale? value) {
                            changeLocale(Locale('ru', 'RU'), context);
                          },
                        ),
                        title: Text(
                          'Русский',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppThemeData.mainTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  changeLocale(Locale locale, context) {
    AppBox.locale = locale;
    Get.updateLocale(locale);
    Navigator.pop(context);
  }

  Widget createDrawerHeader() {
    return SafeArea(
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(left: 20),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 30,
              child: Image.asset(Assets.algaTextLogo, height: 36, width: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem({
    required AppIcons icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          AppIcon(icon),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppThemeData.mainTextColor,
                )),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
