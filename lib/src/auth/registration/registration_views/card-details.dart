import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/src/auth/registration/registration_views/emergency_contact.dart';
import 'package:phincash/src/auth/registration/registration_views/selfie_page.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(RegistrationController());
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<RegistrationController>(
          init: RegistrationController(),
          builder: (controller) {
            return Scaffold(
              //key: _controller.scaffoldKeyBvnScreen,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Add Card",
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
                key: _controller.formKeyCardScreen,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => const EmergencyContact());
                            },
                            child: Text(AppString.skip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 16,
                                        fontFamily: AppString.latoFontStyle,
                                        fontWeight: FontWeight.w700)),
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                              minHeight: 10),
                          child: Text(
                            "Enter your card details.",
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
                        labelText: "Name",
                        controller: _controller.bvnController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: AppString.latoFontStyle,
                                color: Colors.black45),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Card Name';
                          } else if (value.length < 9) {
                            return "Enter a valid card Name.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      FormFieldWidget(
                        keyboardType: TextInputType.number,
                        labelText: "Card Number",
                        controller: _controller.bvnController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: AppString.latoFontStyle,
                                color: Colors.black45),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your card Number';
                          } else if (value.length < 9) {
                            return "Enter a valid card Number.";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormFieldWidget(
                              keyboardType: TextInputType.number,
                              labelText: "Expiry Date",
                              controller: _controller.bvnController,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your card Expiry Date';
                                } else if (value.length < 9) {
                                  return "Enter a valid card Expiry Date.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: FormFieldWidget(
                              keyboardType: TextInputType.number,
                              labelText: "CVV",
                              controller: _controller.bvnController,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black45),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your card CVV';
                                } else if (value.length < 9) {
                                  return "Enter a valid card CVV.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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
                            // _controller.checkConnectionForValidateBVN();

                            Get.off(
                                () => CameraApp(id: DateTime.now().toString()));
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
