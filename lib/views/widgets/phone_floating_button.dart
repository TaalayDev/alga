import 'package:alga/data/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class PhoneFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.only(right: 10, bottom: 0, left: 42),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppThemeData.primary,
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                padding: EdgeInsets.all(5),
                child: Icon(
                  MaterialCommunityIcons.whatsapp,
                  color: Colors.white,
                  size: 16,
                )),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'give_ads'.tr,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '+996 770 777 777',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
