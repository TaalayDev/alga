import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceFromToWidget extends StatelessWidget {
  final int? priceFrom;
  final int? priceTo;
  final Function(String val)? onPriceFromChanged;
  final Function(String val)? onPriceToChanged;

  const PriceFromToWidget({
    Key? key,
    this.priceFrom,
    this.priceTo,
    this.onPriceFromChanged,
    this.onPriceToChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: AppIcons.cash,
      title: 'price'.tr,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: priceFrom?.toString(),
              decoration: InputDecoration(
                hintText: 'from'.tr,
              ),
              onChanged: (value) {
                onPriceFromChanged?.call(value);
              },
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: priceTo?.toString(),
              decoration: InputDecoration(
                hintText: 'to'.tr,
              ),
              onChanged: (value) {
                onPriceToChanged?.call(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
