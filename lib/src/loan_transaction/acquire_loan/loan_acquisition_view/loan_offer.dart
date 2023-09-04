import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/controller/loan_acquisition_controller.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/loan_withdrawal_controller/withdrawal_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/custom_dialog.dart';

class LoanOffer extends StatefulWidget {
  const LoanOffer({Key? key}) : super(key: key);

  @override
  State<LoanOffer> createState() => _LoanOfferState();
}

class _LoanOfferState extends State<LoanOffer> {
  final format = new NumberFormat("#,##0", "en_US");
  final _loanAcquisitionController = Get.put(LoanAcquisitionController());
  final _transactionController = Get.put(TransactionController());
  final _withdrawalController = Get.put(WithdrawalController());
  bool? _acceptLoan = false;

  void showLoanAmountBottomSheet(BuildContext context) {
    MyBottomSheet().showDismissibleBottomSheet(
        context: context,
        height: 0.5.sh,
        children: [
          GetBuilder<LoanAcquisitionController>(
              init: LoanAcquisitionController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Loan Offer",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 20,
                          fontFamily: AppString.latoFontStyle,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    _loanAcquisitionController
                                .transactionController.loanPackages!.isEmpty ||
                            _loanAcquisitionController
                                    .transactionController.loanPackages ==
                                []
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetPath.noRecords),
                                Text(
                                  "No Loan Offer Available",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppString.latoFontStyle),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "They will appear once there’s any",
                                  style: TextStyle(
                                      color: Color(0xFFA6A6AA),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: AppString.latoFontStyle),
                                ),
                              ],
                            ))
                        : Column(
                            children: [
                              ...List.generate(
                                _loanAcquisitionController
                                    .transactionController.loanPackages!.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      _loanAcquisitionController
                                          .selectLoanPackages(index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 10.h, top: 30.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            MdiIcons.handCoinOutline,
                                            color: kPrimaryColor,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "₦ ${format.format(int.parse(_loanAcquisitionController.transactionController.loanPackages![index].amount.toString()))}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          _loanAcquisitionController
                                                      .selectedLoanAmount ==
                                                  _loanAcquisitionController
                                                      .transactionController
                                                      .loanPackages![index]
                                                      .amount
                                                      .toString()
                                              ? Container(
                                                  height: 18,
                                                  width: 18,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kPrimaryColor),
                                                  child: const Icon(
                                                    Icons.check,
                                                    size: 10,
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
                            ],
                          )
                  ],
                );
              })
        ]);
  }

  void showMyDialog() {
    MyDialog().showMyDialog(context, MediaQuery.of(context).size.height / 2,
        MediaQuery.of(context).size.width / 1.3, [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: kPrimaryColor,
                    size: 20.sp,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 73.h,
                  width: 73.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryColor, width: 3),
                      color: const Color(0xff081952)),
                  child: Center(
                      child: Icon(
                    Icons.warning_rounded,
                    color: kPrimaryColorLight,
                    size: 40.sp,
                  ))),
            ),
            Container(
              height: 40.h,
              width: 3.w,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sorry! You request cannot be granted",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Your Kyc is not verified. Please click the below button to verify your kyc",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            SizedBox(
              height: 18.h,
            ),
            ButtonWidget(
              onPressed: () {
                Get.back();
                _withdrawalController.verifyUser();
              },
              buttonText: "Verify KYC",
              height: 50.h,
              width: double.maxFinite,
              buttonColor: kPrimaryColor,
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String date = Jiffy(DateTime.now()).yMMMMEEEEd;
    return SafeArea(
        top: false,
        bottom: false,
        child: GetBuilder<LoanAcquisitionController>(
            init: LoanAcquisitionController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Loan Offer",
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
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20.sp,
                      )),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _acceptLoan == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "You are eligible for a loan with Phincash.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontFamily: AppString.latoFontStyle,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Kindly choose you loan details.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontFamily: AppString.latoFontStyle,
                                            color: Colors.black54),
                                  ),
                                ],
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Pay early in order to get higher loan amounts in future",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(height: _acceptLoan == false ? 30 : 10),
                        Container(
                          height: 67,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black45, width: 0.7),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {
                              showLoanAmountBottomSheet(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _loanAcquisitionController.selectedLoanAmount ==
                                        null
                                    ? Text(
                                        "Loan Amount",
                                        style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                      )
                                    : Text(
                                        "₦ ${format.format(int.parse(_loanAcquisitionController.selectedLoanAmount!))}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: ""),
                                      ),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.black45)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 67,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black45, width: 0.7),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _loanAcquisitionController
                                            .selectedRepaymentPeriod ==
                                        null
                                    ? Text(
                                        "Repayment Period",
                                        style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "${_loanAcquisitionController.selectedRepaymentPeriod} Days",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: ""),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "(${_loanAcquisitionController.loanInterestRate} %)",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                    AppString.latoFontStyle),
                                          ),
                                        ],
                                      ),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.black45)
                              ],
                            ),
                          ),
                        ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : SizedBox(
                                height: 20.h,
                              ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(20.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loan amount",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.black45,
                                                fontFamily:
                                                    AppString.latoFontStyle),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "₦ ${format.format(int.parse(_loanAcquisitionController.selectedLoanAmount!))}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontFamily: "",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Interest rate",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black45,
                                                        fontFamily: AppString
                                                            .latoFontStyle,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${_loanAcquisitionController.loanInterestRate} %",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black,
                                                        fontFamily: AppString
                                                            .latoFontStyle,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Loan duration",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black45,
                                                        fontFamily: AppString
                                                            .latoFontStyle,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${_loanAcquisitionController.selectedRepaymentPeriod} Days",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black,
                                                        fontFamily: AppString
                                                            .latoFontStyle,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : const SizedBox(
                                height: 20,
                              ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(20.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loan amount",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.black45,
                                                fontFamily:
                                                    AppString.latoFontStyle,
                                                fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "₦ ${format.format(int.parse(_loanAcquisitionController.selectedLoanAmount!))}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontFamily: "",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.black45,
                                                fontFamily:
                                                    AppString.latoFontStyle,
                                                fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : const SizedBox(
                                height: 20,
                              ),
                        _acceptLoan == false
                            ? const SizedBox()
                            : Container(
                                width: double.maxFinite,
                                height: 60,
                                color: const Color(0xFFF8F7FA),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.8,
                                            minHeight: 50),
                                        child: Text(
                                          "Failure to make repayment will lead to additional increase in interest rate and will in turn lead to penalty",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ),
                        SizedBox(height: _acceptLoan == false ? 50 : 10),
                        _acceptLoan == false
                            ? ButtonWidget(
                                onPressed: () {
                                  if (_loanAcquisitionController
                                          .selectedLoanAmount ==
                                      null) {
                                    FlushBarHelper(Get.context!).showFlushBar(
                                        "Please select a loan offer");
                                  } else {
                                    setState(() {
                                      _acceptLoan = true;
                                    });
                                  }
                                },
                                buttonText: "Continue",
                                height: 48,
                                width: double.maxFinite)
                            : Column(
                                children: [
                                  ButtonWidget(
                                      onPressed: () {
                                        if (_transactionController
                                                .userPersonalData
                                                ?.user
                                                .kycVerificationStatus ==
                                            "unverified") {
                                          showMyDialog();
                                          FlushBarHelper(Get.context!).showFlushBar(
                                              "Please, verify your Kyc is Unverified");
                                        } else {
                                          _loanAcquisitionController
                                              .AcquireLoanPackage();
                                        }
                                      },
                                      buttonText: "Accept Offer",
                                      height: 48,
                                      width: double.maxFinite),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ButtonWidget(
                                        onPressed: () {
                                          Get.offAll(() => const HomeScreen());
                                        },
                                        buttonTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Color(0xffFE8668),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                        buttonColor: Colors.transparent,
                                        buttonText: "Reject Offer",
                                        height: 48,
                                        width: double.maxFinite),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
