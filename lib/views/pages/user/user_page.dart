import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../user_controller.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Админ'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Obx(() {
          if (!UserController.I.isLogin.value) return Container();

          return Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Номер WhatsApp',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Пароль',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Сактоо",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
