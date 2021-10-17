import 'package:alga/data/const.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/models/dropdown_item.dart';
import 'package:alga/models/product.dart';
import 'package:alga/utils/notifications_manager.dart';
import 'package:alga/views/pages/add_product/controller.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:alga/views/widgets/custom_card.dart';
import 'package:alga/views/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(AddProductPageController());

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Добавить объявление'),
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
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          children: [
            InkWell(
              onTap: () {
                _controller.startFilePicker();
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppThemeData.primaryTint,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.4,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Obx(() {
                  if (_controller.selectedImage.value != null)
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: AssetThumb(
                        asset: _controller.selectedImage.value!,
                        width: 500,
                        height: 500,
                      ),
                    );

                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MaterialCommunityIcons.camera_image,
                          color: AppThemeData.onPrimary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Добавить изображение',
                          style: TextStyle(color: AppThemeData.onPrimary),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWithTitle(
              title: 'Загаловок',
              controller: _titleController,
            ),
            TextFieldWithTitle(
              title: 'Описание',
              controller: _descController,
              maxLines: 5,
            ),
            TextFieldWithTitle(
              title: 'Тел',
              controller: _phoneController,
              icon: MaterialCommunityIcons.phone,
              keyboardType: TextInputType.number,
            ),
            TextFieldWithTitle(
              title: 'WhatsApp',
              controller: _whatsappController,
              icon: MaterialCommunityIcons.whatsapp,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 5),
            TextFieldWithTitle(
              title: 'Цена',
              hintText: 'under_contract'.tr,
              icon: MaterialCommunityIcons.cash,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _controller.price.value = value;
              },
            ),
            Obx(() => CustomDropdownButton(
                  value: _controller.selectedCurrencyId.value ??
                      (_controller.currencyList.isNotEmpty
                          ? _controller.currencyList.first.id
                          : null),
                  onItemSelected: (item) {
                    _controller.selectedCurrencyId.value = item.value;
                  },
                  items: _controller.currencyList.value
                      .map((element) => DropdownItem(
                            title: element.symbol ?? '',
                            value: element.id,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 30),
            Obx(() => CustomDropdownButton(
                  hint: 'category'.tr,
                  value: _controller.selectedCategoryId.value,
                  onItemSelected: (item) {
                    _controller.selectedCategoryId.value = item.value;
                  },
                  items: _controller.categoryList.value
                      .map((element) => DropdownItem(
                            title: element.getTitle,
                            value: element.id,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 10),
            Obx(() => CustomDropdownButton(
                  hint: 'metro_station'.tr,
                  value: _controller.selectedLocationId.value,
                  onItemSelected: (item) {
                    _controller.selectedLocationId.value = item.value;
                  },
                  items: _controller.locationList.value
                      .map((element) => DropdownItem(
                            title: element.name,
                            value: element.id,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 20),
            CustomCard(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(AppIcons.vip_crown),
                  Obx(() => Switch(
                        value: _controller.status.value == ProductStatus.VIP,
                        onChanged: (val) {
                          _controller.status.value =
                              val ? ProductStatus.VIP : ProductStatus.USUAL;
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Obx(() => ElevatedButton(
                  child: Text('save'.tr),
                  onPressed: _controller.loading.value
                      ? null
                      : () {
                          if (_titleController.text.isEmpty) {
                            Get.snackbar('app_title'.tr, 'Введите загаловок');
                          } else if (_descController.text.isEmpty) {
                            Get.snackbar('app_title'.tr, 'Введите описание');
                          } else if (_phoneController.text.isEmpty) {
                            Get.snackbar('app_title'.tr, 'Введите телефон');
                          } else {
                            _controller.save(
                              {
                                'name': _titleController.text,
                                'description': _descController.text,
                                'phone': _phoneController.text,
                                'whatsapp': _whatsappController.text,
                              },
                              onSuccess: () {
                                PushNotificationsManager().sendPushMessage(
                                    _titleController.text,
                                    _descController.text);
                                Get.back();
                                Get.snackbar(
                                    'app_title'.tr, 'Успешно добавлено');
                              },
                              onError: (data) {
                                Get.snackbar(
                                    'app_title'.tr, 'Ошибка при добавлении');
                              },
                            );
                          }
                        },
                )),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final String? hintText;
  final IconData? icon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String val)? onChanged;

  const TextFieldWithTitle({
    required this.title,
    this.hintText,
    this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: hintText,
          ),
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
