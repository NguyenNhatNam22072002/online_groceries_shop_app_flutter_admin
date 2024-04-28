import 'dart:ui';
import '../common/color_extension.dart';

class CategoryDetailModel {
  int? catId;
  String? catName;
  String? image;
  Color? color;
  int status;
  DateTime createdDate;
  DateTime modifyDate;

  CategoryDetailModel({
    this.catId,
    this.catName,
    this.image,
    this.color,
    required this.status,
    required this.createdDate,
    required this.modifyDate,
  });

  CategoryDetailModel.fromJson(Map<String, dynamic> json)
      : catId = json['cat_id'] as int?,
        catName = json['cat_name'] as String?,
        image = json['image'] as String?,
        color = json['color'] != null
            ? HexColor.fromHex(json['color'].toString())
            : null,
        status = json['status'] ?? 0,
        createdDate = json['created_date'] != null
            ? DateTime.parse(json['created_date'])
            : DateTime.now(),
        modifyDate = json['modify_date'] != null
            ? DateTime.parse(json['modify_date'])
            : DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'cat_name': catName,
      'image': image,
      'color': color?.toHex(),
      'status': status,
      'created_date': createdDate.toIso8601String(),
      'modify_date': modifyDate.toIso8601String(),
    };
  }
}
