import 'package:flutter/material.dart';


import '../config/colors.dart';
import '../models/userModel.dart';
import '../services/abuseReport.dart';
import '../widgets/customWidgets.dart';
import '../widgets/loadingScreen.dart';

class AbuseReport extends StatefulWidget {
  UserModel? user;

  AbuseReport([this.user]);

  @override
  State<AbuseReport> createState() => _AbuseReportState();
}

class _AbuseReportState extends State<AbuseReport> {


  AbuseReportService abuseReportService = AbuseReportService();
  final _formKey = GlobalKey<FormState>();
  var abuseTextController = TextEditingController();
  var isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.appMainColor2,
        title: Text("Report Abuse"),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.whiteColor,
        child: Center(
          child: Container(
            height: 400,
            width: double.maxFinite,
            margin: const EdgeInsets.all((10)),
            padding: const EdgeInsets.all((10)),
            decoration: const BoxDecoration(
              // color: AppColors.appMainColor2,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children:  [
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    padding: const EdgeInsets.all((10)),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor1,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      "At JobSnap we are always concerned about"
                      " the welfare of our customers.\n\nPlease in case of any issue concerning our services"
                      " feel free to let us know.",
                      style: TextStyle(color: AppColors.appTextColor1,fontSize: 15,height: 1.2),
                    ),

                  ),
                ),
               const SizedBox(height: 20,),
               Form(
                  key: _formKey,
                  child: Card(
                    elevation: 5,
                    color: AppColors.whiteColor1,
                    shadowColor: const Color.fromARGB(255, 1, 95, 236),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        // color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      // color: Colors.red,
                      padding:
                      const EdgeInsets.only(top: 0, left: 20, right: 20),
                      // height: 230,

                      child:  isLoading? LoadingScreen(message: "Sending ...."):Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labeltext: "Report Issue",
                              hintText: "Your issue here",
                              controller: abuseTextController,
                              onchanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please fill in the  field";
                                }
                                return null;
                              },
                              hideText: false,
                              maxlines: 5,
                              textInputType: TextInputType.multiline),
                          const SizedBox(
                            height: 20,
                          ),

                          Container(
                            width: double.maxFinite,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appMainColor1
                              ),
                                onPressed: () async {

                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var response = await abuseReportService.abuseReport(
                                        issue: abuseTextController.text,
                                        );
                                    if(response["status-code"] == 200){
                                      abuseTextController.text = "";
                                    }
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                          content: Text(response["message"]),
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
                                },
                                child: const Text("Report")),
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
      ),
    );
  }
}
