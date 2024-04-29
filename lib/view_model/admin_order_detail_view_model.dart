import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/product_detail_model.dart';

class AdminOrderDetailViewModel extends GetxController {
  final String orderId;
  final String userId;
  final sOrderObj = OrderDetailModel().obs;
  final RxList<ProductDetailModel> cartList = <ProductDetailModel>[].obs;
  final isLoading = true.obs;

  AdminOrderDetailViewModel(this.orderId, this.userId);

  @override
  void onInit() {
    super.onInit();
    serviceCallDetail();
  }

  //MARK ServiceCall
  void serviceCallDetail() {
    isLoading.value = true;
    ServiceCall.post({
      "order_id": orderId.toString(),
      "user_id": userId.toString(),
    }, SVKey.svAdminOrderDetail, isToken: true, withSuccess: (resObj) async {
      isLoading.value = false;

      if (resObj[KKey.status] == "1") {
        var payload = resObj[KKey.payload];

        sOrderObj.value = OrderDetailModel.fromJson(payload);

        var cartListData = payload["cart_list"] as List? ?? [];
        cartList.value = cartListData.map((oObj) {
          return ProductDetailModel.fromJson(oObj);
        }).toList();
      } else {
        // Handle error or show message if needed
      }
    }, failure: (err) async {
      isLoading.value = false;
      // Handle error or show message if needed
    });
  }
}
