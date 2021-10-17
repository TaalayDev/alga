import 'package:alga/data/styles.dart';
import 'package:alga/models/dropdown_item.dart';
import 'package:alga/models/sort_item.dart';
import 'package:alga/views/pages/home/controller.dart';
import 'package:alga/views/pages/home/widgets/price_from_to_widget.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/custom_card.dart';
import 'package:alga/views/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFilter extends StatefulWidget {
  HomeFilter({
    Key? key,
  }) : super(key: key);

  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  final _sortItems = [
    SortItem(title: 'by_default'.tr, value: 1, orderBy: 'id', sortBy: 'desc'),
    SortItem(title: 'first_new'.tr, value: 2, orderBy: 'id', sortBy: 'desc'),
    SortItem(
      title: 'cheap_first'.tr,
      value: 3,
      orderBy: 'price',
      sortBy: 'asc',
    ),
    SortItem(
      title: 'expensive_first'.tr,
      value: 4,
      orderBy: 'price',
      sortBy: 'desc',
    ),
  ];

  final _controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownButton(
          icon: AppIcon(AppIcons.checks_grid, size: 20),
          hint: 'category'.tr,
          value: _controller.getSelectedCategory()?.id,
          onItemSelected: (item) {
            _controller.selectedCategoryIndex.value = _controller.categoryList
                    .indexWhere((element) => element.id == item.value) +
                1;
          },
          items: _controller.categoryList
              .map((element) =>
                  DropdownItem(title: element.getTitle, value: element.id))
              .toList(),
        ),
        const SizedBox(height: 15),
        Obx(() => CustomDropdownButton(
              icon: AppIcon(AppIcons.geo_alt, size: 20),
              hint: 'metro_station'.tr,
              value: _controller.selectedLocationId.value,
              onItemSelected: (item) {
                _controller.selectedLocationId.value = item.value;
              },
              items: _controller.locationList
                  .map((element) =>
                      DropdownItem(title: element.name, value: element.id))
                  .toList(),
            )),
        const SizedBox(height: 15),
        Obx(() => PriceFromToWidget(
              priceFrom: _controller.priceFrom.value,
              priceTo: _controller.priceTo.value,
              onPriceFromChanged: (value) {
                _controller.priceFrom.value = int.tryParse(value);
              },
              onPriceToChanged: (value) {
                _controller.priceTo.value = int.tryParse(value);
              },
            )),
        const SizedBox(height: 20),
        CustomCard(
          icon: AppIcons.grid,
          iconColor: AppThemeData.primary,
          title: 'sort'.tr,
          child: Column(
            children: _sortItems
                .map((e) => Obx(() => _radio(
                      text: e.title,
                      value: e.value,
                      groupValue: _controller.sortItemValue.value,
                      onChanged: (val) {
                        try {
                          _controller.sortItemValue.value = val;
                          final sortItem = _sortItems
                              .firstWhere((element) => element.value == val);
                          _controller.orderBy.value = sortItem.orderBy;
                          _controller.sortBy.value = sortItem.sortBy;
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    )))
                .toList(),
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            _controller.openFilter.value = false;
            _controller.filterProducts();
          },
          child: Text('apply'.tr),
        ),
      ],
    );
  }

  Widget _radio({
    required String text,
    value,
    groupValue,
    Function(dynamic val)? onChanged,
  }) =>
      InkWell(
        onTap: () {
          onChanged?.call(value);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: AppThemeData.mainTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Radio<dynamic>(
                  value: value,
                  groupValue: groupValue,
                  onChanged: (val) {
                    onChanged?.call(val);
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
