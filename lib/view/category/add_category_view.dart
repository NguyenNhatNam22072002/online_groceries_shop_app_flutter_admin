import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/image_picker_view.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/popup_layout.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/round_button.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/category_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/category_detail_view_model.dart';

class AddCategoryView extends StatefulWidget {
  final CategoryDetailModel? cObj;

  const AddCategoryView({Key? key, this.cObj}) : super(key: key);

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final CategoryDetailViewModel _viewModel = Get.put(CategoryDetailViewModel());

  bool isSelected = false;
  Color selectedColor = Colors.grey; // Default color

  @override
  void initState() {
    super.initState();
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
          "Add Category",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Color:',
                    style: TextStyle(
                      color: TColor.textTittle,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      // Show ColorPicker and update selectedColor
                      final Color? pickedColor = await showDialog<Color>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: selectedColor,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    selectedColor = color;
                                  });
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(selectedColor);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      if (pickedColor != null) {
                        setState(() {
                          selectedColor = pickedColor;
                          _viewModel.txtColor.value.text =
                              selectedColor.toString();
                        });
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: selectedColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
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
                          setState(() {
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
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: !isSelected
                        ? Icon(Icons.add_box_outlined,
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
                title: "Add Category",
                onPressed: () {
                  _viewModel.createCategoryDetail(() => Navigator.pop(context));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
