import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';

import '../model/category_detail_model.dart';

class CategoryDetailViewModel extends GetxController {
  final txtCatName = TextEditingController().obs;
  final txtColor = TextEditingController().obs;
  File? selectImage;
  final RxList<CategoryDetailModel> categoryDetails =
      <CategoryDetailModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Category Detail Init ");
    }
    fetchCategoryDetails();
  }

  void fetchCategoryDetails() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetCategoryList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var categoryDetailsDataList =
              (resObj[KKey.payload] as List? ?? []).map((obj) {
            return CategoryDetailModel.fromJson(obj);
          }).toList();
          categoryDetails.value = categoryDetailsDataList;
          print("Category Details: $categoryDetails");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch category details");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void setDataModel(CategoryDetailModel cObj) {
    txtCatName.value.text = cObj.catName ?? "";
    txtColor.value.text = cObj.color?.toString() ?? "";
    selectImage = cObj.image != null ? File(cObj.image!) : null;
  }

  void clearAll() {
    txtCatName.value.text = "";
    txtColor.value.text = "";
    selectImage = null;
  }

  void createCategoryDetail(VoidCallback didDone) {
    if (txtCatName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter category name");
      return;
    }
    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter color");
      return;
    } else {
      // Perform additional validation for color if needed
    }

    Globs.showHUD();
    ServiceCall.multipart(
      {
        "cat_name": txtCatName.value.text,
        "color": txtColor.value.text
            .replaceAll('0xff', '')
            .replaceAll('Color(', '')
            .replaceAll(')', '')
            .replaceAll('#', ''),
      },
      SVKey.svCreateCategory,
      isTokenApi: true,
      imgObj: {"image": selectImage!},
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          didDone();
          fetchCategoryDetails();
        } else {
          Get.snackbar(Globs.appName, "Failed to create category detail");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void updateCategoryDetail(int catID, VoidCallback didDone) {
    if (txtCatName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter category name");
      return;
    }
    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter color");
      return;
    } else {
      // Perform additional validation for color if needed
    }
    Globs.showHUD();
    ServiceCall.multipart(
      {
        "cat_id": catID.toString(),
        "cat_name": txtCatName.value.text,
        "color": txtColor.value.text
            .replaceAll('0xff', '')
            .replaceAll('Color(', '')
            .replaceAll(')', '')
            .replaceAll('#', ''),
      },
      SVKey.svUpdateCategory,
      isTokenApi: true,
      imgObj: {"image": selectImage!},
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          didDone();
          fetchCategoryDetails();
        } else {
          Get.snackbar(Globs.appName, "Failed to update category detail");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void deleteCategoryDetail(int categoryId) async {
    Globs.showHUD();
    ServiceCall.post(
      {"cat_id": categoryId.toString()},
      SVKey.svDeleteCategory,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          fetchCategoryDetails();
        } else {
          Get.snackbar(Globs.appName, "Failed to delete category detail");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
