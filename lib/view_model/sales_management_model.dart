import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/sale_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class SalesManagementViewModel extends GetxController {
  final RxList<SalesManagementModel> salesList = <SalesManagementModel>[].obs;
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
      SVKey.svGetSalesData,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var salesDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return SalesManagementModel.fromJson(obj);
          }).toList();
          salesList.value = salesDataList;
          print("NAMANMAANM $salesList");
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
