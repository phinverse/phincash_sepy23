// import 'package:flutter/material.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
// import 'package:get/get.dart';
// import 'package:phincash/src/preferences/controller/reset_pin_controller.dart';
// import '../../../constants/app_string.dart';
// import '../../../constants/colors.dart';
// import '../../../widget/bottom_sheet.dart';
// import '../../../widget/button_widget.dart';
// import '../../../widget/formfield_widget.dart';
//
// class UpdateNextOfKin extends StatefulWidget {
//   const UpdateNextOfKin({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateNextOfKin> createState() => _UpdateNextOfKinState();
// }
//
// class _UpdateNextOfKinState extends State<UpdateNextOfKin> {
//   final FlutterContactPicker _contactPicker = FlutterContactPicker();
//   String? _selectedContact;
//   String? _selectedSecondContact;
//   final _controller = Get.put(ResetPinController());
//
//
//   void showSecondNextOfKinBottomSheet(BuildContext context){
//     MyBottomSheet().showDismissibleBottomSheet(context: context, height: 450, children:
//     List.generate(_controller.nextOfKinRelationshipList.length, (index){
//       return GetBuilder<ResetPinController>(
//           init: ResetPinController(),
//           builder: (controller){
//             return InkWell(
//               onTap: (){
//                 _controller.selectSecondNextOfKin(index);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30,top: 30),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(_controller.nextOfKinRelationshipList[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
//                     _controller.secondNextOfKinRelationship == _controller.nextOfKinRelationshipList[index] ? Container(height: 18, width: 18,
//                       decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
//                       child: const Icon(Icons.check, size: 12, color: Colors.white,),
//                     ): const SizedBox()
//                   ],
//                 ),
//               ),);
//           });
//     },));
//   }
//
//   void showFirstNextOfKinBottomSheet(BuildContext context){
//     MyBottomSheet().showDismissibleBottomSheet(context: context, height: 450, children:
//     List.generate(_controller.nextOfKinRelationshipList.length, (index){
//       return GetBuilder<ResetPinController>(
//           init: ResetPinController(),
//           builder: (controller){
//             return InkWell(
//               onTap: (){
//                 _controller.selectFirstNextOFKin(index);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30,top: 30),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(_controller.nextOfKinRelationshipList[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
//                     _controller.nextOfKinRelationship == _controller.nextOfKinRelationshipList[index] ? Container(height: 18, width: 18,
//                       decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
//                       child: const Icon(Icons.check, size: 12, color: Colors.white,),
//                     ): const SizedBox()
//                   ],
//                 ),
//               ),);
//           });
//     },));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(top: false, bottom: false,
//       child: GetBuilder<ResetPinController>(
//         init: ResetPinController(),
//           builder: (controller){
//         return Scaffold(
//           key: _controller.scaffoldKey,
//           appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
//             title: Text("Update Emergency Contacts", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
//             leading: IconButton(onPressed: (){
//               Get.back();
//             },
//                 icon:const Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,)),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
//             child: Form(
//
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 35,),
//                   ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
//                       child: Text("Kindly provide your next of kin details to secure your account",
//                         style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54),
//                       )),
//                   Expanded(
//                       child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
//                                 child: Row(
//                                   children: [
//                                     const Text("*", style: TextStyle(color: Colors.red,fontSize: 30),),
//                                     const SizedBox(width: 20,),
//                                     Text("Update next of kin details",
//                                       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w600),
//                                     ),
//                                   ],
//                                 )),
//                             ...List.generate(_controller.emergencyContactData!.data!.length, (index){
//                               return Column(
//                                 children: [
//                                   FormFieldWidget(
//                                     controller: _controller.nextOfKinName,
//                                     labelText: "Next of kin (name)",
//                                     labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                                     validator: (value) => (value!.isEmpty? "Please enter Next Of Kin Name" : null),
//                                   ),
//                                   const SizedBox(height: 15,),
//                                   FormFieldWidget(
//                                     controller: _controller.nextOfKinEmail,
//                                     labelText: "Email",
//                                     labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                                     validator: (value){
//                                       if (value!.isEmpty){
//                                         return 'Please enter your email address';}
//                                       else if (!_controller.emailValidator.hasMatch(value)){
//                                         return "Please provide a valid email address";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                   const SizedBox(height: 15,),
//                                   Container(height: 67, width: double.maxFinite,
//                                     decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.7), borderRadius: BorderRadius.circular(15)),
//                                     child: TextButton(
//                                       style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
//                                       onPressed: (){
//                                         showFirstNextOfKinBottomSheet(context);
//                                       },
//                                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(_controller.nextOfKinRelationship ?? "Relationship",
//                                             style: TextStyle(color: _controller.nextOfKinRelationship == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
//                                           const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 15,),
//                                   FormFieldWidget(
//                                     controller: _controller.nextOfKinAddress,
//                                     labelText: "Next of Kin Address",
//                                     labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                                     validator: (value) => (value!.isEmpty? "Please enter Next Of Kin Address" : null),
//                                   ),
//                                   const SizedBox(height: 15,),
//                                   FormFieldWidget(
//                                     onTap: ()async {
//                                       Contact? contact = await _contactPicker.selectContact();
//                                       if(contact != null){
//                                         setState(() {
//                                           _selectedContact = contact.phoneNumbers!.first;
//                                           _controller.nextOfKinPhoneNumber.text = _selectedContact.toString().removeAllWhitespace;
//                                         });
//                                       }else{
//                                         null;
//                                       }
//                                     },
//                                     controller: _controller.nextOfKinPhoneNumber,
//                                     labelText: "Phone number",
//                                     labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                                     validator: (value){
//                                       if (value!.isEmpty){
//                                         return 'Please enter your PhoneNumber';}
//                                       else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               )
//                             })
//                             // const SizedBox(height: 14,),
//                             // ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
//                             //     child: Row(
//                             //       children: [
//                             //         const Text("*", style: TextStyle(color: Colors.red,fontSize: 30),),
//                             //         const SizedBox(width: 20,),
//                             //         Text("Second next of kin details",
//                             //           style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w600),
//                             //         ),
//                             //       ],
//                             //     )),
//                             // FormFieldWidget(
//                             //   controller: _controller.secondNextOfKinName,
//                             //   labelText: "Next of kin (name)",
//                             //   labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                             //   validator: (value) => (value!.isEmpty? "Please enter Next of Kin Name" : null),
//                             // ),
//                             // const SizedBox(height: 15,),
//                             // FormFieldWidget(
//                             //   controller: _controller.secondNextOfKinEmail,
//                             //   labelText: "Email",
//                             //   labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                             //   validator: (value){
//                             //     if (value!.isEmpty){
//                             //       return 'Please enter your email address';}
//                             //     else if (!_controller.emailValidator.hasMatch(value)){
//                             //       return "Please provide a valid email address";
//                             //     } else {
//                             //       return null;
//                             //     }
//                             //   },
//                             // ),
//                             // const SizedBox(height: 15,),
//                             // Container(height: 67, width: double.maxFinite,
//                             //   decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.7), borderRadius: BorderRadius.circular(15)),
//                             //   child: TextButton(
//                             //     style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
//                             //     onPressed: (){
//                             //       showSecondNextOfKinBottomSheet(context);
//                             //     },
//                             //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //       children: [
//                             //         Text(_controller.secondNextOfKinRelationship ?? "Relationship",
//                             //           style: TextStyle(color: _controller.secondNextOfKinRelationship == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
//                             //         const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
//                             //       ],
//                             //     ),
//                             //   ),
//                             // ),
//                             // const SizedBox(height: 15,),
//                             // FormFieldWidget(
//                             //   controller: _controller.secondNextOfKinAddress,
//                             //   labelText: "Next of Kin Address",
//                             //   labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                             //   validator: (value) => (value!.isEmpty? "Please enter Next of Kin Address" : null),
//                             // ),
//                             // const SizedBox(height: 14,),
//                             // FormFieldWidget(
//                             //   onTap: ()async {
//                             //     Contact? contact = await _contactPicker.selectContact();
//                             //     if(contact != null){
//                             //       setState(() {
//                             //         _selectedSecondContact = contact.phoneNumbers!.first;
//                             //         _controller.secondNextOfKinPhoneNumber.text = _selectedSecondContact.toString().removeAllWhitespace;
//                             //       });
//                             //     }else{
//                             //       null;
//                             //     }
//                             //   },
//                             //   controller: _controller.secondNextOfKinPhoneNumber,
//                             //   labelText: "Phone number",
//                             //   labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
//                             //   validator: (value){
//                             //     if (value!.isEmpty){
//                             //       return 'Please enter your PhoneNumber';}
//                             //     else {
//                             //       return null;
//                             //     }
//                             //   },
//                             // ),
//                             const SizedBox(height: 30,),
//                             Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Icon(Icons.lock_outlined, color: kPrimaryColorLight,),
//                                 const SizedBox(width: 10,),
//                                 Text("Phincash security guarantee", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle),),
//                               ],
//                             ),
//                             const SizedBox(height: 15,),
//                             ButtonWidget(
//                                 onPressed: (){
//                                   _controller.updateNextOfKin();
//                                 },
//                                 buttonText: "Continue",
//                                 height: 48, width: double.maxFinite
//                             ),
//                             const SizedBox(height: 15,),
//                           ],
//                         ),
//                       )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       })
//     );
//   }
// }
