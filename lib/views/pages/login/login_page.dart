import 'package:alga/repositories/app_repo.dart';
import 'package:alga/utils/app_box.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../user_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Вход'),
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: _loginTextController,
              decoration: InputDecoration(hintText: 'Login'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: _passwordTextController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 50),
            Obx(() => ElevatedButton(
                  onPressed: UserController.I.isLoading.value
                      ? null
                      : () async {
                          if (_loginTextController.text.isNotEmpty &&
                              _loginTextController.text.isNotEmpty) {
                            UserController.I.login(
                              _loginTextController.text,
                              _passwordTextController.text,
                              onSuccess: () {
                                AppBox.isLogin = true;
                                Get.back();
                              },
                              onError: () {
                                Get.snackbar(
                                    'app_title'.tr, 'Не удалось войти');
                              },
                            );
                          } else {
                            Get.snackbar('app_title'.tr, 'Заполните данные');
                          }
                        },
                  child: Text('Войти'),
                )),
          ],
        ),
      ),
    );
  }
}
