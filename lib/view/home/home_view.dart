import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/sale_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/home/sales_summary_table.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/order_management/orders_management.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/sales_management_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final salesVM = Get.find<SalesManagementViewModel>();
  final salesVM = Get.put(SalesManagementViewModel());

  @override
  void initState() {
    super.initState();
    salesVM.fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151734),
      body: Obx(() {
        if (salesVM.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (salesVM.salesList.isEmpty) {
          return Center(child: Text('No sales data available'));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/color_logo.png",
                      width: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/location.png",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Hi, Admin",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // Bảng tổng doanh thu và tổng đơn hàng của admin
                Obx(() {
                  return DataTable(
                    // Thêm border cho bảng
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black), // Màu và độ dày của khung
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          'Total Revenues',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(
                                0xFF6ED7FF), // Phóng to font chữ và in đậm
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Total Orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(
                                0xFF6ED7FF), // Phóng to font chữ và in đậm
                          ),
                        ),
                      )
                    ],
                    rows: [
                      DataRow(
                        color:
                            MaterialStateProperty.all<Color>(Color(0xFF2F334F)),
                        // Tô màu nền xanh cho hàng
                        cells: [
                          DataCell(
                            Text(
                              '\$${salesVM.totalPrice.value.toStringAsFixed(2)}',
                              // Hiển thị tổng doanh thu
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DataCell(
                            Stack(
                              alignment: Alignment.center,
                              // Đặt căn giữa cho Stack
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Text(
                                    '${salesVM.totalOrders.value}',
                                    // Hiển thị tổng số đơn hàng
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
                                        shape: BoxShape
                                            .circle, // Định dạng nút thành hình tròn
                                      ),
                                      padding: EdgeInsets.all(5),
                                      // Khoảng cách từ biên đến nội dung bên trong nút
                                      child: Icon(
                                        Icons.arrow_forward_ios, // Icon của nút
                                        color: Color(0xFF151734),
                                        // Màu của icon
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
                }),
                const SizedBox(height: 20),
                // Tiêu đề cho biểu đồ
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Sales Chart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // Biểu đồ sử dụng CustomPaint
                // Container bọc biểu đồ
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2F334F), // Màu nhạt
                        Color(0xFF151734), // Màu đậm
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFF8B93E0), width: 2),
                  ),
                  padding: EdgeInsets.all(10),
                  // Đặt khoảng cách giữa biểu đồ và viền container
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: CustomPaint(
                      size: Size(double.infinity, 250),
                      painter: BarChartPainter(data: salesVM.salesList),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tiêu đề cho bảng Sales Table
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Sales Table',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Bảng Sales Table
                SalesTable(salesData: salesVM.salesList),
                const SizedBox(height: 25),
              ],
            ),
          );
        }
      }),
    );
  }
}

class SalesTable extends StatelessWidget {
  final List<SalesManagementModel> salesData;

  const SalesTable({required this.salesData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2F334F), // Màu nhạt
            Color(0xFF151734), // Màu đậm
          ],
        ),
        border: Border.all(color: Color(0xFF8B93E0), width: 2),
      ),
      child: DataTable(
        dataRowHeight: 40,
        // Đặt chiều cao của mỗi hàng
        columns: [
          DataColumn(
            label: Text(
              'Month/Year',
              style: TextStyle(color: Color(0xFF6ED7FF)),
            ),
          ),
          DataColumn(
            label: Text(
              'Revenue',
              style: TextStyle(color: Color(0xFF6ED7FF)),
            ),
          ),
        ],
        rows: salesData.map((data) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  data.monthYear,
                  style: TextStyle(color: Color(0xFF6ED7FF)),
                ),
              ),
              DataCell(
                Text(
                  data.totalRevenue.toString() + "\$",
                  style: TextStyle(color: Color(0xFF6ED7FF)),
                ),
              ),
            ],
          );
        }).toList(),
        dividerThickness: 2,
        dataRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xFF212542)),
        dataTextStyle: TextStyle(fontSize: 14),
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xFF151734)),
        headingTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<SalesManagementModel> data;

  BarChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data == null || data.isEmpty) {
      return; // Không vẽ gì nếu dữ liệu là null hoặc rỗng
    }

    final double barWidth = size.width / (data.length * 3);
    int maxOrder = 0;
    for (var i = 0; i < data.length; i++) {
      final int order = data[i].totalOrder ?? 0;
      maxOrder = max(maxOrder, order);
    }
    final double barHeightUnit = size.height / (maxOrder * 1.2);

    final Paint paint = Paint()..color = Color(0xFF6ED7FF);

    // Vẽ các cột dữ liệu và ghi giá trị "Revenue"
    for (int i = 0; i < data.length; i++) {
      final int order = data[i].totalOrder ?? 0;

      final double x = (i * 3 + 1) * barWidth;
      final double y = size.height - order * barHeightUnit;

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, y, barWidth, order * barHeightUnit),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        paint,
      );

      // Ghi giá trị "total" ở đầu mỗi cột
      TextSpan orderValueSpan = TextSpan(
        text: '${data[i].totalOrder}', // Sử dụng ký tự tắt của tháng
        style: TextStyle(
            color: Color(0xFF6ED7FF),
            fontSize: 10,
            fontWeight: FontWeight.bold),
      );
      TextPainter orderValuePainter = TextPainter(
        text: orderValueSpan,
        textDirection: TextDirection.ltr,
      );
      orderValuePainter.layout();
      final double orderValueX = x + barWidth / 2 - orderValuePainter.width / 2;
      final double orderValueY = y - 15;
      orderValuePainter.paint(canvas, Offset(orderValueX, orderValueY));

      // Ghi giá trị thời gian ở dưới chân mỗi cột
      // Chuyển đổi số tháng thành ký tự tương ứng
      String monthAbbreviation = getMonthAbbreviation(data[i].monthYear);

      // Ghi giá trị "Revenue" ở đầu mỗi cột
      TextSpan timeSpan = TextSpan(
        text: '$monthAbbreviation', // Sử dụng ký tự tắt của tháng
        style: TextStyle(
            color: Color(0xFF6ED7FF),
            fontSize: 10,
            fontWeight: FontWeight.bold),
      );

      TextPainter timePainter = TextPainter(
        text: timeSpan,
        textDirection: TextDirection.ltr,
      );

      timePainter.layout();
      final double timeX = x + barWidth / 2 - timePainter.width / 2;
      final double timeY = size.height + 5;
      timePainter.paint(canvas, Offset(timeX, timeY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // Hàm chuyển đổi số tháng thành ký tự tắt tương ứng
  String getMonthAbbreviation(String monthYear) {
    Map<String, String> monthAbbreviations = {
      '01': 'Jan',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Apr',
      '05': 'May',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Aug',
      '09': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec',
    };

    String month = monthYear.split('-')[0]; // Lấy số tháng từ chuỗi 'monthYear'
    return monthAbbreviations[month] ?? '';
  }
}
