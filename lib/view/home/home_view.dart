import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/sale_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/home/sales_summary_table.dart';
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
                const SizedBox(height: 10),
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
                          color: TColor.darkGray,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // Bảng tổng doanh thu và tổng đơn hàng của admin
                AdminSummaryTable(),
                const SizedBox(height: 20),
                // Tiêu đề cho bảng Sales Table
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Sales Table',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Bảng Sales Table
                SalesTable(salesData: salesVM.salesList),
                const SizedBox(height: 20),
                // Tiêu đề cho biểu đồ
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Sales Chart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Biểu đồ sử dụng CustomPaint
                CustomPaint(
                  size: Size(double.infinity, 300),
                  painter: BarChartPainter(data: salesVM.salesList),
                ),
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
    return DataTable(
      columns: [
        DataColumn(label: Text('Month/Year')),
        DataColumn(label: Text('Revenue')),
      ],
      rows: salesData.map((data) {
        return DataRow(
          cells: [
            DataCell(Text(data.monthYear)),
            DataCell(Text(data.totalRevenue.toString())),
          ],
        );
      }).toList(),
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

    final double barWidth = size.width / (data.length * 2 + 1);
    double maxRevenue = 0;
    for (var i = 0; i < data.length; i++) {
      final double revenue = data[i].totalRevenue ?? 0; // Sử dụng ?? để xử lý trường hợp null
      maxRevenue = max(maxRevenue, revenue);
    }
    final double barHeightUnit = size.height / maxRevenue;

    final Paint paint = Paint()..color = Colors.blue;

    // Vẽ mũi tên ngang
    final double arrowLength = 10;
    final double arrowHeadWidth = 5;
    final double arrowHeadHeight = 3;
    final double arrowXStart = 0;
    final double arrowXEnd = size.width;
    final double arrowY = size.height;
    canvas.drawLine(Offset(arrowXStart, arrowY), Offset(arrowXEnd, arrowY), paint);
    canvas.drawLine(
      Offset(arrowXEnd - arrowHeadWidth, arrowY - arrowHeadHeight),
      Offset(arrowXEnd, arrowY),
      paint,
    );
    canvas.drawLine(
      Offset(arrowXEnd - arrowHeadWidth, arrowY + arrowHeadHeight),
      Offset(arrowXEnd, arrowY),
      paint,
    );

    // Vẽ mũi tên dọc
    final double arrowHeadMargin = 5;
    final double arrowYStart = 0;
    final double arrowYEnd = size.height;
    final double arrowX = 2; // Đặt mũi tên dọc ở bên trái
    canvas.drawLine(Offset(arrowX, arrowYStart), Offset(arrowX, arrowYEnd), paint);
    canvas.drawLine(
      Offset(arrowX + arrowHeadHeight, arrowHeadMargin),
      Offset(arrowX, 0),
      paint,
    );
    canvas.drawLine(
      Offset(arrowX - arrowHeadHeight, arrowHeadMargin),
      Offset(arrowX, 0),
      paint,
    );

    // Ghi chữ "Revenue" ở cao nhất của mũi tên dọc
    TextSpan revenueSpan = TextSpan(
      text: 'Revenue',
      style: TextStyle(color: Colors.black, fontSize: 10),
    );
    TextPainter revenuePainter = TextPainter(
      text: revenueSpan,
      textDirection: TextDirection.ltr,
    );
    revenuePainter.layout();
    final double revenueX = arrowX + arrowHeadHeight + 5; // Đặt vị trí x cho văn bản "Revenue"
    final double revenueY = 0; // Đặt vị trí y cho văn bản "Revenue" ở cao nhất của mũi tên dọc
    revenuePainter.paint(canvas, Offset(revenueX, revenueY));

    // Ghi chữ "Time" ở cuối mũi tên ngang
    TextSpan timeSpan = TextSpan(
      text: 'Time',
      style: TextStyle(color: Colors.black, fontSize: 10),
    );
    TextPainter timePainter = TextPainter(
      text: timeSpan,
      textDirection: TextDirection.ltr,
    );
    timePainter.layout();
    final double timeX = arrowXEnd - timePainter.width; // Đặt vị trí x cho văn bản "Time" ở cuối mũi tên ngang
    final double timeY = size.height + 5; // Đặt vị trí y cho văn bản "Time" dưới chân cột
    timePainter.paint(canvas, Offset(timeX, timeY));

    // Vẽ các cột dữ liệu và ghi giá trị "Revenue"
    for (int i = 0; i < data.length; i++) {
      final double revenue = data[i].totalRevenue ?? 0; // Sử dụng ?? để xử lý trường hợp null

      final double x = (i * 2 + 1) * barWidth;
      final double y = size.height - revenue * barHeightUnit;

      canvas.drawRect(
        Rect.fromLTWH(x, y, barWidth, revenue * barHeightUnit),
        paint,
      );

      // Ghi giá trị "Revenue" ở đầu mỗi cột
      TextSpan revenueValueSpan = TextSpan(
        text: '${data[i].totalRevenue}', // Sử dụng giá trị revenue của SalesManagementModel
        style: TextStyle(color: Colors.black, fontSize: 10),
      );
      TextPainter revenueValuePainter = TextPainter(
        text: revenueValueSpan,
        textDirection: TextDirection.ltr,
      );
      revenueValuePainter.layout();
      final double revenueValueX = x + barWidth / 2 - revenueValuePainter.width / 2; // Đặt vị trí x cho văn bản giá trị revenue
      final double revenueValueY = y - 15; // Đặt vị trí y cho văn bản giá trị revenue ở trên đỉnh cột
      revenueValuePainter.paint(canvas, Offset(revenueValueX, revenueValueY));

      // Ghi giá trị thời gian ở dưới chân mỗi cột
      TextSpan timeSpan = TextSpan(
        text: data[i].monthYear, // Giả sử thời gian là thuộc tính "monthYear" của đối tượng SalesManagementModel
        style: TextStyle(color: Colors.black, fontSize: 10),
      );
      TextPainter timePainter = TextPainter(
        text: timeSpan,
        textDirection: TextDirection.ltr,
      );
      timePainter.layout();
      final double timeX = x + barWidth / 2 - timePainter.width / 2; // Đặt vị trí x cho văn bản thời gian
      final double timeY = size.height + 5; // Đặt vị trí y cho văn bản thời gian dưới chân cột
      timePainter.paint(canvas, Offset(timeX, timeY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
