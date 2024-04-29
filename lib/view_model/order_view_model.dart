import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_management_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class OrderViewModel extends GetxController {
  final RxList<OrderModel> neworderList = <OrderModel>[].obs;
  final RxList<OrderModel> completedorderList = <OrderModel>[].obs;
  final RxList<OrderModel> acceptedOrderList = <OrderModel>[].obs;
  final RxList<OrderModel> processingOrderList = <OrderModel>[].obs;
  final RxList<OrderModel> deliveringOrderList = <OrderModel>[].obs;
  final RxList<OrderModel> canceledOrderList = <OrderModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getNewOrderData() async {
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
          Get.snackbar(Globs.appName, "Failed to fetch order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getCompletedOrderData() async {
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
          Get.snackbar(Globs.appName, "Failed to fetch order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getAcceptedOrderData() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetAcceptedOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          acceptedOrderList.value = orderDataList;
          print("Accepted Order List: $acceptedOrderList");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch accepted order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getProcessingOrderData() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetProcessingOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          processingOrderList.value = orderDataList;
          print("Processing Order List: $processingOrderList");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch processing order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getDeliveringOrderData() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetDeliveringOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          deliveringOrderList.value = orderDataList;
          print("Delivering Order List: $deliveringOrderList");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch delivering order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void getCanceledOrderData() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetCanceledOrders,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var orderDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return OrderModel.fromJson(obj);
          }).toList();
          canceledOrderList.value = orderDataList;
          print("Canceled Order List: $canceledOrderList");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch canceled order data");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void updateOrderStatus({
    required String orderId,
    required String userId,
    required int orderStatus,
  }) async {
    Globs.showHUD();
    ServiceCall.post(
      {
        'order_id': orderId,
        'user_id': userId,
        'order_status': orderStatus.toString(),
      },
      SVKey.svOrderStatusChange,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          getNewOrderData();
          getCompletedOrderData();
          getAcceptedOrderData();
          getProcessingOrderData();
          getDeliveringOrderData();
          getCanceledOrderData();
        } else {
          Get.snackbar(Globs.appName, "Failed to update order status");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

}
