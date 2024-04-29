import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/notification/notification_row.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/notification_review_view_model.dart';

import '../../common/color_extension.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  final notiVM = Get.put(NotificationReviewViewModel());

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<NotificationReviewViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            TextButton(
              onPressed: () {
                notiVM.fetchSalesData();
              },
              child: Text(
                "Read All",
                style: TextStyle(
                    color: TColor.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            )
          ]),
      backgroundColor: Colors.white,
      body: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemBuilder: (context, index) {
              var nObj = notiVM.notificationList[index];
              return NotificationRow(
                nObj: nObj,
                onTap: () {},
              );
            },
            itemCount: notiVM.notificationList.length),
      ),
    );
  }
}
