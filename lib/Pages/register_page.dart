import 'package:flutter/material.dart';
import 'package:fw_client/Pages/login_page.dart';
import 'package:fw_client/Widgets/otp_textfield.dart';
import 'package:fw_client/controller/login_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  // register our controller
  var ctrl = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create your Account!!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.regNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Name'),
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.regPhoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Number'),
                    hintText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone_android)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.regEmailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Email'),
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: ctrl.regPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Password'),
                    hintText: 'Enter Passsword',
                    prefixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  ctrl.SignUpUser(ctrl.regEmailController.text,
                      ctrl.regPasswordController.text);
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => LoginPage());
                  },
                  child: Text('Login to an existing account')),
            ],
          ),
        ),
      );
    });
  }
}
