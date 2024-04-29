import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/sale_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class SalesManagementViewModel extends GetxController {
  final RxList<SalesManagementModel> salesList = <SalesManagementModel>[].obs;
  final totalOrders = 0.obs;
  final totalPrice = 0.0.obs;
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
          var payload = resObj['payload'] as Map<String, dynamic>;

          // Lấy tổng số đơn hàng
          var totalOrderSummary =
              payload['total_order_summary'] as Map<String, dynamic>;
          totalOrders.value = totalOrderSummary['total_orders'] as int? ?? 0;

          // Lấy tổng giá trị đơn hàng
          var totalPriceSummary =
              payload['total_price_summary'] as Map<String, dynamic>;
          totalPrice.value =
              totalPriceSummary['user_pay_price'] as double? ?? 0.0;

          // Lấy danh sách các đơn hàng
          var salesDataList =
              (payload['sales_summary_last_7_months'] as List<dynamic>? ?? [])
                  .map((obj) {
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
