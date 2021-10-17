import 'package:alga/data/styles.dart';
import 'package:alga/user_controller.dart';
import 'package:alga/views/pages/about/controller.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAppPage extends StatelessWidget {
  final _textController = TextEditingController();

  AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('about_app'.tr),
      ),
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GetBuilder<AboutAppPageController>(
            init: AboutAppPageController(),
            builder: (controller) {
              return Obx(() {
                if (!UserController.I.isLogin.value)
                  return Text(
                    controller.settings?.appShortDescription ?? '',
                    textAlign: TextAlign.justify,
                  );

                return Column(
                  children: <Widget>[
                    TextFormField(
                      controller: controller.textController,
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: 'Text...',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              controller.updateAppDescription();
                            },
                      child: Text(
                        'save'.tr,
                        style: TextStyle(color: AppThemeData.onPrimary),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppThemeData.primary,
                      ),
                    )
                  ],
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
