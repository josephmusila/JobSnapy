import 'dart:convert';

EmailErrors emailErrorsFromJson(String str) => EmailErrors.fromJson(json.decode(str));

String emailErrorsToJson(EmailErrors data) => json.encode(data.toJson());

class EmailErrors{
  List<String> email;

  EmailErrors({
    required this.email
});

  factory EmailErrors.fromJson(Map<String,dynamic> json) => EmailErrors(email: List<String>.from(json["Email"].map((x)=>x)));

  Map<String,dynamic> toJson() =>{
    "Email":List<dynamic>.from(email.map((e) => e))
  };
}
