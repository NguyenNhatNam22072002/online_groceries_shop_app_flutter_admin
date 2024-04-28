class BrandDetailModel {
  int? brandId;
  String? brandName;
  int status;
  DateTime createdDate;
  DateTime modifyDate;

  BrandDetailModel({
    this.brandId,
    this.brandName,
    required this.status,
    required this.createdDate,
    required this.modifyDate,
  });

  BrandDetailModel.fromJson(Map<String, dynamic> json)
      : brandId = json['brand_id'] as int?,
        brandName = json['brand_name'] as String?,
        status = json['status'] ?? 1,
        createdDate = json['created_date'] != null
            ? DateTime.parse(json['created_date'])
            : DateTime.now(),
        modifyDate = json['modify_date'] != null
            ? DateTime.parse(json['modify_date'])
            : DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'brand_id': brandId,
      'brand_name': brandName,
      'status': status,
      'created_date': createdDate.toIso8601String(),
      'modify_date': modifyDate.toIso8601String(),
    };
  }
}
