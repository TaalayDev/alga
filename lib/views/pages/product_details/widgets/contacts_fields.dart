import 'package:alga/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsFields extends StatelessWidget {
  final String? initialPhone;
  final String? initialWhatsapp;
  final Function(String phone)? onPhoneChanged;
  final Function(String phone)? onWhastappChanged;
  const ContactsFields({
    Key? key,
    this.initialPhone,
    this.initialWhatsapp,
    this.onPhoneChanged,
    this.onWhastappChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'contacts'.tr,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: initialPhone,
              onChanged: onPhoneChanged,
              decoration: InputDecoration(
                hintText: 'phone'.tr,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: initialWhatsapp,
              onChanged: onWhastappChanged,
              decoration: InputDecoration(
                hintText: 'whatsapp'.tr,
              ),
            ),
          )
        ],
      ),
    );
  }
}
