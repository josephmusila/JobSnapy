// import 'package:flutter/material.dart';
//
// class CustDialogBox extends StatelessWidget {
//   const CustDialogBox({Key? key}) : super(key: key);
//
//       String title,
//       TextEditingController controller
//
//   @override
//   Widget build(BuildContext context) {
//     return  showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               // height:MediaQuery.of(context).size.height * 0.7 ,
//               width: MediaQuery.of(context).size.width * 0.9,
//               child: Wrap(
//                 alignment: WrapAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(fontSize: 18, color: Colors.deepOrange),
//                   ),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             if (controller == physicalController) {
//                               var response = await machineServices.updateTest(
//                                 id: widget.machineData.id.toString(),
//                                 physical: physicalController.text,
//                                 insulation: insulationController.text,
//                               );
//                               setState(() {
//
//                               });
//
//                             } else {
//                               machineServices.updateTest(
//                                 id: widget.machineData.id.toString(),
//                                 insulation: insulationController.text,
//                                 physical: physicalController.text,
//                               );
//                               setState(() {
//
//                               });
//                             }
//
//                             Navigator.of(context).pop();
//                           },
//
//                           child: const Text("Update")),
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text("Cancel"))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
// // showDialog(context, String title, TextEditingController controller) {
//   // return showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return Dialog(
//   //         child: Container(
//   //           padding: const EdgeInsets.all(10),
//   //           // height:MediaQuery.of(context).size.height * 0.7 ,
//   //           width: MediaQuery.of(context).size.width * 0.9,
//   //           child: Wrap(
//   //             alignment: WrapAlignment.spaceEvenly,
//   //             children: [
//   //               Text(
//   //                 title,
//   //                 style: const TextStyle(fontSize: 18, color: Colors.deepOrange),
//   //               ),
//   //               Scrollbar(
//   //                 controller: scrollController,
//   //                 isAlwaysShown: true,
//   //                 child: TextFormField(
//   //                   scrollController: scrollController,
//   //                   keyboardType: TextInputType.multiline,
//   //                   controller: controller,
//   //                   minLines: 1,
//   //                   maxLines: 7,
//   //                   decoration: const InputDecoration(
//   //                     border: OutlineInputBorder(
//   //                       borderRadius: BorderRadius.all(
//   //                         Radius.circular(
//   //                           6.0,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                 children: [
//   //                   ElevatedButton(
//   //                       onPressed: () async {
//   //                         if (controller == physicalController) {
//   //                           var response = await machineServices.updateTest(
//   //                             id: widget.machineData.id.toString(),
//   //                             physical: physicalController.text,
//   //                             insulation: insulationController.text,
//   //                           );
//   //                           setState(() {
//   //
//   //                           });
//   //
//   //                         } else {
//   //                           machineServices.updateTest(
//   //                             id: widget.machineData.id.toString(),
//   //                             insulation: insulationController.text,
//   //                             physical: physicalController.text,
//   //                           );
//   //                           setState(() {
//   //
//   //                           });
//   //                         }
//   //
//   //                         Navigator.of(context).pop();
//   //                       },
//   //
//   //                       child: const Text("Update")),
//   //                   ElevatedButton(
//   //                       onPressed: () {
//   //                         Navigator.of(context).pop();
//   //                       },
//   //                       child: const Text("Cancel"))
//   //                 ],
//   //               )
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     });
// // }
