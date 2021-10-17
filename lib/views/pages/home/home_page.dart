import 'package:alga/data/const.dart';
import 'package:alga/data/styles.dart';
import 'package:alga/product_controller.dart';
import 'package:alga/utils/app_box.dart';
import 'package:alga/views/pages/home/controller.dart';
import 'package:alga/views/pages/home/widgets/app_bar.dart';
import 'package:alga/views/pages/home/widgets/filter.dart';
import 'package:alga/views/widgets/app_expandable.dart';
import 'package:alga/views/widgets/app_icon.dart';
import 'package:alga/views/widgets/bottom_navigation.dart';
import 'package:alga/views/widgets/category/category_list.dart';
import 'package:alga/views/widgets/navigation_drawer.dart';
import 'package:alga/views/widgets/product/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final _controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: NavigationDrawer(
        callBack: (val) {},
      ),
      floatingActionButton: Obx(
        () => _controller.bannerAd != null
            ? Container(
                height: 60,
                margin: const EdgeInsets.only(right: 10, bottom: 0, left: 42),
                child: AdWidget(ad: _controller.bannerAd!),
              )
            : SizedBox(),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _controller.fetchMoreProducts();
          }
          return true;
        },
        child: Obx(() => CustomScrollView(
              slivers: <Widget>[
                HomeAppBar(),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: AppExpandable(
                    expand: _controller.openFilter.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: HomeFilter(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 100),
                    child: _controller.openFilter.value
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CategoryList(
                                  list: _controller.categoryList.value,
                                  selectedIndex:
                                      _controller.selectedCategoryIndex.value,
                                  onTap: (index, id) {
                                    _controller.selectedCategoryIndex.value =
                                        index;
                                    _controller.fetchCategoryProducts();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: GetBuilder<ProductController>(
                                    builder: (controller) {
                                  if (controller.productList.isEmpty)
                                    return Container(
                                      height: Get.height - 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _controller.loadingProducts.value
                                              ? const CircularProgressIndicator()
                                              : Text(
                                                  'no_ads_yet',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppThemeData
                                                        .mainTextColor
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );

                                  return ProductGrid(
                                    list: controller.productList,
                                  );
                                }),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onMenuTap: () {
          _key.currentState?.openDrawer();
        },
      ),
    );
  }
}
