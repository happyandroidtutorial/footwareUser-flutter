import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Model/product.dart';
import 'package:fw_client/Model/product_category.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
// Reference to the Firestore collection
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<ProductCategory> productCategory = [];

  @override
  void onInit() async {
    print('on init invoked');
    productCollection = firebaseFirestore.collection('footwareProduct');
    categoryCollection = firebaseFirestore.collection('category');
    await fetchData();
    await fetchCategory();
    // Get called when controller is created
    super.onInit();
  }

  // Fetch products from Firestore
  fetchData() async {
    try {
      print('featch data called');
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrivedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      print('products : $retrivedProducts');
      // now clear the created list to add this data otherwise it will readd
      products.clear();
      filteredProducts.clear();

      products.assignAll(retrivedProducts);
      filteredProducts.assignAll(products);
      update(); // it will work to update ui
    } catch (e) {
      print(e);
    }
  }

  fetchCategory() async {
    try {
      print('featch category called');
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrivedCategory = categorySnapshot.docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      print('products : $retrivedCategory');
      // now clear the created list to add this data otherwise it will readd
      productCategory.clear();

      productCategory.assignAll(retrivedCategory);
      update(); // it will work to update ui
    } catch (e) {
      print(e);
    }
  }

// filterr by category
  filterByCatogory(String category) {
    filteredProducts.clear();
    filteredProducts =
        products.where((product) => product.category == category).toList();
    update();
  }

// filter by Brand

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      filteredProducts = products;
    } else {
      List<String> lowerCaseBrands =
          brands.map((brand) => brand.toLowerCase()).toList();
      filteredProducts = products
          .where((product) =>
              lowerCaseBrands.contains(product.brand?.toLowerCase()))
          .toList();
    }
    update();
  }

// sort by price
  sortByPrice({required bool ascending}) {
    List<Product> sortedProduct = List<Product>.from(filteredProducts);
    sortedProduct.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));

    filteredProducts = sortedProduct;
    update();
  }
}
