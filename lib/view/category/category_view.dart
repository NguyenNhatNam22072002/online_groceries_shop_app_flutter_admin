import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/view/category/update_category_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/category_detail_view_model.dart';
import 'add_category_view.dart'; // Import the view where you want to navigate

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({Key? key}) : super(key: key);

  @override
  _CategoryDetailViewState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  final categoryDetailVM = Get.put(CategoryDetailViewModel());

  @override
  void initState() {
    super.initState();
    categoryDetailVM.fetchCategoryDetails();
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
          "Category",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to add category view
              Get.to(AddCategoryView());
            },
            icon: Icon(
              Icons.add,
              color: TColor.primaryText,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (categoryDetailVM.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: categoryDetailVM.categoryDetails.length,
            itemBuilder: (context, index) {
              final categoryDetail = categoryDetailVM.categoryDetails[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: categoryDetail.color ?? Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(categoryDetail.image ?? ''),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text(
                      categoryDetail.catName ?? 'Unknown Category',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateCategoryView(
                                  cObj: categoryDetail,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Implement delete function if needed
                            categoryDetailVM
                                .deleteCategoryDetail(categoryDetail.catId!);
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
