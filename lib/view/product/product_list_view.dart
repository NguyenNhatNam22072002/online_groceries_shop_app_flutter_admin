import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/product_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/product/product_add_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/product/product_edit_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/product/review/review_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/product_management_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final productManagementVM = Get.put(ProductManagementViewModel());
  bool _isSkeletonVisible = false;

  @override
  void initState() {
    super.initState();
    productManagementVM.fetchProductDetails();
  }

  Future<void> _handleRefresh() async {
    // Show skeleton loader for 2 seconds before displaying data
    setState(() {
      _isSkeletonVisible = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isSkeletonVisible = false;
    });
    productManagementVM.fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Product",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddProductScreen());
            },
            icon: Icon(
              Icons.add,
              color: TColor.primaryText,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Obx(() {
          if (productManagementVM.isLoading.isTrue || _isSkeletonVisible) {
            return _buildSkeletonLoader();
          } else {
            return ListView.builder(
              itemCount: productManagementVM.productDetails.length,
              itemBuilder: (context, index) {
                final productDetail = productManagementVM.productDetails[index];
                return _buildProductItem(productDetail);
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: productManagementVM.productDetails.length,
        itemBuilder: (context, index) {
          final productDetail = productManagementVM.productDetails[index];
          return _buildProductItem(productDetail);
        },
      ),
    );
  }

  Widget _buildProductItem(ProductDetailModel productDetail) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: GestureDetector(
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReviewListView(
              prodId: productDetail.prodId.toString(),
            ),
          ));
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(4),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: productDetail.image ?? '',
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 16), // Add some spacing between image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetail.name ?? 'Unknown Product',
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            // Add some spacing between text and buttons
                            Text(
                              'Quantity: ${productDetail.unitValue.toString() ?? 'N/A'}',
                            ),
                            Text(
                              'Price: \$${productDetail.price ?? 0}',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                // Navigate to the update product view and pass the product object
                                Get.to(UpdateProductScreen(pObj: productDetail));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                // Implement delete function if needed
                                productManagementVM.deleteProduct(productDetail.prodId!);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
