import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import '../screens/forgotPassword.dart';
import '../screens/homescreen.dart';
import '../screens/registerPage.dart';
import '../services/authService.dart';
import 'customWidgets.dart';
import 'loadingScreen.dart';


class LoginWidget extends StatefulWidget {
  // Widget widget;
  //
  // LoginWidget({required this.widget});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late UserModel user;
  AuthService authService = AuthService();

  var email = TextEditingController();
  var isLoading = false;
  var passwordResetLoading = false;
  var password1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var hidePassword = true;

  ///persistent authentication
  ///
  final _storage = const FlutterSecureStorage();
  Future<void> _readFromStorage() async {
    email.text = await _storage.read(key: "KEY_EMAIL") ?? '';
    password1.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
    await authService.login(
      email: email.text,
      password: password1.text,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _readFromStorage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      // height: double.maxFinite,
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
            //
            //     child: CustomPaint(
            //       size:Size(MediaQuery.of(context).size.width,300),
            //   painter: CurvedPainter(),
            // )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
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
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

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
                            textInputType:
                            TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.appTextColor2,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                            labeltext: "Password",
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
                        Container(
                          height: 35,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  AppColors.appPrimaryColor),
                              onPressed: () async {
                                if (_formKey.currentState!
                                    .validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  var response =
                                  await authService.login(
                                      email: email.text,
                                      password: password1.text);
                                  if (response["detail"] == null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    await _storage.write(
                                        key: "KEY_EMAIL", value: email.text);
                                    await _storage.write(
                                        key: "KEY_PASSWORD", value: password1.text);
                                    Navigator.pushAndRemoveUntil(
                                        context, MaterialPageRoute(
                                        builder: (context) {
                                          return HomeScreen(
                                              response["user"]);
                                        }), (route) => false);

                                    // await _storage.write(
                                    //     key: "KEY_EMAIL", value: email.text);
                                    // await _storage.write(
                                    //     key: "KEY_PASSWORD", value: password1.text);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text("Welcome",style: TextStyle(color: Colors.white),),
                                        backgroundColor:
                                        Colors.green,
                                        dismissDirection:
                                        DismissDirection
                                            .horizontal,
                                        behavior:
                                        SnackBarBehavior.fixed,
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content:
                                        Text(response["detail"]),
                                        backgroundColor: Colors.pink,
                                        dismissDirection:
                                        DismissDirection
                                            .horizontal,
                                        behavior:
                                        SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                }
                                // print(response["detail"]);
                              },
                              child: const Text("Login")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 35,
                          width: double.maxFinite,
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: AppColors.appTextColor2,
                            ),
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: AppColors.appMainColor1,
                                  fontSize: 17),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return ForgotPasswordScreen();
                                      }));
                            },
                          ),
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
                              AppColors.appTextColor2,
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: AppColors.appTextColor3),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return RegisterPage();
                                      }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
