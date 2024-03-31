import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_management_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class OrderViewModel extends GetxController {
  final RxList<OrderModel> neworderList = <OrderModel>[].obs;
  final RxList<OrderModel> completedorderList = <OrderModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getNewOrderData() async {
    // Gọi hàm post
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetNewOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          neworderList.value = orderDataList;
          print("Order List: $neworderList");
        } else {
          // Xử lý trường hợp không thành công
          Get.snackbar(Globs.appName, "Failed to fetch order data");
        }
      },
      failure: (err) async {
        // Xử lý lỗi từ server
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getCompletedOrderData() async {
    // Gọi hàm post
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetCompletedOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          completedorderList.value = orderDataList;
          print("Order List: $completedorderList");
        } else {
          // Xử lý trường hợp không thành công
          Get.snackbar(Globs.appName, "Failed to fetch order data");
        }
      },
      failure: (err) async {
        // Xử lý lỗi từ server
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
