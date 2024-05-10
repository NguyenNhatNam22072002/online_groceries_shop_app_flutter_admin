import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/brand/brand_detail_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/category/category_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/home/home_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/notification/notification_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/orders_management.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/product/product_list_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/product/product_add_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/type/type_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/user/user_list_view.dart';

import '../../common/color_extension.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;
  // final favVM = Get.put(FavoriteViewModel());

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller = TabController(length: 6, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;

      if (selectTab == 3) {
        // favVM.serviceCalList();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: controller, children: [
        HomeView(),
        ProductListView(),
        OrderListView(),
        UserListView(),
        NotificationListView(),
        CategoryDetailView(),
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(0, -2))
            ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: TextStyle(
                color: TColor.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: TColor.primaryText,
              unselectedLabelStyle: TextStyle(
                color: TColor.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(
                  text: "Home",
                  icon: Icon(
                    Icons.house,
                    size: 25,
                    color: selectTab == 0 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Product",
                  icon: Icon(
                    Icons.category,
                    size: 25,
                    color: selectTab == 1 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Order",
                  icon: Icon(
                    Icons.shopping_bag,
                    size: 25,
                    color: selectTab == 2 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "User",
                  icon: Icon(
                    Icons.person,
                    size: 25,
                    color: selectTab == 3 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Notifications",
                  icon: Icon(
                    Icons.notification_add,
                    size: 25,
                    color: selectTab == 4 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                    text: "Categories",
                    icon: Icon(
                      Icons.category,
                      size: 25,
                      color:
                          selectTab == 5 ? TColor.primary : TColor.primaryText,
                    )),
              ]),
        ),
      ),
    );
  }
}
