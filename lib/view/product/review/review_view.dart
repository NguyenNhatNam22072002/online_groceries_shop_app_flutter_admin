import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/review_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/review_view_model.dart';

class ReviewListView extends StatefulWidget {
  final String prodId;

  ReviewListView({Key? key, required this.prodId}) : super(key: key);

  @override
  _ReviewListViewState createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {
  final reviewVM = Get.put(ReviewViewModel());
  @override
  void initState() {
    super.initState();
    reviewVM.fetchProductReviews(widget.prodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: TColor.primaryText,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Reviews",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() {
        final reviewList = reviewVM.reviewList;
        return reviewList.isEmpty
            ? Center(
                child: Text(
                  'There are no reviews!',
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: reviewList.length,
                itemBuilder: (context, index) {
                  final review = reviewList[index];
                  final int? rating = review.rating;

                  // Tạo danh sách các biểu tượng ngôi sao tương ứng với số sao
                  List<Widget> starIcons = [];
                  if (rating != null) {
                    for (int i = 0; i < rating; i++) {
                      starIcons.add(Icon(Icons.star, color: Colors.amber));
                    }
                  } else {
                    starIcons.add(Text('N/A'));
                  }

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset(
                          "assets/img/u1.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(review.username.toString() ??
                              'Unknown User'), // Hiển thị tên người đánh giá
                          SizedBox(
                              width:
                                  10), // Khoảng cách giữa tên và biểu tượng sao
                          ...starIcons, // In ra các biểu tượng ngôi sao
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.comment ?? ''),
                          Text(
                            'Created at: ${review.createdAt != null ? review.createdAt!.toLocal().toString() : 'N/A'}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
