import 'package:flutter/material.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/orders_management.dart';

class AdminSummaryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      // Thêm border cho bảng
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Màu và độ dày của khung
      ),
      columns: [
        DataColumn(
          label: Text(
            'Total Revenues',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16), // Phóng to font chữ và in đậm
          ),
        ),
        DataColumn(
          label: Text(
            'Total Orders',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16), // Phóng to font chữ và in đậm
          ),
        ),
      ],
      rows: [
        DataRow(
          color: MaterialStateProperty.all<Color>(
              Colors.red), // Tô màu nền xanh cho hàng
          cells: [
            DataCell(
              Text(
                '\$100',
                style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        16), // Đổi màu chữ thành trắng và phóng to font chữ
              ),
            ),
            DataCell(
              Stack(
                alignment: Alignment.center, // Đặt căn giữa cho Stack
                children: [
                  Positioned(
                    left: 0,
                    child: Text(
                      '11',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              16), // Đổi màu chữ thành trắng và phóng to font chữ
                    ),
                  ),
                  Positioned(
                    // Đặt vị trí của nút ở góc phải trên của cell
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderListView()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Màu nền của nút
                          shape:
                              BoxShape.circle, // Định dạng nút thành hình tròn
                        ),
                        padding: EdgeInsets.all(
                            5), // Khoảng cách từ biên đến nội dung bên trong nút
                        child: Icon(
                          Icons.arrow_forward_ios, // Icon của nút
                          color: Colors.red, // Màu của icon
                          size: 10, // Kích thước của icon
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
