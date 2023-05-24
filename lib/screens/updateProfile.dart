import 'package:flutter/material.dart';


import '../config/colors.dart';
import '../models/userModel.dart';
import '../services/authService.dart';
import '../widgets/customWidgets.dart';
import '../widgets/navDrawer.dart';
import 'loginPage.dart';

class UpdateProfilePage extends StatefulWidget {
  UserModel user;

  UpdateProfilePage({required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {





  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password1 = TextEditingController();
  var password2 = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    firstname.text=widget.user.firstName;
    lastname.text=widget.user.lastName;
    email.text = widget.user.email;
    phone.text=widget.user.phone;

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

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
        elevation: 5,
        title: const Text("Update Profile"),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        color: AppColors.whiteColor,
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
              color: AppColors.whiteColor1,
              height: 500,
              child: Form(
                key: _formKey,
                child: Card(
                  // elevation: 5,
                  color: AppColors.whiteColor,
                  shadowColor: Color.fromARGB(255, 1, 95, 236),
                  child: Container(
                    color: AppColors.whiteColor1,
                    padding:
                        const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      padding: const EdgeInsets.only(top: 20),
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
                            hideText: true,
                            maxlines: 1,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            labeltext: "Confirm Password",
                            hintText: "Pass@1234",
                            controller: password2,
                            onchanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please fill in the  field";
                              } else if (password1.text != password2.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            hideText: true,
                            maxlines: 1,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(height: 35,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.appMainColor1),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    var response =
                                        await authService.updateProfile(
                                            firstName: firstname.text,
                                            lastname: lastname.text,
                                            email: email.text,
                                            phone: phone.text,
                                            password: password2.text,
                                          id: widget.user.id.toString()
                                        );

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

                                    print(response);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.green,
                                        dismissDirection:
                                            DismissDirection.horizontal,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                              child: const Text("Update")),
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
    );
  }
}
