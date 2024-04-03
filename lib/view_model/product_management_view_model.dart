import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';

import '../model/offer_product_model.dart';

class ProductManagementViewModel extends GetxController {
  final RxList<OfferProductModel> bestSellingArr = <OfferProductModel>[].obs;
  final isLoading = false.obs;

  int _currentBestSellingPage = 0;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Best Selling Init ");
    }
    serviceCallHomeBestSelling();
  }

  void serviceCallHomeBestSelling() {
    _currentBestSellingPage++;
    Globs.showHUD();
    ServiceCall.post(
      {'page': _currentBestSellingPage.toString()},
      SVKey.svTop10Product,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var payload = resObj[KKey.payload] as Map? ?? {};
          var bestSellingDataArr = (payload["best_sell_list"] as List? ?? []).map((oObj) {
            return OfferProductModel.fromJson(oObj);
          }).toList();
          bestSellingArr.addAll(bestSellingDataArr);
        } else {
          // Xử lý khi có lỗi từ API
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        // Hiển thị thông báo lỗi
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
