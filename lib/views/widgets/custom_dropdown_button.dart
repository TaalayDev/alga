import 'package:alga/data/styles.dart';
import 'package:alga/models/dropdown_item.dart';
import 'package:alga/views/widgets/app_expandable.dart';
import 'package:flutter/material.dart';
import 'package:animate_icons/animate_icons.dart';

class CustomDropdownButton extends StatefulWidget {
  final Widget? icon;
  final dynamic value;
  final String hint;
  final List<DropdownItem> items;
  final Function(DropdownItem)? onItemSelected;

  const CustomDropdownButton({
    Key? key,
    this.icon,
    this.value,
    this.hint = '',
    required this.items,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late final AnimateIconController _animateIconController;
  bool _menuOpened = false;

  @override
  void initState() {
    _animateIconController = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedItem = widget.value != null
        ? widget.items.firstWhere((element) => element.value == widget.value)
        : null;
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: () {
            _openCloseMenu();
          },
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(
                width: 1.5,
                color: _menuOpened
                    ? AppThemeData.primary.withOpacity(0.3)
                    : Colors.transparent,
              ),
            ),
            child: ListTile(
              leading: widget.icon,
              contentPadding: EdgeInsets.only(left: 12),
              title: Text(
                _selectedItem != null ? _selectedItem.title : widget.hint,
                style: TextStyle(
                  fontSize: 14,
                  color: AppThemeData.mainTextColor
                      .withOpacity(_selectedItem != null ? 1.0 : 0.6),
                ),
              ),
              trailing: AnimateIcons(
                startIcon: Icons.keyboard_arrow_down,
                endIcon: Icons.keyboard_arrow_up,
                endIconColor: AppThemeData.mainTextColor,
                startIconColor: AppThemeData.mainTextColor,
                duration: Duration(milliseconds: 500),
                onEndIconPress: () {
                  _openCloseMenu();
                  return true;
                },
                onStartIconPress: () {
                  _openCloseMenu();
                  return true;
                },
                controller: _animateIconController,
              ),
            ),
          ),
        ),
        AppExpandable(
          expand: _menuOpened,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: widget.items.asMap().entries.map(
                    (e) {
                      Color _textColor = AppThemeData.mainTextColor;
                      Decoration? _decoration;
                      if (e.value == _selectedItem) {
                        _textColor = AppThemeData.onPrimary;
                        _decoration = BoxDecoration(
                          color: AppThemeData.primary,
                          borderRadius: BorderRadius.circular(4.0),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          widget.onItemSelected?.call(e.value);
                          _openCloseMenu();
                        },
                        child: Container(
                          decoration: _decoration,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10.0),
                          child: Row(
                            children: [
                              Text(
                                e.value.title,
                                style: TextStyle(
                                  color: _textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _openCloseMenu() => setState(() {
        _menuOpened = !_menuOpened;
        _menuOpened
            ? _animateIconController.animateToEnd()
            : _animateIconController.animateToStart();
      });
}
