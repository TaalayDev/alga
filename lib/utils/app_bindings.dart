import 'package:alga/navigaton_controller.dart';
import 'package:alga/repositories/app_repo.dart';
import 'package:alga/repositories/category_repo.dart';
import 'package:alga/repositories/product_repo.dart';
import 'package:get/get.dart';

import '../product_controller.dart';
import '../user_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepo());
    Get.put(CategoryRepo());
    Get.put(AppRepo());

    Get.put(NavigationController());
    Get.put(ProductController());
    Get.put(UserController());
  }
}
