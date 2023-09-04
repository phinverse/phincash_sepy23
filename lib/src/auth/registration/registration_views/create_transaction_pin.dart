import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/widget/pin_code_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(RegistrationController());
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                key: _controller.scaffoldKeyBvnScreen,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: gradientColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: Form(
                      key: _controller.formKeyBvnScreen,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    _controller.moveBackToVerifyOTPScreen();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                  )),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            AppString.securityText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                    fontFamily: AppString.latoFontStyle,
                                    fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.lock_outlined,
                                color: Colors.black45,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppString.storeCredentials,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontFamily: AppString.latoFontStyle),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(
                            AppString.createPin,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 14,
                                    fontFamily: AppString.latoFontStyle,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  minHeight: 50),
                              child: Text(
                                AppString.createPinMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontFamily: AppString.latoFontStyle,
                                        color: Colors.black45),
                              )),
                          const Spacer(
                            flex: 3,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 38.0),
                                child: PinCodeWidget(
                                  controller:
                                      _controller.transactionPINController,
                                  length: 4,
                                  onChanged: (value) {},
                                ),
                              )),
                          const Spacer(
                            flex: 2,
                          ),
                          ButtonWidget(
                              onPressed: () {
                                _controller.checkConnectionForCreatePin(
                                    contactList: _controller.contactMap);
                              },
                              buttonText: AppString.signUp,
                              height: 48,
                              width: double.maxFinite),
                          const Spacer(
                            flex: 9,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
