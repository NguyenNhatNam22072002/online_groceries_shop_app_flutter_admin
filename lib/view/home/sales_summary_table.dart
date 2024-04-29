import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/sale_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/orders_management.dart';

class AdminSummaryTable extends StatelessWidget {
  final RxInt totalOrders;
  final RxDouble totalPrice;

  AdminSummaryTable({required this.totalOrders, required this.totalPrice});

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
              fontSize: 16,
              color: Color(0xFF6ED7FF), // Phóng to font chữ và in đậm
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Total Orders',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF6ED7FF), // Phóng to font chữ và in đậm
            ),
          ),
        )
      ],
      rows: [
        DataRow(
          color: MaterialStateProperty.all<Color>(Color(0xFF2F334F)),
          // Tô màu nền xanh cho hàng
          cells: [
            DataCell(
              Text(
                '\$${totalPrice.value}', // Hiển thị tổng doanh thu
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            DataCell(
              Stack(
                alignment: Alignment.center, // Đặt căn giữa cho Stack
                children: [
                  Positioned(
                    left: 0,
                    child: Text(
                      '${totalOrders.value}', // Hiển thị tổng số đơn hàng
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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
                            builder: (context) => OrderListView(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Màu nền của nút
                          shape:
                              BoxShape.circle, // Định dạng nút thành hình tròn
                        ),
                        padding: EdgeInsets.all(5),
                        // Khoảng cách từ biên đến nội dung bên trong nút
                        child: Icon(
                          Icons.arrow_forward_ios, // Icon của nút
                          color: Color(0xFF151734), // Màu của icon
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
