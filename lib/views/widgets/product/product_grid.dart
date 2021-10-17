import 'package:alga/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> list;
  final String? heroTag;

  const ProductGrid({
    Key? key,
    required this.list,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount: list.isEmpty ? 4 : list.length,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return list.isEmpty
            ? Container()
            : ProductGridItem(
                product: list[index],
                heroTag: heroTag,
              );
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
    );
  }
}
