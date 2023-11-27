import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../widget/bottom_sheet.dart';
import 'bvn.dart';

class CollectUserBankDetails extends StatefulWidget {
  const CollectUserBankDetails({Key? key}) : super(key: key);

  @override
  State<CollectUserBankDetails> createState() => _CollectUserBankDetailsState();
}

class _CollectUserBankDetailsState extends State<CollectUserBankDetails> {
  @override
  Widget build(BuildContext context) {
    ;
    final _registrationController = Get.put(RegistrationController());

    void showBankBottomSheet(BuildContext context) {
      MyBottomSheet().showDismissibleBottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Supported Banks",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppString.latoFontStyle),
                )),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        _registrationController.supportedBanks!.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              _registrationController.selectBank(index);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _registrationController
                                        .supportedBanks![index].name!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  _registrationController.selectedBank ==
                                          _registrationController
                                              .supportedBanks![index].name
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
                        },
                      )
                    ]),
              ),
            ),
          ],
        ),
      );
    }

    // void showBankDropDown(){
    //   DropDownState(
    //     DropDown(
    //       submitButtonText: "Done",
    //       searchHintText: "Search",
    //       bottomSheetTitle: "Select Bank",
    //       searchBackgroundColor: Colors.black12,
    //       dataList: _withdrawalController.banks,
    //       selectedItems: (List<dynamic> selectedList) {
    //         print(selectedList.toString());
    //       },
    //       selectedItem: (String selected) {
    //         setState(() {
    //           _withdrawalController.selectedBank = selected;
    //         });
    //       },
    //       enableMultipleSelection: false,
    //       searchController: _withdrawalController.searchTextEditingController,
    //     ),
    //   ).showModal(context);
    // }
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: _registrationController.scaffoldKeyCollectBankDetail,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Bank Account",
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
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _registrationController.formKeyCollectBankDetails,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.8,
                                minHeight: 50),
                            child: Text(
                              "Kindly provide one of your bank accounts that can receive the money.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontFamily: AppString.latoFontStyle,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        FormFieldWidget(
                          controller: _registrationController.bankAccountName,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black45,
                            size: 25,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          labelText: "Bank Account Name",
                          validator: (String? value) {
                            String pattern =
                                r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)";
                            RegExp regExp = RegExp(pattern);
                            if (value?.isEmpty ?? true) {
                              return 'This field is required';
                            } else if (!regExp.hasMatch(value!)) {
                              return 'Please enter valid Full name';
                            }
                            return null;
                          },
                          labelStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              fontFamily: AppString.latoFontStyle),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 45,
                          width: double.maxFinite,
                          padding: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.7),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance,
                                color: Colors.black45,
                              ),
                              Expanded(
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent)),
                                  onPressed: () {
                                    showBankBottomSheet(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _registrationController.selectedBank ??
                                            "Name of your Bank",
                                        style: TextStyle(
                                            color: _registrationController
                                                            .selectedBank ==
                                                        null ||
                                                    _registrationController
                                                            .selectedBank ==
                                                        "Name of your bank"
                                                ? Colors.black45
                                                : Colors.black87,
                                            fontSize: 14,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down,
                                          color: Colors.black45)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormFieldWidget(
                          controller: _registrationController.bankAccountNumber,
                          prefixIcon: Icon(
                            Icons.pin,
                            color: Colors.black45,
                            size: 25,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          labelText: "Bank Account Number",
                          validator: (value) => value!.isEmpty
                              ? "Please enter Account Number"
                              : null,
                          labelStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              fontFamily: AppString.latoFontStyle),
                        ),
                        // const SizedBox(height: 25,),
                        //
                        // Container(height: 67, width: double.maxFinite,
                        //   padding: EdgeInsets.only(left: 8.0),
                        //   decoration: BoxDecoration(border: Border.all(color: kPrimaryColorLight, width: 0.7), borderRadius: BorderRadius.circular(15)),
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.branding_watermark, color: Colors.black45,),
                        //       Expanded(
                        //         child: TextButton(
                        //           style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                        //           onPressed: (){},
                        //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(_registrationController.bankCCVCode ?? "CCV Code",
                        //                 style: TextStyle(color: _registrationController.bankCCVCode == null || _registrationController.bankCCVCode == "CCV Code" ?
                        //                 Colors.black45 : Colors.black87, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                        //
                        //               const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // FormFieldWidget(
                        //   controller:
                        //       _registrationController.validateBVNController,
                        //   prefixIcon: Icon(
                        //     Icons.pin,
                        //     color: Colors.black45,
                        //     size: 25,
                        //   ),
                        //   textInputAction: TextInputAction.next,
                        //   keyboardType: TextInputType.text,
                        //   labelText: "Bank Verification Number (BVN)",
                        //   validator: (value) =>
                        //       value!.isEmpty ? "Please enter BVN" : null,
                        //   labelStyle: const TextStyle(
                        //       color: Colors.black45,
                        //       fontSize: 14,
                        //       fontFamily: AppString.latoFontStyle),
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock_outlined,
                              color: kPrimaryColorLight,
                              size: 25,
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
                                    fontFamily: AppString.latoFontStyle,
                                    fontSize: 14,
                                    color: Colors.black45,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                            onPressed: () {
                              if (_registrationController
                                      .bankAccountNumber.text.isNotEmpty &&
                                  _registrationController
                                      .bankAccountName.text.isNotEmpty &&
                                  _registrationController
                                      .selectedBank!.isNotEmpty) {
                                savedBankAccountName = _registrationController
                                    .bankAccountName.text
                                    .trim();
                                savedBankAccountNumber = _registrationController
                                    .bankAccountNumber.text
                                    .trim();
                                savedBankCode =
                                    _registrationController.bankCCVCode!;
                                savedBankName =
                                    _registrationController.selectedBank!;
                                Get.to(() => BvnVerificationScreen());
                              }
                            },
                            buttonText: "Save",
                            height: 48,
                            width: double.maxFinite),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
