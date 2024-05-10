import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/globs.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/service_call.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/image_picker_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/line_dropdown_button.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/popup_layout.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/round_button.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/product_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/product_management_view_model.dart';

class AddProductScreen extends StatefulWidget {
  final ProductDetailModel? pObj;

  const AddProductScreen({Key? key, this.pObj}) : super(key: key);
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController txtCatName = TextEditingController();
  TextEditingController txtProName = TextEditingController();
  TextEditingController txtDetail = TextEditingController();
  TextEditingController txtUnitName = TextEditingController();
  TextEditingController txtUnitValue = TextEditingController();
  TextEditingController txtNutritionWeight = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  File? selectImage;
  List categoryArr = [];

  Map? selectCateObj;
  bool isSelected = false;
  int otherFlag = 0;
  final ProductManagementViewModel prodVM =
      Get.put(ProductManagementViewModel());

  @override
  void initState() {
    super.initState();
    getCategoryList();
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
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add Product",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              LineDropDownButton(
                title: "Category",
                hintText: "Select Category",
                itemsArr: categoryArr,
                selectVal: selectCateObj,
                didChanged: (cObj) {
                  selectCateObj = cObj;
                  if (cObj["category_id"] == 0) {
                    otherFlag = 1;
                  } else {
                    //getCategoryList();
                  }
                  setState(() {});
                },
                displayKey: "category_name",
              ),
              const SizedBox(
                height: 8,
              ),
              if ((selectCateObj?["category_id"] as int? ?? -1) == 0)
                LineTextField(
                  title: "Enter Category",
                  placeholder: "Enter category name",
                  controller: txtCatName,
                ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Product Name',
                placeholder: 'Enter Product Name',
                controller: txtProName,
              ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Product Detail',
                placeholder: 'Enter Product Detail',
                controller: txtDetail,
              ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Unit Name',
                placeholder: 'Enter Unit Name',
                controller: txtUnitName,
              ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Unit Value',
                placeholder: 'Enter Unit Value',
                controller: txtUnitValue,
              ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Nutrition Weight',
                placeholder: 'Enter Nutrition Weight',
                controller: txtNutritionWeight,
              ),
              SizedBox(height: 16.0),
              LineTextField(
                title: 'Price',
                placeholder: 'Enter Price',
                controller: txtPrice,
                keyboardType: TextInputType.number, // Allow numeric input
              ),
              SizedBox(height: 24.0),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PopupLayout(
                      child: ImagePickerView(
                        didSelect: (imagePath) {
                          setState(() {
                            selectImage = File(imagePath);
                            isSelected = true;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: isSelected
                        ? Image.file(
                            selectImage!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.directions_car,
                            size: 150,
                            color: TColor.secondaryText,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              RoundButton(
                onPressed: submitProductAction,
                title: "Create Product",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCategoryList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svGetCategoryList, isToken: true,
        withSuccess: (resObj) async {
      Globs.hideHUD();
      if ((resObj[KKey.status] as String? ?? "") == "1") {
        categoryArr = resObj[KKey.payload] as List? ?? [];
        setState(() {});
      } else {
        // Handle API error
        categoryArr = [];
      }
      setState(() {});
    }, failure: (err) async {
      mdShowAlert("Error", err, () {});
      // Show error message
    });
  }

  void submitProductAction() {
    if (selectCateObj == null) {
      mdShowAlert("Error", "Please select the category", () {});
      return;
    }

    if (otherFlag == 1 && txtCatName.text.isEmpty) {
      mdShowAlert("Error", "Please enter the category name", () {});
      return;
    }

    if (txtProName.text.isEmpty) {
      mdShowAlert("Error", "Please enter the product name", () {});
      return;
    }

    if (txtDetail.text.isEmpty) {
      mdShowAlert("Error", "Please enter the product detail", () {});
      return;
    }

    if (txtUnitName.text.isEmpty) {
      mdShowAlert("Error", "Please enter the unit name", () {});
      return;
    }

    if (txtUnitValue.text.isEmpty) {
      mdShowAlert("Error", "Please enter the unit value", () {});
      return;
    }

    if (txtNutritionWeight.text.isEmpty) {
      mdShowAlert("Error", "Please enter the nutrition weight", () {});
      return;
    }

    if (txtPrice.text.isEmpty) {
      mdShowAlert("Error", "Please enter the price", () {});
      return;
    }
    if (selectImage == null) {
      mdShowAlert("Error", "Please select your product image", () {});
      return;
    }

    endEditing();

    submitProductApi({
      "cat_id": otherFlag == 1
          ? txtCatName.text
          : selectCateObj!["cat_id"].toString(),
      "brand_id": "2",
      "type_id": "1",
      "name": txtProName.text,
      "detail": txtDetail.text,
      "unit_name": txtUnitName.text,
      "unit_value": txtUnitValue.text,
      "nutrition_weight": txtNutritionWeight.text,
      "price": txtPrice.text,
      "nutrition_date":
          '[{"name":"Calories","value":"100"},{"name":"Protein","value":"10g"}]',
    });
  }

  void submitProductApi(Map<String, String> parameter) {
    Globs.showHUD();
    ServiceCall.multipart(parameter, SVKey.svCreateProduct,
        isTokenApi: true,
        imgObj: {"image": selectImage!}, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if ((responseObj[KKey.status] ?? "") == "1") {
        mdShowAlert("Success", responseObj[KKey.message] ?? MSG.success, () {
          Navigator.pop(context);
        });
      } else {
        mdShowAlert("Error", responseObj[KKey.message] ?? MSG.fail, () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert("Error", err, () {});
    });
  }
}

// END: abpxx6d04wxr
