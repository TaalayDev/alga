import 'package:alga/data/app_routes.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/utils/app_box.dart';
import 'package:alga/views/widgets/app_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/const.dart';
import 'controller.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartPageController>(
        init: StartPageController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Image.asset(
                    Assets.algaTextLogo,
                    fit: BoxFit.fitWidth,
                    height: 40,
                  ),
                ),
                if (controller.ready)
                  AppOutlinedButton(
                    text: 'Кыргызча',
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 20, top: 120),
                    onPressed: () async {
                      _changeLocale(Locale('kg', 'KG'));
                    },
                  ),
                if (controller.ready)
                  AppOutlinedButton(
                    text: 'Русский',
                    width: 100,
                    onPressed: () async {
                      _changeLocale(Locale('ru', 'RU'));
                    },
                  ),
              ],
            )),
          );
        });
  }

  _changeLocale(Locale locale) {
    AppBox.locale = locale;
    Get.updateLocale(locale);
    Get.toNamed(AppRoutes.home);
  }
}
