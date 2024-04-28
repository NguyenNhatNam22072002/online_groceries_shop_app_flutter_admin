import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';

import '../model/brand_detail_model.dart';

class BrandDetailViewModel extends GetxController {
  final txtBrandName = TextEditingController().obs;
  final RxList<BrandDetailModel> brandDetails = <BrandDetailModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Brand Detail Init ");
    }
    fetchBrandDetails();
  }

  void fetchBrandDetails() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetBrandList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var brandDetailsDataList =
              (resObj[KKey.payload] as List? ?? []).map((obj) {
            return BrandDetailModel.fromJson(obj);
          }).toList();
          brandDetails.value = brandDetailsDataList;
          print("Brand Details: $brandDetails");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch brand details");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void setDataModel(BrandDetailModel bObj) {
    txtBrandName.value.text = bObj.brandName ?? "";
  }

  void clearAll() {
    txtBrandName.value.text = "";
  }

  void createBrandDetail(VoidCallback didDone) {
    if (txtBrandName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter brand name");
      return;
    }

    Globs.showHUD();
    ServiceCall.post({
      "brand_name": txtBrandName.value.text,
    }, SVKey.svCreateBrand, isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        Get.snackbar(Globs.appName, resObj[KKey.message].toString());
        didDone();
        fetchBrandDetails();
      } else {}
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void updateBrandDetail(int brandId, VoidCallback didDone) {
    if (txtBrandName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter brand name");
      return;
    }

    Globs.showHUD();
    ServiceCall.post({
      "brand_id": brandId.toString(),
      "brand_name": txtBrandName.value.text,
    }, SVKey.svUpdateBrand, isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        Get.snackbar(Globs.appName, resObj[KKey.message].toString());
        didDone();
        fetchBrandDetails();
      } else {}
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void deleteBrandDetail(int brandId) async {
    Globs.showHUD();
    ServiceCall.post(
      {"brand_id": brandId.toString()},
      SVKey.svDeleteBrand,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          fetchBrandDetails();
        } else {
          Get.snackbar(Globs.appName, "Failed to delete brand detail");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
