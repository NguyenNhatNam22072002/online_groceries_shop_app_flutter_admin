import 'package:flutter/material.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/notification_review_model.dart';

class NotificationRow extends StatelessWidget {
  final NotificationReviewModel nObj;
  final VoidCallback onTap;
  const NotificationRow({Key? key, required this.nObj, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "New Notifications - ID Product: ${nObj.productId}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                          maxLines: 2, // Giới hạn số dòng hiển thị
                          overflow: TextOverflow
                              .ellipsis, // Xử lý trường hợp vượt quá kích thước
                        ),
                      ),
                      Text(
                        nObj.createdAt ?? "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    nObj.message ?? "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
