import 'package:flutter/material.dart';

class SalesManagementModel {
  final String monthYear;
  final double totalRevenue;

  SalesManagementModel({
    required this.monthYear,
    required this.totalRevenue,
  });

  factory SalesManagementModel.fromJson(Map<String, dynamic> json) {
    return SalesManagementModel(
      monthYear: json['month_year'] ?? '',
      totalRevenue: json['total_revenue'] != null ? double.parse(json['total_revenue'].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['month_year'] = monthYear;
    data['total_revenue'] = totalRevenue;
    return data;
  }
}
