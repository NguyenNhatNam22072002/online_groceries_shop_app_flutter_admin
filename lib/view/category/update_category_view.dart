import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/image_picker_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/popup_layout.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/round_button.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/category_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/category_detail_view_model.dart';

class UpdateCategoryView extends StatefulWidget {
  final CategoryDetailModel? cObj;

  const UpdateCategoryView({Key? key, this.cObj}) : super(key: key);

  @override
  State<UpdateCategoryView> createState() => _UpdateCategoryViewState();
}

class _UpdateCategoryViewState extends State<UpdateCategoryView> {
  final CategoryDetailViewModel _viewModel = Get.put(CategoryDetailViewModel());

  @override
  void initState() {
    super.initState();
    _viewModel.setDataModel(widget.cObj!);
  }

  @override
  void dispose() {
    Get.delete<CategoryDetailViewModel>();
    super.dispose();
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
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Update Category",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              LineTextField(
                title: "Category Name",
                placeholder: "Enter category name",
                controller: _viewModel.txtCatName.value,
              ),
              const SizedBox(height: 15),
              LineTextField(
                title: "Color",
                placeholder: "Enter color",
                controller: _viewModel.txtColor.value,
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PopupLayout(
                      child: ImagePickerView(
                        didSelect: (imagePath) {
                          _viewModel.selectImage = File(imagePath);
                          setState(() {});
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
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: _viewModel.selectImage == null
                        ? widget.cObj?.image != null
                            ? Image.file(
                                File(widget.cObj!.image!),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.add_box_outlined,
                                size: 50, color: Colors.grey[400])
                        : Image.file(
                            _viewModel.selectImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              RoundButton(
                title: "Update Category",
                onPressed: () {
                  _viewModel.updateCategoryDetail(
                      widget.cObj!.catId!, () => Navigator.pop(context));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
