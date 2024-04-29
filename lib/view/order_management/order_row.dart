import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/my_order_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_management_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/order_view_model.dart';

class OrderRow extends StatelessWidget {
  final OrderModel mObj;
  final VoidCallback onTap;
  final OrderViewModel orderViewModel;
  final Function(OrderModel) updateOrderStatusCallback;

  const OrderRow(
      {super.key,
      required this.mObj,
      required this.onTap,
      required this.orderViewModel,
      required this.updateOrderStatusCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Order No: #",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                      child: Text(
                    mObj.orderId?.toString() ?? "",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )),
                  getNextStatusText(mObj) != ""
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            //Xử lý khi nhấn vào nút
                            switch (mObj.orderStatus) {
                              case 1:
                                // Nếu trạng thái đơn hàng là "Placed", thực hiện cập nhật trạng thái thành "Accepted"
                                orderViewModel.updateOrderStatus(
                                  orderId: mObj.orderId ?? "",
                                  userId: mObj.userId ?? "",
                                  orderStatus:
                                      2, // Cập nhật trạng thái thành 2 (Accepted)
                                );
                                break;
                              case 2:
                                // Nếu trạng thái đơn hàng là "Accepted", thực hiện cập nhật trạng thái thành "Processing"
                                orderViewModel.updateOrderStatus(
                                  orderId: mObj.orderId ?? "",
                                  userId: mObj.userId ?? "",
                                  orderStatus:
                                      3, // Cập nhật trạng thái thành 3 (Processing)
                                );
                                break;
                              case 3:
                                // Nếu trạng thái đơn hàng là "Processing", thực hiện cập nhật trạng thái thành "Delivering"
                                orderViewModel.updateOrderStatus(
                                  orderId: mObj.orderId ?? "",
                                  userId: mObj.userId ?? "",
                                  orderStatus:
                                      4, // Cập nhật trạng thái thành 4 (Delivering)
                                );
                                break;
                              case 4:
                                // Nếu trạng thái đơn hàng là "Delivering", thực hiện cập nhật trạng thái thành "Delivered"
                                orderViewModel.updateOrderStatus(
                                  orderId: mObj.orderId ?? "",
                                  userId: mObj.userId ?? "",
                                  orderStatus:
                                      5, // Cập nhật trạng thái thành 5 (Delivered)
                                );
                                break;
                              default:
                                // Trạng thái không hợp lệ
                                break;
                            }
                            updateOrderStatusCallback(mObj);
                          },
                          child: Text(
                            getNextStatusText(mObj),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : SizedBox(width: 8),
                ],
              ),
              Text(
                mObj.createdDate.toString() ?? "",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((mObj.productImages?.length ?? 0) > 0)
                    CachedNetworkImage(
                      imageUrl: mObj.productImages?[0] ?? "",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Items: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                child: Text(
                                  mObj.productNames.toString() ?? "",
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Delivery Type: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getDeliverType(mObj),
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Payment Type: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getPaymentType(mObj),
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Payment Status: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getPaymentStatus(mObj),
                                style: TextStyle(
                                    color: getPaymentStatusColor(mObj),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

String getOrderStatus(OrderModel mObj) {
  switch (mObj.orderStatus) {
    case 1:
      return "Placed";
    case 2:
      return "Accepted";
    case 3:
      return "Processing";
    case 4:
      return "Delivering";
    case 5:
      return "Delivered";
    case 6:
      return "Canceled";
    default:
      return "";
  }
}

String getDeliverType(OrderModel mObj) {
  switch (mObj.deliverType) {
    case 1:
      return "Delivery";
    case 2:
      return "Collection";
    default:
      return "";
  }
}

String getPaymentType(OrderModel mObj) {
  switch (mObj.paymentType) {
    case 1:
      return "Cash On Delivery";
    case 2:
      return "Online Card Payment";
    default:
      return "";
  }
}

String getPaymentStatus(OrderModel mObj) {
  //1: waiting, 2: done, 3: fail, 4: refund

  if (mObj.paymentType == 1) {
    return "COD";
  }
  switch (mObj.paymentStatus) {
    case 1:
      return "Processing";
    case 2:
      return "Success";
    case 3:
      return "Fail";
    case 4:
      return "Refunded";
    default:
      return "";
  }
}

Color getPaymentStatusColor(OrderModel mObj) {
  //1: waiting, 2: done, 3: fail, 4: refund

  if (mObj.paymentType == 1) {
    return Colors.orange;
  }
  switch (mObj.paymentStatus) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    case 4:
      return Colors.green;
    default:
      return Colors.white;
  }
}

Color getOrderStatusColor(OrderModel mObj) {
  //1: new, 2: order_accept, 3: order_delivered, 4: cancel, 5: order declined
  switch (mObj.orderStatus) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.green;
    case 4:
      return Colors.green;
    case 5:
      return Colors.green;
    case 6:
      return Colors.red;
    default:
      return TColor.primary;
  }
}

String getNextStatusText(OrderModel mObj) {
  switch (mObj.orderStatus) {
    case 1:
      return "Accept";
    case 2:
      return "Process";
    case 3:
      return "Deliver";
    case 4:
      return "Delivered";
    case 5:
      return ""; // Đây là trạng thái cuối cùng, không có trạng thái tiếp theo
    case 6:
      return ""; // Đơn hàng đã bị hủy, không có trạng thái tiếp theo
    default:
      return "";
  }
}
