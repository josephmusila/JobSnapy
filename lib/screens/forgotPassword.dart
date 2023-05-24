
import 'package:flutter/material.dart';
import 'package:jobsnap/screens/resetPasswordScreen.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import '../services/authService.dart';
import '../widgets/customWidgets.dart';
import '../widgets/loadingScreen.dart';
import '../widgets/snackbar.dart';
import '../widgets/topShape.dart';
import 'customerCare.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late UserModel user;
  AuthService authService = AuthService();
  var email = TextEditingController();

  var isLoading = false;
  var passwordResetLoading = false;
  var password1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        title: const Text("Forgot Password"),
      ),
      body: Container(
        color: AppColors.whiteColor,
        height: double.maxFinite,
        width: double.maxFinite,
        child: isLoading
            ? LoadingScreen(
                message: "Please wait..",
              )
            : Container(
                child: Stack(
                  children: [
                    // Positioned(
                    //   top: 0,
                    //     child: CustomPaint(
                    //   size:Size(MediaQuery.of(context).size.width,300),
                    //   painter: CurvedPainter(),
                    // )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration:  const BoxDecoration(
                              // color: Colors.black12,
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
                                  Container(
                                    height: 50,
                                    child: const Text(
                                      "Enter the Email you used during registration.",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.appTextColor2),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                      labeltext: "Email",
                                      hintText: "johndoe@gmail.com",
                                      controller: email,
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

                                            var response = await authService
                                                .requestResetPassword(
                                                    email: email.text);
                                            if (response == 200) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(Utils.displayToast(
                                                      "Reset Code sent to your email",
                                                      Colors.green));
                                              setState(() {
                                                isLoading = false;
                                              });

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ResetPasswordScreen(
                                                  email: email.text,
                                                );
                                              }));
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      Utils.displayToast(
                                                          "No matching Email  Found"
                                                              .toString(),
                                                          Colors.red));
                                            }
                                          }
                                        },
                                        child: const Text("Request OTP")),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 35,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.appTextColor2,
                                      ),
                                      child: const Text(
                                        "Customer Care",
                                        style: TextStyle(
                                            color: AppColors.appTextColor3),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                              return CustomerCare();
                                            }));
                                      },
                                    ),
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
