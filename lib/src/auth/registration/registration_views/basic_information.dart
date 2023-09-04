import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import 'about_you.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({Key? key}) : super(key: key);

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final _controller = Get.put(RegistrationController());

  Future<void> goToAboutYou() async {
    if (_controller.formKeyBasicInformation.currentState!.validate()) {
      _controller.formKeyBasicInformation.currentState!.save();
      Get.to(() => AboutYou());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                key: _controller.scaffoldKeyBasicInformation,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Basic Information",
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
                  key: _controller.formKeyBasicInformation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          // const Spacer(flex: 1,),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.2,
                                  minHeight: 10),
                              child: Text(
                                "Please use your personal information",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontFamily: AppString.latoFontStyle,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500),
                              )),
                          // const SizedBox(height: 20,),
                          // ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                          //     child: Text("Kindly provide the right answers to our questions to get better loan offers",
                          //       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                          const SizedBox(
                            height: 30,
                          ),
                          FormFieldWidget(
                            labelText: "First Name",
                            onChanged: (value) {
                              _controller.bvnFirstName = value;
                            },
                            controller: _controller.firstNameController,
                            validator: (value) => (value!.isEmpty
                                ? "Please enter your first name"
                                : null),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormFieldWidget(
                            labelText: "Middle Name",
                            onChanged: (value) {
                              _controller.bvnMiddleName = value;
                            },
                            controller: _controller.middleNameController,
                            validator: (value) => (value!.isEmpty
                                ? "Please enter your Middle name"
                                : null),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Text("The full name on your BVN account", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontSize: 20),),
                          // const SizedBox(height: 20,),
                          FormFieldWidget(
                            labelText: "Surname",
                            onChanged: (value) {
                              _controller.bvnSurName = value;
                            },
                            controller: _controller.surNameController,
                            validator: (value) => (value!.isEmpty
                                ? "Please enter your Surname"
                                : null),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormFieldWidget(
                            labelText: "E-mail",
                            onChanged: (value) {
                              _controller.bvnEmail = value;
                            },
                            controller: _controller.emailController,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!_controller.emailValidator
                                  .hasMatch(value)) {
                                return 'Please provide a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormFieldWidget(
                            labelText: "Phone Number",
                            controller: _controller.bvnPhoneNumberController,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle,
                                    color: Colors.black45),
                            onChanged: (value) {
                              // _controller.bvnPhoneNumber = _controller.phoneNumberController.text;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your PhoneNumber';
                              } else if (!_controller.phoneValidator
                                  .hasMatch(value)) {
                                return "Please provide a valid phoneNumber";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
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
                                width: 20,
                              ),
                              Text(
                                "Phincash security guarantee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Colors.black54,
                                        fontFamily: AppString.latoFontStyle),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                              onPressed: () {
                                goToAboutYou();
                              },
                              buttonText: "Let's begin",
                              height: 48,
                              width: double.maxFinite),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
