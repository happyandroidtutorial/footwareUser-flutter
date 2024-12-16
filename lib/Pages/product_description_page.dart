import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Model/product.dart';
import 'package:fw_client/controller/purchase_controller.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatelessWidget {
  var ctrl = Get.put(PurchaseController());
  Product product;
  ProductDescriptionPage(this.product);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image.toString(),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  product.name.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  product.description.toString(),
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Rs : ${product.price.toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green[300]),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: ctrl.billingAddressController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: Text('Enter billing Address')),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ctrl.addOrder(
                          product, ctrl.billingAddressController.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Buy Now'),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
