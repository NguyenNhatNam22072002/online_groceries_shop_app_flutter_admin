import 'package:flutter/material.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';

class SettingScreen extends StatelessWidget {
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
              )),
          centerTitle: true,
          title: Text(
            "Setting",
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Xử lý khi người dùng nhấn nút Log out
          },
          child: Text('Log out'),
        ),
      ),
    );
  }
}
