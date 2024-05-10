import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/image_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/product_detail_model.dart';

import '../model/offer_product_model.dart';

class ProductManagementViewModel extends GetxController {
  final RxList<OfferProductModel> bestSellingArr = <OfferProductModel>[].obs;
  final RxList<ProductDetailModel> productDetails = <ProductDetailModel>[].obs;
  final txtProName = TextEditingController().obs;
  final txtDetail = TextEditingController().obs;
  final txtUnitName = TextEditingController().obs;
  final txtUnitValue = TextEditingController().obs;
  final txtNutritionWeight = TextEditingController().obs;
  final txtPrice = TextEditingController().obs;
  final RxList<ImageModel> imageList = <ImageModel>[].obs;
  final isLoading = false.obs;

  int _currentBestSellingPage = 0;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Best Selling Init ");
    }
    serviceCallHomeBestSelling();
    fetchProductDetails();
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
          var bestSellingDataArr =
              (payload["best_sell_list"] as List? ?? []).map((oObj) {
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

  void fetchProductDetails() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetProductsList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var productDetailsDataList =
              (resObj[KKey.payload] as List? ?? []).map((obj) {
            return ProductDetailModel.fromJson(obj);
          }).toList();
          productDetails.value = productDetailsDataList;
          print("Product Details: $productDetails");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch product details");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void deleteProduct(int productId) {
    Globs.showHUD();
    ServiceCall.post(
      {"prod_id": productId.toString()},
      SVKey.svDeleteProduct,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          productDetails.removeWhere((e) => e.prodId == productId);
        } else {
          Get.snackbar(Globs.appName,
              resObj[KKey.message] ?? "Failed to delete product");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        // Handle failure
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
