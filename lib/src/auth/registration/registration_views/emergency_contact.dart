import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';
import '../controller/registration_controller.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  // final FlutterContactPicker _contactPicker = FlutterContactPicker();
  String? _firstContact;
  String? _secondContact;
  final _controller = Get.put(RegistrationController());

  void showFirstNextOfKinBottomSheet(BuildContext context) {
    MyBottomSheet().showDismissibleBottomSheet(
        context: context,
        height: 450,
        children: List.generate(
          _controller.nextOfKinRelationshipList.length,
          (index) {
            return GetBuilder<RegistrationController>(
                init: RegistrationController(),
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      _controller.selectFirstNextOFKin(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _controller.nextOfKinRelationshipList[index],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                          _controller.firstNextOfKinRelationship ==
                                  _controller.nextOfKinRelationshipList[index]
                              ? Container(
                                  height: 18,
                                  width: 18,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimaryColor),
                                  child: const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }

  void showSecondNextOfKinBottomSheet(BuildContext context) {
    MyBottomSheet().showDismissibleBottomSheet(
        context: context,
        height: 450,
        children: List.generate(
          _controller.nextOfKinRelationshipList.length,
          (index) {
            return GetBuilder<RegistrationController>(
                init: RegistrationController(),
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      _controller.selectSecondNextOfKin(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _controller.nextOfKinRelationshipList[index],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                          _controller.secondNextOfKinRelationship ==
                                  _controller.nextOfKinRelationshipList[index]
                              ? Container(
                                  height: 18,
                                  width: 18,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimaryColor),
                                  child: const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder(
          init: RegistrationController(),
          builder: (controller) {
            return Scaffold(
              key: _controller.scaffoldKeyEmergencyContact,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Emergency Contacts",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: AppString.latoFontStyle,
                      fontWeight: FontWeight.w700),
                ),
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 30,
                    )),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: Form(
                  key: _controller.formKeyEmergencyContact,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                              minHeight: 50),
                          child: Text(
                            "Kindly provide your next of kin details to secure your account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 14,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black54),
                          )),
                      Expanded(
                          child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.2,
                                    minHeight: 50),
                                child: Row(
                                  children: [
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 30),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "First next of kin details",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppString.latoFontStyle,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                            FormFieldWidget(
                              controller:
                                  _controller.firstNextOfKinNameController,
                              labelText: "Next of kin (name)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) => (value!.isEmpty
                                  ? "Please enter Next Of Kin Name"
                                  : null),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              controller:
                                  _controller.firstNextOfKinEmailController,
                              labelText: "Email (Optional)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              // validator: (value){
                              //   if (value!.isEmpty){
                              //     return 'Please enter your email address';}
                              //   else if (!_controller.emailValidator.hasMatch(value)){
                              //     return "Please provide a valid email address";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 45,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7),
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.transparent)),
                                onPressed: () {
                                  showFirstNextOfKinBottomSheet(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _controller.firstNextOfKinRelationship ??
                                          "Relationship",
                                      style: TextStyle(
                                          color: _controller
                                                      .firstNextOfKinRelationship ==
                                                  null
                                              ? Colors.black45
                                              : Colors.black,
                                          fontSize: 14,
                                          fontFamily: AppString.latoFontStyle),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.black45)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              controller:
                                  _controller.firstNextOfKinAddressController,
                              labelText: "Next of Kin Address (Optional)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              // validator: (value) => (value!.isEmpty? "Please enter Next Of Kin Address" : null),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              onTap: () async {
                                if (await FlutterContacts.requestPermission()) {
                                  // Get all contacts (lightly fetched)
                                  ProgressDialogHelper().showProgressDialog(
                                      context, "Loading contacts...");
                                  List<Contact> contacts =
                                      await FlutterContacts.getContacts();
                                  ProgressDialogHelper()
                                      .hideProgressDialog(context);

                                  if (contacts.isNotEmpty) {
                                    Get.bottomSheet(
                                        SelectContactSheet(
                                          contacts: contacts,
                                          controller: _controller
                                              .firstNextOfKinNumberController,
                                        ),
                                        isScrollControlled: true);
                                  }
                                }

                                //Contact? contact = await _contactPicker.selectContact();
                              },
                              controller:
                                  _controller.firstNextOfKinNumberController,
                              labelText: "Phone number",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your PhoneNumber';
                                }
                                // else if (!_controller.phoneValidator.hasMatch(value)){
                                //   return "Please provide a valid phoneNumber";
                                // }
                                else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.2,
                                    minHeight: 50),
                                child: Row(
                                  children: [
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 30),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Second next of kin details",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppString.latoFontStyle,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                            FormFieldWidget(
                              controller:
                                  _controller.secondNextOfKinNameController,
                              labelText: "Next of kin (name)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) => (value!.isEmpty
                                  ? "Please enter Next of Kin Name"
                                  : null),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              enabled: false,
                              controller:
                                  _controller.secondNextOfKinEmailController,
                              labelText: "Email (Optional)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              // validator: (value){
                              //   if (value!.isEmpty){
                              //     return 'Please enter your email address';}
                              //   else if (!_controller.emailValidator.hasMatch(value)){
                              //     return "Please provide a valid email address";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 45,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7),
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.transparent)),
                                onPressed: () {
                                  showSecondNextOfKinBottomSheet(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _controller.secondNextOfKinRelationship ??
                                          "Relationship",
                                      style: TextStyle(
                                          color: _controller
                                                      .secondNextOfKinRelationship ==
                                                  null
                                              ? Colors.black45
                                              : Colors.black,
                                          fontSize: 14,
                                          fontFamily: AppString.latoFontStyle),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.black45)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              enabled: false,
                              controller:
                                  _controller.secondNextOfKinAddressController,
                              labelText: "Next of Kin Address (Optional)",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              // validator: (value) => (value!.isEmpty? "Please enter Next of Kin Address" : null),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormFieldWidget(
                              onTap: () async {
                                if (await FlutterContacts.requestPermission()) {
                                  // Get all contacts (lightly fetched)
                                  ProgressDialogHelper().showProgressDialog(
                                      context, "Loading contacts...");
                                  List<Contact> contacts =
                                      await FlutterContacts.getContacts();
                                  ProgressDialogHelper()
                                      .hideProgressDialog(context);

                                  if (contacts.isNotEmpty) {
                                    Get.bottomSheet(
                                        SelectContactSheet(
                                          contacts: contacts,
                                          controller: _controller
                                              .secondNextOfKinNumberController,
                                        ),
                                        isScrollControlled: true);
                                  }
                                }
                              },
                              controller:
                                  _controller.secondNextOfKinNumberController,
                              labelText: "Phone number",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your PhoneNumber';
                                }
                                // else if (!_controller.phoneValidator.hasMatch(value)){
                                //   return "Please provide a valid phoneNumber";
                                // }
                                else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.lock_outlined,
                                  color: kPrimaryColorLight,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Phincash security guarantee",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.black45,
                                          fontFamily: AppString.latoFontStyle),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ButtonWidget(
                                onPressed: () {
                                  _controller.collectNextOfKinDetails();
                                },
                                buttonText: "Continue",
                                height: 48,
                                width: double.maxFinite),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class SelectContactSheet extends StatelessWidget {
  const SelectContactSheet(
      {Key? key, required this.contacts, required this.controller})
      : super(key: key);
  final List<Contact> contacts;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(contacts[index].displayName),
              // subtitle: Text(contacts[index].phones[0].number),
              onTap: () async {
                print(contacts[index].toJson());
                Contact? contact =
                    await FlutterContacts.getContact(contacts[index].id);
                controller.text = contact!.phones[0].number.removeAllWhitespace;
                Get.back();
              });
        },
      ),
    );
  }
}
