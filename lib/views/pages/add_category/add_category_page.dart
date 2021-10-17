import 'package:alga/views/widgets/rounded_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import 'controller.dart';

class AddCategoryPage extends StatelessWidget {
  final _controller = Get.put(AddCategoryPageController());
  final _titleTextControllerRU = TextEditingController();
  final _titleTextControllerKG = TextEditingController();

  AddCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавление категории')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _titleTextControllerRU,
              decoration: InputDecoration(
                hintText: 'Введите название RU',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _titleTextControllerKG,
              decoration: InputDecoration(
                hintText: 'Введите название KG',
              ),
            ),
            const SizedBox(height: 50),
            Obx(() => ElevatedButton(
                  onPressed: _controller.isLoading
                      ? null
                      : () {
                          _controller.save(
                            _titleTextControllerRU.text,
                            _titleTextControllerKG.text,
                            onSuccess: (category) {
                              Get.back(result: category);
                            },
                          );
                        },
                  child: Text('save'.tr),
                )),
          ],
        ),
      ),
    );
  }
}
