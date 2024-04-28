import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';
import '../model/type_model.dart';

class TypeViewModel extends GetxController {
  final txtTypeName = TextEditingController().obs;
  final txtImage = TextEditingController().obs;
  final txtColor = TextEditingController().obs;
  final RxList<TypeModel> types = <TypeModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Type Init ");
    }
    fetchTypes();
  }

  void fetchTypes() async {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.svGetTypeList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          var typesDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return TypeModel.fromJson(obj);
          }).toList();
          types.value = typesDataList;
          print("Types: $types");
        } else {
          Get.snackbar(Globs.appName, "Failed to fetch types");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void setDataModel(TypeModel tObj) {
    txtTypeName.value.text = tObj.typeName ?? "";
    txtImage.value.text = tObj.image ?? "";
    txtColor.value.text = tObj.color?.toString() ?? "";
  }

  void clearAll() {
    txtTypeName.value.text = "";
    txtImage.value.text = "";
    txtColor.value.text = "";
  }

  void createType(VoidCallback didDone) {
    if (txtTypeName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type name");
      return;
    }
    if (txtImage.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please upload Image");
      return;
    }
    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter color");
      return;
    } else {
      // Perform additional validation for color if needed
    }
    Globs.showHUD();
    ServiceCall.post(
      {
        "type_name": txtTypeName.value.text,
        "image": txtImage.value.text,
        "color": txtColor.value.text,
      },
      SVKey.svCreateType,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          didDone();
          fetchTypes();
        } else {}
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void updateType(int typeId, VoidCallback didDone) {
    if (txtTypeName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type name");
      return;
    }
    if (txtImage.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please upload Image");
      return;
    }
    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter color");
      return;
    } else {
      // Perform additional validation for color if needed
    }
    Globs.showHUD();
    ServiceCall.post(
      {
        "type_id": typeId.toString(),
        "type_name": txtTypeName.value.text,
        "image": txtImage.value.text,
        "color": txtColor.value.text,
      },
      SVKey.svUpdateType,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          didDone();
          fetchTypes();
        } else {}
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }

  void deleteType(int typeId) async {
    Globs.showHUD();
    ServiceCall.post(
      {"type_id": typeId.toString()},
      SVKey.svDeleteType,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          Get.snackbar(Globs.appName, resObj[KKey.message].toString());
          fetchTypes();
        } else {
          Get.snackbar(Globs.appName, "Failed to delete type");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
