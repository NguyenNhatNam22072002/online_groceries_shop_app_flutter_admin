import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/brand/update_brand_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/brand_detail_view_model.dart';
import 'add_brand_view.dart'; // Import the view where you want to navigate

class BrandDetailView extends StatefulWidget {
  const BrandDetailView({Key? key}) : super(key: key);

  @override
  _BrandDetailViewState createState() => _BrandDetailViewState();
}

class _BrandDetailViewState extends State<BrandDetailView> {
  final brandDetailVM = Get.put(BrandDetailViewModel());

  @override
  void initState() {
    super.initState();
    brandDetailVM.fetchBrandDetails();
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
          "Brand",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to add brand view
              Get.to(AddBrandView());
            },
            icon: Icon(
              Icons.add,
              color: TColor.primaryText,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (brandDetailVM.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: brandDetailVM.brandDetails.length,
            itemBuilder: (context, index) {
              final brandDetail = brandDetailVM.brandDetails[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.branding_watermark,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      brandDetail.brandName ?? 'Unknown Brand',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            // Navigate to the update brand view and pass the brand object
                            Get.to(UpdateBrandView(bObj: brandDetail));
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Implement delete function if needed
                            brandDetailVM
                                .deleteBrandDetail(brandDetail.brandId!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
