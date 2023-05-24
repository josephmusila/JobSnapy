import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../config/colors.dart';
import '../models/userModel.dart';
import '../services/authService.dart';
import '../widgets/customWidgets.dart';
import '../widgets/navDrawer.dart';
import '../widgets/snackbar.dart';
import 'homescreen.dart';
import 'loginPage.dart';

class ResetPasswordScreen extends StatefulWidget {
  String email;

  ResetPasswordScreen({required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late UserModel user;
  AuthService authService = AuthService();
  var password2 = TextEditingController();
  var otp = TextEditingController();
  var isLoading = false;
  var password1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passformKey = GlobalKey<FormState>();
  var hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Colors.transparent,
        backgroundColor: AppColors.appMainColor2,
        // elevation: 0,
        title: const Text("Reset Password"),
      ),
      body: Container(
        color: AppColors.appMainColor2,
        height: double.maxFinite,
        width: double.maxFinite,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.pink,
                  backgroundColor: Colors.green,
                ),
              )
            : Container(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              margin: const EdgeInsets.only(top: 0),
                              // color: Colors.red,
                              padding: const EdgeInsets.only(
                                  top: 0, left: 20, right: 20),
                              height: 300,
                              width: 600,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                      labeltext: "OTP",
                                      hintText: "your otp from email",
                                      controller: otp,
                                      onchanged: (value) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please fill in the  field";
                                        }
                                        return null;
                                      },
                                      hideText: false,
                                      maxlines: 1,
                                      textInputType: TextInputType.emailAddress),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.appMainColor2,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                      ),
                                      labeltext: "New Password",
                                      hintText: "Pass@1234",
                                      controller: password1,
                                      onchanged: (value) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please fill in the  field";
                                        }
                                        return null;
                                      },
                                      hideText: hidePassword,
                                      maxlines: 1,
                                      textInputType: TextInputType.text),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.appMainColor2,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                      ),
                                      labeltext: "Confirm  new Password",
                                      hintText: "Pass@1234",
                                      controller: password2,
                                      onchanged: (value) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please fill in the  field";
                                        }
                                        return null;
                                      },
                                      hideText: hidePassword,
                                      maxlines: 1,
                                      textInputType: TextInputType.text),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 35,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.appPrimaryColor),
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            var response =
                                                await authService.resetPassword(
                                                    email: widget.email,
                                                    otp: otp.text,
                                                    password: password1.text);
                                            print(response);

                                            if (response["code"] != 200) {
                                              setState(() {
                                                isLoading = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        Utils.displayToast(
                                                            response["res"],
                                                            Colors.red));
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      Utils.displayToast(
                                                          response["res"],
                                                          Colors.green));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LoginPage();
                                              }));
                                            }

                                            // if (response["message"] != null) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(Utils.displayToast(
                                            //       "Password Updated",
                                            //       Colors.green));
                                            //   setState(() {
                                            //     isLoading = false;
                                            //   });
                                            //
                                            // } else if (response["detail"] != null){
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(Utils.displayToast(
                                            //       "OTP did not match",
                                            //       Colors.green));
                                            //   setState(() {
                                            //     isLoading = false;
                                            //   });
                                            //
                                            // }
                                          } else {
                                            print("error");
                                          }
                                          // print(response["detail"]);
                                        },
                                        child: const Text("Reset")),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
