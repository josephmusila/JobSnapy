import 'dart:convert';

import 'package:http/http.dart' as http;


import '../config/urls.dart';
import '../models/emailErrors.dart';
import '../models/userModel.dart';



class ErrorModel{
  String key;
  String value;

  ErrorModel({required this.key,required this.value});
}

class AuthService{

  String token = "";

  Future<dynamic> register({
  required String firstName,
    required String lastname,
    required String email,
    required String phone,
    required String password
}) async{
    var message = {
      "status_code": 0,
      "message":""
    };
   try {
     var response = await http.post(Uri.parse("${BaseUrls().baseUrl}register/"),body: {
     "first_name":firstName,
       "last_name":lastname,
       "email":email,
       "phone":phone,
       "password":password
     });

     if(response.statusCode == 200){
       var message = {
         "status_code": response.statusCode,
         "message":"Account Created Successfully"
       };
       return message;
     }else{
       var message = {
         "status_code": response.statusCode,
         "message":(response.body).toString()
       };
       return message;
     }
   }  catch (e) {
    throw e.toString();
   }
  }


  Future<dynamic> login({required String email,required String password}) async{
    try{
      var response = await http.post(Uri.parse("${BaseUrls().baseUrl}login/"),body: {
        "email":email,
        "password":password
      });
      if(response.statusCode == 200){
        // token = jsonDecode(response.body)["jwt token"];
        var message = {
          "status":response.statusCode,
          "detail":null,
          "user":UserModel.fromJson(json.decode(response.body)["user"])
          // "user":userModelFromJson(jsonDecode(response.body)["user"])
        };
        print(message);
        return (message);
      }else{
        var message = {
          "status":response.statusCode,
          "detail":jsonDecode(response.body)["detail"]
        };
        return (message);
      }
    }on Exception catch(e){
      throw e.toString();
    }
  }

  Future<dynamic> updateProfile({
    required String firstName,
    required String lastname,
    required String email,
    required String phone,
    required String password,
    required String id,
  }) async{
    var message = {
      "status_code": 0,
      "message":""
    };
    try {
      var response = await http.put(Uri.parse("${BaseUrls().baseUrl}update_profile/$id/"),body: {
        "first_name":firstName,
        "last_name":lastname,
        "email":email,
        "phone":phone,
        "password":password
      });

      if(response.statusCode == 200){
        var message = {
          "status_code": response.statusCode,
          "message":"Account Updated Successfully"
        };
        return message;
      }else{
        var message = {
          "status_code": response.statusCode,
          "message":EmailErrors.fromJson(json.decode(response.body))
        };
        return message;
      }

    }  catch (e) {
      throw e.toString();
    }
  }
  
  Future<dynamic> requestResetPassword({required String email}) async{

    try {
      var response  = await http.post(Uri.parse("${BaseUrls().baseUrl}password/request_reset/"),body: {
        "email":email,
      });
      // print(response.body);
        return response.statusCode;
    } on Exception catch (e) {
      return e.toString();
      // TODO
    }
    // print(response.body);
  }
  Future<dynamic> resetPassword({ required String email,required  String otp,required  String password}) async{
    var response  = await http.post(Uri.parse("${BaseUrls().baseUrl}password/reset/"),body: {
      "email":email,
      "otp":otp,
      "password":password
    });

    var message={
      "res":"",
      "code":response.statusCode

    };
    if(json.decode(response.body)["detail"] != null){
      message["res"] = "OTP did not  match";
    }else if(json.decode(response.body)["message"] != null){
      message["res"] = "Password Updated Successfully";
    }else{
      message["res"] = "An error occurred during password reset";
    }
    
return message;

  }

}