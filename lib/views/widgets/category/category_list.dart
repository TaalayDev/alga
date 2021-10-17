import 'package:alga/data/styles.dart';
import 'package:alga/models/category.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/app_outlined_button.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> list;
  final int selectedIndex;
  final Function(int index, int? id)? onTap;

  const CategoryList({
    Key? key,
    required this.list,
    this.selectedIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            IconButton(
              onPressed: () {
                onTap?.call(0, null);
              },
              icon: AppIcon(AppIcons.grid, size: 35, color: _selectColor(0)),
            ),
            const SizedBox(width: 5),
            ...list
                .asMap()
                .entries
                .map((e) => AppOutlinedButton(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      text: e.value.getTitle,
                      color: _selectColor(e.key + 1),
                      onPressed: () {
                        onTap?.call(e.key + 1, e.value.id);
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  _selectColor(int index) => selectedIndex == index
      ? AppThemeData.primary
      : AppThemeData.mainTextColor.withOpacity(0.5);
}
