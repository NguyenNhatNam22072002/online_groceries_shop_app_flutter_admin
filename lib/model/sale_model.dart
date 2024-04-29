class SalesManagementModel {
  final String monthYear;
  final double totalRevenue;
  final int totalOrder;

  SalesManagementModel({
    required this.monthYear,
    required this.totalRevenue,
    required this.totalOrder,
  });

  factory SalesManagementModel.fromJson(Map<String, dynamic> json) {
    return SalesManagementModel(
      monthYear: json['month_year'] ?? '',
      totalRevenue: json['total_revenue'] != null
          ? double.parse(json['total_revenue'].toString())
          : 0.0,
      totalOrder: json['total_order'] != null
          ? int.parse(json['total_order'].toString())
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['month_year'] = monthYear;
    data['total_revenue'] = totalRevenue;
    data['total_order'] = totalOrder;
    return data;
  }
}
