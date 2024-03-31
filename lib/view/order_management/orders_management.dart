import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/order_management_model.dart';
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
      length: 2,
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
            labelColor: Colors.black, // Đổi màu của văn bản trên các tab thành màu đen
            tabs: [
              Tab(text: 'Pending'), // Tab cho đơn hàng chưa hoàn thành
              Tab(text: 'Completed'), // Tab cho đơn hàng đã hoàn thành
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderList(type: OrderListType.pending), // Tab danh sách đơn hàng chưa hoàn thành
            OrderList(type: OrderListType.completed), // Tab danh sách đơn hàng đã hoàn thành
          ],
        ),
      ),
    );
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

  @override
  void initState() {
    super.initState();
    if (widget.type == OrderListType.completed) {
      orderVM.getCompletedOrderData();
    } else {
      orderVM.getNewOrderData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        List<OrderModel> orders = [];
        if (widget.type == OrderListType.completed) {
          orders = orderVM.completedorderList;
        } else {
          orders = orderVM.neworderList;
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
            return OrderRow(mObj: mObj, onTap: () {});
          },
          itemCount: orders.length,
        );
      },
    );
  }
}

enum OrderListType { completed, pending }
