import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_shop_app_flutter_admin/common_widget/round_button.dart';
import 'package:online_groceries_shop_app_flutter_admin/model/brand_detail_model.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/brand_detail_view_model.dart';

class UpdateBrandView extends StatefulWidget {
  final BrandDetailModel bObj;
  const UpdateBrandView({Key? key, required this.bObj}) : super(key: key);

  @override
  _UpdateBrandViewState createState() => _UpdateBrandViewState();
}

class _UpdateBrandViewState extends State<UpdateBrandView> {
  final BrandDetailViewModel _viewModel = Get.put(BrandDetailViewModel());

  @override
  void initState() {
    super.initState();
    _viewModel.setDataModel(widget.bObj);
  }

  @override
  void dispose() {
    Get.delete<_UpdateBrandViewState>();
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
          "Update Brand",
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
                title: "Brand Name",
                placeholder: "Enter brand name",
                controller: _viewModel.txtBrandName.value,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              RoundButton(
                title: "Update Brand",
                onPressed: () {
                  _viewModel.updateBrandDetail(
                    widget.bObj.brandId!,
                    () => Navigator.pop(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
