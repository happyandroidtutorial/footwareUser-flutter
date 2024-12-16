import 'package:flutter/material.dart';
import 'package:fw_client/Pages/register_page.dart';
import 'package:fw_client/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
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
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.logEmailController,
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
                controller: ctrl.logPasswordController,
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
                  ctrl.Signin(ctrl.logEmailController.text,
                      ctrl.logPasswordController.text);
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => RegisterPage());
                  },
                  child: Text('Register a new account')),
            ],
          ),
        ),
      );
    });
  }
}
