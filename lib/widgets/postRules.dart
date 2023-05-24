import 'package:flutter/material.dart';

import '../config/colors.dart';

class PostRules extends StatefulWidget {
  const PostRules({Key? key}) : super(key: key);

  @override
  State<PostRules> createState() => _PostRulesState();
}

class _PostRulesState extends State<PostRules> {
  bool showContetnt = false;

  // final _data = gene
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                showContetnt = !showContetnt;
              });
            },
            title: const Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 18,
                color: Colors.pink,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                showContetnt ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.pink,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  showContetnt = !showContetnt;
                });
              },
            ),
          ),
          showContetnt
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
                          Text("1.Dont Spam.",style: TextStyle(color: AppColors.appTextColor1),),
                          Text("2.Jobs auto delete after 14 days.",style: TextStyle(color: AppColors.appTextColor1),),
                          Text("3.You can only post 4 jobs per day.",style: TextStyle(color: AppColors.appTextColor1),),
                          Text("4.Fake jobs will lead to permanent ban.",style: TextStyle(color: AppColors.appTextColor1),),
                           SizedBox(height: 10,),
                          Text("By pressing post you agree to these terms and conditions",style: TextStyle(color: AppColors.appPrimaryColor),),
                        ],
                      ),)
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
