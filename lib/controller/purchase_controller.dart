import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Model/order_model.dart';
import 'package:fw_client/Model/product.dart';
import 'package:fw_client/Pages/home_page.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  late CollectionReference orderCollection;
  TextEditingController billingAddressController = TextEditingController();
  List<OrderModel> orderList = [];

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    // TODO: implement onInit
    super.onInit();
  }

// method to add product
  addOrder(Product product, String adress) {
    try {
      DocumentReference doc = orderCollection.doc();
      OrderModel order = OrderModel(
          id: product.id,
          name: product.name,
          category: product.category,
          description: product.description,
          price: product.price,
          brand: product.brand,
          image: product.image,
          offer: product.offer,
          address: adress,
          userId: FirebaseAuth.instance.currentUser!.uid);
      final productJson = order.toJson();
// set datA  in firebase document
      doc.set(productJson);
      // Get.snackbar('success', 'Order requested successfully',
      //     colorText: Colors.green);
      showOrderSuccessDialog();
      update();
    } catch (e) {
      Get.snackbar('Failed', 'order request Failed', colorText: Colors.red);
      print(e.toString());
    }
  }

  fetchOrders() async {
    try {
      print('featch data called');
      QuerySnapshot orderSnapshot = await orderCollection
          .where('userId', isEqualTo: mAuth.currentUser!.uid)
          .get();
      final List<OrderModel> retrivedProducts = orderSnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      print('orders : $retrivedProducts');
      // now clear the created list to add this data otherwise it will readd
      // products.clear();

      orderList.assignAll(retrivedProducts);
      update(); // it will work to update ui
    } catch (e) {
      print(e);
    }
  }

  deleteData(String id) async {
    var documentId = orderCollection.doc().id;
    await orderCollection.doc(id).delete();
    Get.snackbar('success', 'Deleted successfully', colorText: Colors.green);

    fetchOrders();
  }

  showOrderSuccessDialog() {
    Get.defaultDialog(
        title: 'Order Success',
        content: Text('Your order successfully placesd'),
        confirm: ElevatedButton(
            onPressed: () {
              Get.off(HomePage());
            },
            child: Text('Close')));
  }
}
