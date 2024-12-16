import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Model/user_model.dart';
import 'package:fw_client/Pages/home_page.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  // create firebase instanse
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  late CollectionReference usersCollection;
  TextEditingController regNameController = TextEditingController();
  TextEditingController regPhoneController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController logEmailController = TextEditingController();
  TextEditingController logPasswordController = TextEditingController();

  @override
  void onInit() {
    usersCollection = firestore.collection('users');
    super.onInit();
  }

  addUserDetails(String userId) async {
    try {
      DocumentReference docRef = usersCollection.doc();
      UserModel user = UserModel(
          id: userId,
          name: regNameController.text,
          phone: regPhoneController.text,
          email: regEmailController.text,
          password: regPasswordController.text);

      // set user details
      await docRef.set(user.toMap());

      Get.snackbar('success', 'user details successfully added',
          colorText: Colors.green);
      // reset fields
      resetFields();
    } catch (e) {
      Get.snackbar('failed', e.toString(), colorText: Colors.red);
      print(e.toString());
    }
  }

  Signin(String email, String password) {
    if (logEmailController.text.isEmpty || logPasswordController.text.isEmpty) {
      Get.snackbar('required', 'please fill the fields', colorText: Colors.red);
      return; //if fields are empty it will return from here
    }
    mAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((onValue) {
      Get.to(() => HomePage());
    });
  }

  SignUpUser(String mail, String pwd) async {
    if (regNameController.text.isEmpty ||
        regPhoneController.text.isEmpty ||
        regEmailController.text.isEmpty ||
        regPasswordController.text.isEmpty) {
      Get.snackbar('required', 'please fill the fields', colorText: Colors.red);
      return; //if fields are empty it will return from here
    }
// otherwise create user
    await mAuth
        .createUserWithEmailAndPassword(email: mail, password: pwd)
        .then((success) {
      // when user is registered then store data
      addUserDetails(mAuth.currentUser!.uid);
    });
  }

  void resetFields() {
    regNameController.clear();
    regPhoneController.clear();
    regEmailController.clear();
    regPasswordController.clear();
  }
}
