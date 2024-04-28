import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/user_model.dart';

import '../common/globs.dart';
import '../common/service_call.dart';

class UserManagementViewModel extends GetxController {
  final RxList<UserModel> userList = <UserModel>[].obs;
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
      SVKey.svGetUserList,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();

        if (resObj[KKey.status] == "1") {
          var userDataList = (resObj[KKey.payload] as List? ?? []).map((obj) {
            return UserModel.fromJson(obj);
          }).toList();
          userList.value = userDataList;
          print("NAMANMAANM $userList");
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

  // Function to delete a user
// Modify the deleteUser function to reload the user data after deletion
  void deleteUser(int userId) async {
    Globs.showHUD();
    ServiceCall.post(
      {"userId": userId.toString()},
      SVKey.svDeleteUser,
      isToken: true,
      withSuccess: (resObj) async {
        Globs.hideHUD();
        if (resObj[KKey.status] == "1") {
          fetchSalesData();
        } else {
          Get.snackbar(
              Globs.appName, resObj["message"] ?? "Failed to delete user");
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        Get.snackbar(Globs.appName, err.toString());
      },
    );
  }
}
