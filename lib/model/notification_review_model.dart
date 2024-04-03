class NotificationReviewModel {
  int? id;
  int? productId;
  String? message;
  String? createdAt;

  NotificationReviewModel({
    this.id,
    this.productId,
    this.message,
    this.createdAt,
  });

  NotificationReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
