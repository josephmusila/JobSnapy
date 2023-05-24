import 'package:flutter/material.dart';


import '../config/colors.dart';
import '../services/abuseReport.dart';
import '../widgets/customWidgets.dart';
import '../widgets/loadingScreen.dart';

class BugReport extends StatefulWidget {
  @override
  State<BugReport> createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
  AbuseReportService abuseReportService = AbuseReportService();
  final _formKey = GlobalKey<FormState>();
  var bugreportController = TextEditingController();
  var isLoading = false;
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
        title: const Text("Report A Bug"),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.whiteColor,
        child: Center(
          child: Container(
            // height: 400,
            width: double.maxFinite,
            margin: const EdgeInsets.all((10)),
            padding: const EdgeInsets.all((10)),
            decoration: const BoxDecoration(
              // color: AppColors.appMainColor2,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      "Have you faced any difficulties \nwhile using the app?\n\n"
                      "Please let us Know.\n\nIndicate the OS you are running on(IOS/Android/Other)",
                      style: TextStyle(color: AppColors.appTextColor1, fontSize: 15),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    // padding: const EdgeInsets.all((10)),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // height: 300,
                    width: MediaQuery.of(context).size.width*0.9,

                    child: isLoading
                        ? Container(
                      width: double.maxFinite,
                            height: 200,
                            child: LoadingScreen(message: "Sending ...."),
                          )
                        : Card(
                      elevation: 3,
                      color: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all((10)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                      labeltext: "Report a Bug",
                                      hintText:
                                          "let us know the issue you are facing in details",
                                      controller: bugreportController,
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
                                    height: 35,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.appMainColor1),
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            var response =
                                                await abuseReportService.bugReport(
                                              issue: bugreportController.text,
                                            );
                                            if (response["status-code"] == 200) {
                                              bugreportController.text = "";
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
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
                                        child: const Text("Send")),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
