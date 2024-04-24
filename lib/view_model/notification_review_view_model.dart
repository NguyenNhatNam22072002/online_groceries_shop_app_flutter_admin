import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/notification_review_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/user_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class NotificationReviewViewModel extends GetxController {
  final RxList<NotificationReviewModel> notificationList =
      <NotificationReviewModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSalesData();
  }

  void fetchSalesData() async {
    // Gọi hàm post
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetNotificationReviewList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var DataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return NotificationReviewModel.fromJson(obj);
          }).toList();
          notificationList.value = DataList;
          print("NAMANMAANM $notificationList");
        } else {
          // Xử lý trường hợp không thành công
          Get.snackbar(Globs.appName, "Failed to fetch sales data");
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
