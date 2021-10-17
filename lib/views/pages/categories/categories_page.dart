import 'package:alga/data/app_routes.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/views/pages/categories/controller.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatelessWidget {
  final _controller = Get.put(CategoriesPageController());

  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Категории',
          style: TextStyle(color: AppThemeData.mainTextColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.addCategory);
          if (result != null) {
            _controller.fetchCategories();
          }
        },
        child: Icon(Icons.add),
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
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Obx(() {
              if (_controller.isLoading.value)
                return Center(child: CircularProgressIndicator());

              return ListView.builder(
                itemBuilder: (context, index) {
                  final category = _controller.categoryList[index];
                  return ListTile(
                    title: Text(category.getTitle),
                    trailing: IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.only(top: 20),
                          title: 'Удалить категорию?',
                          middleText: '',
                          textConfirm: 'Да',
                          textCancel: 'Отмена',
                          onConfirm: () {
                            Get.back();
                            _controller.deleteCategory(category, onSuccess: () {
                              _controller.fetchCategories();
                            });
                          },
                        );
                      },
                      icon: Icon(Icons.delete_forever),
                    ),
                  );
                },
                itemCount: _controller.categoryList.length,
              );
            }),
          ),
        ),
      ),
    );
  }
}
