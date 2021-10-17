import 'package:alga/views/pages/about/about_app_page.dart';
import 'package:alga/views/pages/add_category/add_category_page.dart';
import 'package:alga/views/pages/add_product/add_product_page.dart';
import 'package:alga/views/pages/categories/categories_page.dart';
import 'package:alga/views/pages/home/home_page.dart';
import 'package:alga/views/pages/notifications/notification_page.dart';
import 'package:alga/views/pages/product_details/product_details.dart';
import 'package:alga/views/pages/start/start_page.dart';
import 'package:alga/views/pages/user/user_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String start = '/start';
  static const String home = '/home';
  static const String productDetails = '/product_details';
  static const String user = '/user';
  static const String categories = '/categories';
  static const String addCategory = '/add_category';
  static const String notification = '/notification';
  static const String addProduct = '/add_product';
  static const String aboutApp = '/about_app';

  static String get initialRoute => start;

  static final pages = [
    GetPage(name: start, page: () => StartPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(
      name: productDetails,
      page: () => ProductDetails(),
    ),
    GetPage(name: user, page: () => UserPage()),
    GetPage(name: categories, page: () => CategoriesPage()),
    GetPage(name: addCategory, page: () => AddCategoryPage()),
    GetPage(name: notification, page: () => NotificationPage()),
    GetPage(name: addProduct, page: () => AddProductPage()),
    GetPage(name: aboutApp, page: () => AboutAppPage()),
  ];
}
