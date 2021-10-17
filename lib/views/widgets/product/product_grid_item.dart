import 'package:alga/data/app_routes.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/models/product.dart';
import 'package:alga/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../app_network_image.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final String? heroTag;

  const ProductGridItem({
    Key? key,
    required this.product,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeData.surface,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.2,
            blurRadius: 12,
            color: AppThemeData.mainTextColor.withOpacity(0.2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          ProductController.I.productDetails = product;
          Get.toNamed(AppRoutes.productDetails);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  width: double.infinity,
                  child: (product.images?.isNotEmpty ?? false)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: AppNetworkImage(
                            imageUrl: product.images?[0].url ?? '',
                          ),
                        )
                      : const SizedBox(),
                ),
                // CarouselWithIndicator(images: product.images ?? []),
                product.status == ProductStatus.VIP
                    ? Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.crown,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'VIP',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title ?? '',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppThemeData.mainTextColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    product.priceWCurrency == null
                        ? 'under_contract'.tr
                        : product.priceWCurrency!,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppThemeData.mainTextColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  product.location != null
                      ? Text(
                          product.location!.name,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                AppThemeData.secondTextColor.withOpacity(0.4),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
