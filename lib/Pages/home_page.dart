import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Pages/login_page.dart';
import 'package:fw_client/Pages/orders_page.dart';
import 'package:fw_client/Pages/product_description_page.dart';
import 'package:fw_client/Widgets/drop_down.dart';
import 'package:fw_client/Widgets/multi_selected_dropdown.dart';
import 'package:fw_client/Widgets/product_cart.dart';
import 'package:fw_client/controller/home_controller.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  var ctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchData();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Footware Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => OrdersPage());
                  },
                  icon: Icon(CupertinoIcons.cart)),
              IconButton(
                  onPressed: () {
                    // signout user here
                    FirebaseAuth.instance.signOut().then((success) {
                      Get.offAll(LoginPage());
                    });
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
          body: Column(
            children: [
              // sizedbox to hold the list hotizontal
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('clicked inkkwell');
                          ctrl.filterByCatogory(
                              ctrl.productCategory[index].name ?? 'general');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(
                              label: Text(ctrl.productCategory[index].name ??
                                  'no category')),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Flexible(
                        child: MultiSelectedDropdown(
                      items: ['Adidas', 'Puma', 'Nike'],
                      onSelectionChanged: (selectedItems) {
                        ctrl.filterByBrand(selectedItems);
                      },
                    )),
                    Flexible(
                        child: DropDown(
                      items: ['Rs: low to heigh', 'Rs: heigh to low'],
                      selectedItemText: 'sort By',
                      onSelected: (onselectedValue) {
                        bool isAscending = convertToBool(onselectedValue!);
                        ctrl.sortByPrice(ascending: isAscending);
                      },
                    )),
                  ],
                ),
              ),
              Flexible(
                child: GridView.builder(
                    itemCount: ctrl.filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            0.7, // this ratio will decide card height and width
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return ProductCart(
                        imageUrl:
                            ctrl.filteredProducts[index].image ?? 'noimage',
                        name: ctrl.filteredProducts[index].name ?? 'noName',
                        price: ctrl.filteredProducts[index].price ?? 0.0,
                        offer: '20% off',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDescriptionPage(
                                      ctrl.filteredProducts[index])));
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }

  bool convertToBool(String srt) {
    return srt == 'Rs: low to heigh' ? true : false;
  }
}
