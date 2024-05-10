import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/user_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/user_management_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final userMVM = Get.put(UserManagementViewModel());
  bool _isSkeletonVisible = false;

  @override
  void initState() {
    super.initState();
    userMVM.fetchSalesData();
  }

  int generateRandomIndex(int listLength) {
    final Random random = Random();
    return random.nextInt(listLength);
  }

  Future<void> _handleRefresh() async {
    // Show skeleton loader for 2 seconds before displaying data
    setState(() {
      _isSkeletonVisible = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isSkeletonVisible = false;
    });
    userMVM.fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "New Users",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Obx(() {
          if (userMVM.isLoading.isTrue || _isSkeletonVisible) {
            // Show skeleton loader or loading indicator
            return _buildSkeletonLoader();
          } else {
            // Show user list
            return ListView.builder(
              itemCount: userMVM.userList.length,
              itemBuilder: (context, index) {
                final user = userMVM.userList[index];
                return _buildUserListItem(user);
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: userMVM.userList.length,
        itemBuilder: (context, index) {
          final user = userMVM.userList[index];

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(5),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 40,
                child: Image.asset(
                  [
                    'assets/img/u1.png',
                    'assets/img/u2.png',
                  ][generateRandomIndex(2)],
                  width: 80,
                  height: 80,
                ),
              ),
              title: Row(
                children: [
                  Text(user.username.toString() ?? 'Unknown User',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email.toString() ?? ''),
                  Text(
                    'Created at: ${user.createdDate != null ? user.createdDate!.toLocal().toString() : 'N/A'}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle delete user action here
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(UserModel user) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 40,
          child: Image.asset(
            [
              'assets/img/u1.png',
              'assets/img/u2.png',
            ][generateRandomIndex(2)],
            width: 80,
            height: 80,
          ),
        ),
        title: Row(
          children: [
            Text(user.username.toString() ?? 'Unknown User',
                style: TextStyle(fontSize: 18)),
            SizedBox(width: 10),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email.toString() ?? ''),
            Text(
              'Created at: ${user.createdDate != null ? user.createdDate!.toLocal().toString() : 'N/A'}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete user action here
          },
        ),
      ),
    );
  }
}
