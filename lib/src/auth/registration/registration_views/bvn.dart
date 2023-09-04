import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/widget/formfield_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';

class BvnVerificationScreen extends StatelessWidget {
  const BvnVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registrationcontroller = Get.put(RegistrationController());
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<RegistrationController>(
          init: RegistrationController(),
          builder: (controller) {
            return Scaffold(
              key: _registrationcontroller.scaffoldKeyBvnScreen,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "BVN Authentication",
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
                      size: 20,
                    )),
              ),
              body: Form(
                key: _registrationcontroller.formKeyBvnScreen,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Align(
                      //     alignment: Alignment.topRight,
                      //     child: TextButton(
                      //       onPressed: () {
                      //         Get.offAll(() => const EmergencyContact());
                      //       },
                      //       child: Text(AppString.skip,
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .bodyMedium
                      //               ?.copyWith(
                      //                   fontSize: 16,
                      //                   fontFamily: AppString.latoFontStyle,
                      //                   fontWeight: FontWeight.w700)),
                      //     )),
                      const SizedBox(
                        height: 35,
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                              minHeight: 10),
                          child: Text(
                            "Please ensure the Bvn is related to the information provided. Do not use someone else’s information.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 14,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      //Text("Bvn", style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                      FormFieldWidget(
                        keyboardType: TextInputType.number,
                        labelText: "BVN",
                        controller: _registrationcontroller.bvnController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: AppString.latoFontStyle,
                                color: Colors.black45),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Bvn Number';
                          } else if (value.length < 11) {
                            return "Bvn must be 11 digits";
                          } else if (value.length > 11) {
                            return "Bvn must be 11 digits";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FormFieldWidget(
                        keyboardType: TextInputType.text,
                        labelText: "First Name",
                        controller:
                            _registrationcontroller.bvnFirstnameController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: AppString.latoFontStyle,
                                color: Colors.black45),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your First name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FormFieldWidget(
                        keyboardType: TextInputType.text,
                        labelText: "Last Name",
                        controller:
                            _registrationcontroller.bvnLastnameController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: AppString.latoFontStyle,
                                color: Colors.black45),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Last name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: "*565*0#",
                              );
                              await launchUrl(launchUri);
                              if (!await launchUrl(launchUri))
                                throw 'Could not launch $launchUri';
                            },
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    text: "Can’t remember your BVN? Dial  ",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppString.latoFontStyle,
                                      fontSize: 12,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: "*565*0#",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: kPrimaryColorLight)),
                                      TextSpan(
                                        text: "  on your phone",
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppString.latoFontStyle,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ])),
                          )),
                      const SizedBox(
                        height: 20,
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
                        height: 20,
                      ),
                      ButtonWidget(
                          onPressed: () {
                            _registrationcontroller.collectedBVNDetails();
                          },
                          buttonText: AppString.continueBtnTxt,
                          height: 48,
                          width: double.maxFinite),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
