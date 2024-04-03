import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/product_cell.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/section_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/product_management_view_model.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _unitNameController = TextEditingController();
  TextEditingController _unitValueController = TextEditingController();
  TextEditingController _nutritionWeightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  final ScrollController _bestSellingListScrollController = ScrollController();

  final prodVM = Get.put(ProductManagementViewModel());


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
            icon: Image.asset(
              "assets/img/back.png",
              width: 20,
              height: 20,
            )),
        centerTitle: true,
        title: Text(
          "Product Management",
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _detailController,
              decoration: InputDecoration(labelText: 'Product Detail'),
              maxLines: null, // Allow multiple lines
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _unitNameController,
              decoration: InputDecoration(labelText: 'Unit Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _unitValueController,
              decoration: InputDecoration(labelText: 'Unit Value'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nutritionWeightController,
              decoration: InputDecoration(labelText: 'Nutrition Weight'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number, // Allow numeric input
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Code to handle adding the product to the database
                // You can access the entered values using the controllers
              },
              child: Text('Add Product'),
            ),
            SectionView(
              title: "Best Selling",
              padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              onPressed: () {},
            ),
            SizedBox(
              height: 230,
              child: Obx(
                    () =>
                    ListView.builder(
                        controller: _bestSellingListScrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: prodVM.bestSellingArr.length,
                        itemBuilder: (context, index) {
                          var pObj = prodVM.bestSellingArr[index];

                          return ProductCell(
                            pObj: pObj,
                            onPressed: () async {
                              // await Get.to(() =>
                              //     ProductDetails(
                              //       pObj: pObj,
                              //     ));
                              //
                              // homeVM.serviceCallHomeExlusiveOffer();
                              // homeVM.serviceCallHomeBestSelling();
                              // homeVM.serviceCallHomeGroceries();
                              // homeVM.serviceCallHomeAllProducts();
                            },
                          );
                        }),),
            ),
          ],
        ),
      ),
    );
  }
}
