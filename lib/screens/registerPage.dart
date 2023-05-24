import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../services/authService.dart';
import '../widgets/customWidgets.dart';
import '../widgets/navDrawer.dart';
import 'loginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password1 = TextEditingController();
  var password2 = TextEditingController();
  var isLoading = false;
  var hidePassword = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Colors.transparent,
        backgroundColor: AppColors.appMainColor2,
        // elevation: 0,
        title: const Text("Register"),
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
                  backgroundColor: Colors.lightGreen,
                ),
              )
            : Container(
                padding: const EdgeInsets.only(top: 20),
                height: double.maxFinite,
                alignment: Alignment.bottomCenter,
                color: AppColors.whiteColor,
                child: ListView(
                  children: [
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      child:  const Center(
                        child: Text(
                          "You Can also Register as a Company.",
                          style: TextStyle(
                            color: AppColors.appTextColor1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: ListView(
                            padding: const EdgeInsets.only(top: 10),
                            // mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              CustomTextField(
                                  labeltext: "First Name",
                                  hintText: "john",
                                  controller: firstname,
                                  onchanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please fill in the  field";
                                    }
                                    return null;
                                  },
                                  hideText: false,
                                  maxlines: 1,
                                  textInputType: TextInputType.text),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  labeltext: "Last Name",
                                  hintText: "doe",
                                  controller: lastname,
                                  onchanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please fill in the  field";
                                    }
                                    return null;
                                  },
                                  hideText: false,
                                  maxlines: 1,
                                  textInputType: TextInputType.text),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  labeltext: "Email",
                                  hintText: "johndoe@gmail.com",
                                  controller: email,
                                  onchanged: (value) {},
                                  validator: (value) {
                                    final pattern = RegExp(
                                        r"^[\w-\.] + @([\w-] + \.)+[\w-]{2,4}$");

                                    if (value == null || value.isEmpty) {
                                      return "please fill in the  field";
                                    } else if (!RegExp(r'\S+@\S+\.\S+')
                                        .hasMatch(value)) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                  hideText: false,
                                  maxlines: 1,
                                  textInputType: TextInputType.emailAddress),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  labeltext: "Phone",
                                  hintText: "0712345678",
                                  controller: phone,
                                  onchanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please fill in the  field";
                                    }
                                    return null;
                                  },
                                  hideText: false,
                                  maxlines: 1,
                                  textInputType: TextInputType.phone),
                              const SizedBox(
                                height: 10,
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
                                height: 10,
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
                                  labeltext: "Confirm Password",
                                  hintText: "Pass@1234",
                                  controller: password2,
                                  onchanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please fill in the  field";
                                    } else if (password1.text !=
                                        password2.text) {
                                      return "Passwords do not match";
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
                                        try {
                                          var response =
                                              await authService.register(
                                                  firstName: firstname.text,
                                                  lastname: lastname.text,
                                                  email: email.text,
                                                  phone: phone.text,
                                                  password: password2.text);

                                          if (response["status_code"] == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(response["message"]),
                                                backgroundColor: Colors.green,
                                                dismissDirection:
                                                    DismissDirection.horizontal,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return LoginPage();
                                            }));
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(response["message"]),
                                                backgroundColor: Colors.pink,
                                                dismissDirection:
                                                    DismissDirection.horizontal,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                              backgroundColor: Colors.green,
                                              dismissDirection:
                                                  DismissDirection.horizontal,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: const Text("Register")),
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
                                    "Login",
                                    style: TextStyle(
                                        color: AppColors.appTextColor3),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginPage();
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
                  ],
                ),
              ),
      ),
    );
  }
}
