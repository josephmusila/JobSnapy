import 'package:flutter/material.dart';

class  MonthFormat{
  String value;
  String name;

  MonthFormat({required this.value,required this.name});
}

class DateBulider extends StatelessWidget {
  const DateBulider({Key? key}) : super(key: key);

  void buildDate(String date){
    date = "2020-07-10";
    var months= [
      MonthFormat(value: "01", name: "Jan"),
      MonthFormat(value: "02", name: "Feb"),
      MonthFormat(value: "03", name: "Mar"),
      MonthFormat(value: "04", name: "Apr"),
      MonthFormat(value: "05", name: "May"),
      MonthFormat(value: "06", name: "June"),
      MonthFormat(value: "07", name: "July"),
      MonthFormat(value: "08", name: "Aug"),
      MonthFormat(value: "01", name: "Jan"),
      MonthFormat(value: "01", name: "Jan"),
      MonthFormat(value: "01", name: "Jan"),
      MonthFormat(value: "01", name: "Jan"),
    ];


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
