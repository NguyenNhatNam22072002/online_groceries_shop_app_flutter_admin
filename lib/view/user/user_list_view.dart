import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/user_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/user_management_view_model.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final userMVM = Get.put(UserManagementViewModel());

  @override
  void initState() {
    super.initState();
    userMVM.fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "New Users",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() {
        if (userMVM.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: userMVM.userList.length,
            itemBuilder: (context, index) {
              final user = userMVM.userList[index];

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border cho từng phần tử
                  borderRadius: BorderRadius.circular(10), // Bo góc
                ),
                margin: EdgeInsets.all(5), // Khoảng cách giữa các phần tử
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    radius: 40, // Phóng to avatar
                    child: Image.asset(
                      "assets/img/u1.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(user.username.toString() ?? 'Unknown User', style: TextStyle(fontSize: 18)), // Tăng kích thước chữ
                      SizedBox(width: 10), // Khoảng cách giữa tên và biểu tượng sao
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
                    icon: Icon(Icons.delete, color: Colors.red), // Icon thùng rác màu đỏ
                    onPressed: () {
                      // Xử lý khi người dùng nhấn vào button thùng rác
                      // Ví dụ: Gọi hàm xóa người dùng tại đây
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
