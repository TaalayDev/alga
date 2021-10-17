import 'package:alga/data/styles.dart';
import 'package:alga/models/dropdown_item.dart';
import 'package:alga/models/product.dart';
import 'package:alga/product_controller.dart';
import 'package:alga/user_controller.dart';
import 'package:alga/views/pages/product_details/controller.dart';
import 'package:alga/views/pages/product_details/widgets/contacts_fields.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/app_network_image.dart';
import 'package:alga/views/widgets/bottom_navigation.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:alga/views/widgets/custom_card.dart';
import 'package:alga/views/widgets/custom_dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(
        actions: [
          /*IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: AppThemeData.mainTextColor),
          ),*/
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onMenuTap: () {
          _key.currentState?.openDrawer();
        },
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
          padding: const EdgeInsets.only(top: 2.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            children: [
              GetBuilder<ProductController>(
                builder: (controller) {
                  return Container(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: (controller.productDetails?.images?.isNotEmpty ??
                              false)
                          ? AppNetworkImage(
                              imageUrl:
                                  controller.productDetails?.images?[0].url ??
                                      '')
                          : const SizedBox(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<ProductController>(
                      builder: (controller) {
                        return Text(
                          controller.productDetails?.title ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppThemeData.mainTextColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Obx(() {
                      if (UserController.I.isLogin.value)
                        return GetX<ProductDetailsPageController>(
                            init: ProductDetailsPageController(),
                            builder: (controller) {
                              return Column(
                                children: [
                                  CustomDropdownButton(
                                    hint: 'category'.tr,
                                    value: controller.selectedCategoryId.value,
                                    onItemSelected: (item) {
                                      controller.selectedCategoryId.value =
                                          item.value;
                                    },
                                    items: controller.categoryList
                                        .map((element) => DropdownItem(
                                              title: element.getTitle,
                                              value: element.id,
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomDropdownButton(
                                    hint: 'metro_station'.tr,
                                    value: controller.selectedLocationId.value,
                                    onItemSelected: (item) {
                                      controller.selectedLocationId.value =
                                          item.value;
                                    },
                                    items: controller.locationList
                                        .map((element) => DropdownItem(
                                              title: element.name,
                                              value: element.id,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              );
                            });

                      return GetBuilder<ProductController>(
                        builder: (controller) {
                          return Text(
                            controller.productDetails?.location?.name ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  AppThemeData.mainTextColor.withOpacity(0.5),
                            ),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 20),
                    GetBuilder<ProductController>(
                      builder: (controller) {
                        return Text(
                          controller.productDetails?.desc ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppThemeData.mainTextColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (UserController.I.isLogin.value)
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetX<ProductDetailsPageController>(
                              builder: (controller) => ContactsFields(
                                initialPhone: controller.phone.value,
                                initialWhatsapp: controller.whatsapp.value,
                                onPhoneChanged: (phone) {
                                  controller.phone.value = phone;
                                },
                                onWhastappChanged: (whatsapp) {
                                  controller.whatsapp.value = whatsapp;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomCard(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppIcon(AppIcons.vip_crown),
                                  GetX<ProductDetailsPageController>(
                                    builder: (controller) => Switch(
                                      value: controller.status.value ==
                                          ProductStatus.VIP,
                                      onChanged: (val) {
                                        controller.status.value = val
                                            ? ProductStatus.VIP
                                            : ProductStatus.USUAL;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            GetX<ProductDetailsPageController>(
                              builder: (controller) => TextButton(
                                onPressed: controller.loading.value
                                    ? null
                                    : () {
                                        controller.save(
                                          onSuccess: () {
                                            Get.snackbar('app_title'.tr,
                                                'Успешно обновлено');
                                          },
                                          onError: (error) {
                                            Get.snackbar('app_title'.tr,
                                                'Ошибка обновлении');
                                          },
                                        );
                                      },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppThemeData.primary,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 18),
                                ),
                                child: Text(
                                  'save'.tr,
                                  style: TextStyle(
                                    color: AppThemeData.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<ProductController>(
                            builder: (controller) {
                              return Text(
                                controller.productDetails?.priceWCurrency ??
                                    'under_contract'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppThemeData.mainTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '15.08.2021',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  AppThemeData.mainTextColor.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GetBuilder<ProductController>(builder: (controller) {
                            return Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    launch(
                                        'https://api.whatsapp.com/send/?phone=${controller.productDetails?.phone}');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        MaterialCommunityIcons.phone_outline,
                                        color: AppThemeData.mainTextColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'call'.tr,
                                        style: TextStyle(
                                            color: AppThemeData.mainTextColor),
                                      ),
                                    ],
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    side: BorderSide(
                                        color: AppThemeData.mainTextColor),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                if (controller.productDetails?.whatsapp != null)
                                  TextButton(
                                    onPressed: () {
                                      launch(
                                          'https://api.whatsapp.com/send/?phone=${controller.productDetails?.whatsapp}');
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF00E676),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          MaterialCommunityIcons.whatsapp,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'whatsapp'.tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
