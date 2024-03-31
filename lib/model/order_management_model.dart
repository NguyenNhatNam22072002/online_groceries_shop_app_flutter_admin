class OrderModel {
  final String orderId;
  final String userId;
  final String cartId;
  final double totalPrice;
  final double userPayPrice;
  final double discountPrice;
  final double deliverPrice;
  final int deliverType;
  final int paymentType;
  final int paymentStatus;
  final int orderStatus;
  final int status;
  final DateTime createdDate;
  final List<String> productNames;
  final List<String> productImages;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.cartId,
    required this.totalPrice,
    required this.userPayPrice,
    required this.discountPrice,
    required this.deliverPrice,
    required this.deliverType,
    required this.paymentType,
    required this.paymentStatus,
    required this.orderStatus,
    required this.status,
    required this.createdDate,
    required this.productNames,
    required this.productImages,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'].toString(),
      userId: json['user_id'].toString(),
      cartId: json['cart_id'].toString(),
      totalPrice: double.tryParse("${json['total_price']}") ?? 0.0,
      userPayPrice: double.tryParse("${json['user_pay_price']}") ?? 0.0,
      discountPrice: double.tryParse("${json['discount_price']}") ?? 0.0,
      deliverPrice: double.tryParse("${json['deliver_price']}") ?? 0.0,
      deliverType: json['deliver_type'] ?? 0,
      paymentType: json['payment_type'] ?? 0,
      paymentStatus: json['payment_status'] ?? 0,
      orderStatus: json['order_status'] ?? 0,
      status: json['status'] ?? 0,
      createdDate: DateTime.parse(json['created_date'] ?? ""),
      productNames: (json['names'] as String? ?? "").split(','),
      productImages: (json['images'] as String? ?? "").split(','),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'cart_id': cartId,
      'total_price': totalPrice,
      'user_pay_price': userPayPrice,
      'discount_price': discountPrice,
      'deliver_price': deliverPrice,
      'deliver_type': deliverType,
      'payment_type': paymentType,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'status': status,
      'created_date': createdDate.toIso8601String(),
      'names': productNames.join(','),
      'images': productImages.join(','),
    };
  }
}
