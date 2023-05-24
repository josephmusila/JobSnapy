import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/screens/registerPage.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/colors.dart';
import '../widgets/loginWidget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  // final _storage = const FlutterSecureStorage();

  // Future<void> _readFromStorage() async{
  //   email.text = await _storage.read(key: "KEY_EMAIL") ?? "";
  //   password1.text = await _storage.read(key: "KEY_PASSWORD")??"";
  //
  //   await authService.login(email: email.text, password: password1.text);
  //
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _readFromStorage();

    super.initState();
  }

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
        title: const Text("Login"),
      ),
      body: LoginWidget(),

    );
  }
}
