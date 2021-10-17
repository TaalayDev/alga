import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  grid,
  plus_circle,
  share,
  info_circle,
  globe,
  checks_grid,
  geo_alt,
  cash,
  house,
  hamburger_menu,
  telephone,
  whatsapp,
  vip_crown,
  search,
  filter,
  notifications,
}

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color? color;

  const AppIcon(
    this.icon, {
    Key? key,
    this.size = 25,
    this.color = const Color(0xff636363),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String iconName = describeEnum(icon).toLowerCase();
    return Container(
      height: size,
      width: size,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg_icons/' + iconName + '.svg',
          color: color,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
