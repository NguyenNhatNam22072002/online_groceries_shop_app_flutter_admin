import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_management_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/order_detail_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/order_row.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/order_view_model.dart';

class OrderListView extends StatefulWidget {
  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Số lượng tab là 6
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/img/back.png",
              width: 20,
              height: 20,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Orders Management",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
            isScrollable: true, // Cho phép cuộn các tab
            labelColor: Colors.black, // Đổi màu của văn bản trên các tab thành màu đen
            tabs: [
              for (var i = 1; i <= 6; i++)
                Tab(
                  text: _getTabText(i), // Lấy văn bản của từng tab
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (var i = 1; i <= 6; i++)
              OrderList(type: getOrderListType(i)), // Tạo OrderList cho từng trạng thái
          ],
        ),
      ),
    );
  }

  String _getTabText(int index) {
    switch (index) {
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

  OrderListType getOrderListType(int index) {
    switch (index) {
      case 1:
        return OrderListType.placed;
      case 2:
        return OrderListType.accepted;
      case 3:
        return OrderListType.processing;
      case 4:
        return OrderListType.delivering;
      case 5:
        return OrderListType.delivered;
      case 6:
        return OrderListType.canceled;
      default:
        return OrderListType.placed;
    }
  }
}

class OrderList extends StatefulWidget {
  final OrderListType type;

  const OrderList({Key? key, required this.type}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final orderVM = Get.put(OrderViewModel());

  // Hàm callback để cập nhật trạng thái
  void _updateOrderStatus(OrderModel mObj) {
    // Cập nhật trạng thái ở đây, ví dụ:
    // orderVM.updateOrderStatus(
    //   orderId: mObj.orderId ?? "",
    //   userId: mObj.userId ?? "",
    //   orderStatus: mObj.orderStatus + 1, // Ví dụ cập nhật lên trạng thái kế tiếp
    // );

  }

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case OrderListType.placed:
        orderVM.getNewOrderData();
        break;
      case OrderListType.accepted:
        orderVM.getAcceptedOrderData();
        break;
      case OrderListType.processing:
        orderVM.getProcessingOrderData();
        break;
      case OrderListType.delivering:
        orderVM.getDeliveringOrderData();
        break;
      case OrderListType.delivered:
        orderVM.getCompletedOrderData();
        break;
      case OrderListType.canceled:
        orderVM.getCanceledOrderData();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<OrderModel> orders = [];
        switch (widget.type) {
          case OrderListType.placed:
            orders = orderVM.neworderList;
            break;
          case OrderListType.accepted:
            orders = orderVM.acceptedOrderList;
            break;
          case OrderListType.processing:
            orders = orderVM.processingOrderList;
            break;
          case OrderListType.delivering:
            orders = orderVM.deliveringOrderList;
            break;
          case OrderListType.delivered:
            orders = orderVM.completedorderList;
            break;
          case OrderListType.canceled:
            orders = orderVM.canceledOrderList;
            break;
        }
        return orders.isEmpty
            ? Center(
                child: Text(
                  "No Any Order Place",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index) {
            var mObj = orders[index];
            return OrderRow(
              mObj: mObj,
              onTap: () {
                Get.to( () => OrdersDetailView(mObj: mObj) );
              },
              orderViewModel: orderVM,
              updateOrderStatusCallback: _updateOrderStatus,
            );
          },
          itemCount: orders.length,
        );
      },
    );
  }
}

enum OrderListType { placed, accepted, processing, delivering, delivered, canceled }
