import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/offer_product_model.dart';

class SearchModel extends GetxController {
  final RxList<OfferProductModel> listArrSearch = <OfferProductModel>[].obs;

  final isLoading = false.obs;

  String keyword = "";

  SearchModel({required String keyword});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (kDebugMode) {
      print("SearchModel Init ");
    }

    serviceCallListSearch(keyword);
  }

  void updateKeyword(String newKeyword) {
    keyword = newKeyword;
    // Gọi lại hàm serviceCallListSearch khi keyword thay đổi
    serviceCallListSearch(keyword);
  }

  //ServiceCall
  void serviceCallListSearch(String keyword) {
    Globs.showHUD();
    ServiceCall.post(
      {"keyword": keyword}, // Pass the keyword to the API
      SVKey.svSearchProduct,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var listDataArr = (resObj[KKey.payload] as List? ?? []).map((oObj) {
            return OfferProductModel.fromJson(oObj);
          }).toList();

          listArrSearch.value = listDataArr;
          print("NAMANAMANAMANAMANAM");
        } else {
          // Handle other cases if needed
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
