import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_shop_app_flutter_admin/common/color_extension.dart';
import 'package:online_groceries_shop_app_flutter_admin/view_model/type_view_model.dart';
//import 'add_type_view.dart'; // Import the view where you want to navigate

class TypeView extends StatefulWidget {
  const TypeView({Key? key}) : super(key: key);

  @override
  _TypeViewState createState() => _TypeViewState();
}

class _TypeViewState extends State<TypeView> {
  final typeVM = Get.put(TypeViewModel());

  @override
  void initState() {
    super.initState();
    typeVM.fetchTypes();
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
          "Types",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to add type view
              // Get.to(AddTypeView());
            },
            icon: Icon(
              Icons.add,
              color: TColor.primaryText,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (typeVM.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: typeVM.types.length,
            itemBuilder: (context, index) {
              final type = typeVM.types[index];

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
                  color: type.color ?? Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(type.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      type.typeName ?? 'Unknown Type',
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
                            // Implement edit function if needed
                            typeVM.setDataModel(type);
                            // Navigate to edit type view
                            //Get.to(EditTypeView());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Implement delete function if needed
                            typeVM.deleteType(type.typeId!);
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
