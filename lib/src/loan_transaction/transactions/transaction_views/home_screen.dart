import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/intro_screens/onboarding_screen.dart';
import 'package:phincash/repository/cached_data.dart';
import 'package:phincash/src/auth/login/login_views/login.dart';
import 'package:phincash/src/loan_transaction/models/dummy_models.dart';
import 'package:phincash/src/loan_transaction/repay_loan/views/loan_details.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/view_all_transactions.dart';
import 'package:phincash/src/loan_transaction/transactions/widget/carousel_widget.dart';
import 'package:phincash/src/loan_transaction/widgets/transaction_tile.dart';
import 'package:phincash/src/preferences/help_and_support/support.dart';
import 'package:phincash/src/preferences/profile_preferences/profile_screen.dart';
import 'package:phincash/src/preferences/settings_options/confirm_previous_pin.dart';
import 'package:phincash/src/preferences/settings_options/delete_bank_account.dart';
import 'package:phincash/src/preferences/settings_options/fag_screen.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/reposiroty.dart';
import 'package:phincash/src/loan_transaction/transactions/helpers/database_helper.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/asset_path.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/count_down.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../information/views/notification_feedback/notifications.dart';
import '../../../information/views/privacy_policy/policy_policy_screen.dart';
import '../../acquire_loan/loan_acquisition_view/loan_offer.dart';
import '../../widgets/profile_tile_widget.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(TransactionController());
  final amountController = TextEditingController();
  final List _carouselItems = DummyData.carouselHeadings;
  final List _profileTitle = DummyData.profileTitle;
  final amountFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  /*/ addition starts ================================
  final Repository _repository = Repository(DatabaseHelper());
  late Isolate _isolate;
  bool _isUploading = false;
  //addition ends =========================== */
  int _current = 0;
  Widget _screens() {
    if (_selectedIndex == 0) {
      return _homeScreen();
    } else if (_selectedIndex == 1) {
      return _history();
    } else {
      return _profile();
    }
  }

  showMyDialog() {
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
                    size: 20.w,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 73,
                  width: 73,
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
              width: 3,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Incomplete Registration!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "To be able to make transaction, we have to verify your bank details. Click the accept button to verify and complete your registration",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 18,
            ),
            ButtonWidget(
              onPressed: () {
                Get.back();
                _controller.verifyUser();
              },
              buttonText: "Accept",
              height: 50,
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
  void initState() {
    // Timer(
    //   const Duration(seconds: 5),
    //   () {
    //     if (_controller.isKycPending == true) {
    //       showMyDialog();
    //     } else {
    //       null;
    //     }
    //   },
    // );
    super.initState();
    // Check if contacts are uploaded, and start background upload if not
    //checkContactsUploaded();
  }
/*
  Future<void> checkContactsUploaded() async {
    final isUploaded = await _repository.areContactsUploaded();
    if (!isUploaded) {
      // Contacts are not uploaded, start background upload
      startBackgroundUpload();
    }
  }

  Future<void> startBackgroundUpload() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(backgroundUpload, receivePort.sendPort);

    receivePort.listen((dynamic data) {
      if (data is String) {
        // Debug print the status from the background isolate
        print(data);
        if (data == 'Upload completed.') {
          setState(() {
            _isUploading = false;
          });
        }
      }
    });
  }

  static void backgroundUpload(SendPort sendPort) async {
    final repository = Repository(DatabaseHelper());
    // Implement your contact upload logic here

    // Simulate a delay to mimic the upload process
    await Future.delayed(Duration(seconds: 3));

    // Mark contacts as uploaded in the database
    await repository.markContactsAsUploaded();

    // Send a message back to the main isolate
    sendPort.send('Upload completed.');
  }

  @override
  void dispose() {
    // Terminate the background isolate when the screen is disposed
    _isolate.kill();
    super.dispose();
  }
*/
  void showAmountBottomSheet() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 1.8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: amountFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    AssetPath.pngSplash,
                                    height: 100.h,
                                    width: 100.w,
                                  ) //SvgPicture.asset(AssetPath.logoStamp, theme: const SvgTheme(fontSize: 25),),
                                  ),
                              Text(
                                "Please enter amount proceed",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontFamily: AppString.latoFontStyle,
                                        fontSize: 14),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              FormFieldWidget(
                                onChanged: (value) {
                                  _controller.amount = amountController.text;
                                },
                                controller: amountController,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    "₦ ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 20,
                                            fontFamily: AppString.latoFontStyle,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                labelText: "Enter an amount",
                                labelStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                    fontFamily: AppString.latoFontStyle),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 20.h,
                              ),
                              ButtonWidget(
                                  onPressed: () {
                                    _controller.amount == null ||
                                            _controller.amount!.length < 2
                                        ? FlushBarHelper(Get.context!)
                                            .showFlushBar(
                                                "Please Enter a Valid Amount")
                                        : _controller.creditWalletNow();
                                  },
                                  buttonText: AppString.continueBtnTxt,
                                  height: 48.h,
                                  width: double.maxFinite),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      isScrollControlled: true,
    );
  }

  _navigator(int index) {
    if (index == 0) {
      Get.to(() => const SupportAndHelp());
    } else if (index == 1) {
      Get.to(() => const TermsAndConditions());
    } else if (index == 2) {
      Get.to(() => const FaqScreen());
    } else if (index == 3) {
      Get.to(() => const ConfirmPreviousPin());
    } else if (index == 4) {
      Get.to(() => const DeleteBankAccount());
    } else if (index == 5) {}
  }

  Widget _history() {
    final format = new NumberFormat("#,##0", "en_US");
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _controller.loanHistory!.isEmpty ||
                    _controller.loanHistory == [] ||
                    _controller.loanHistory == null
                ? Container(
                    padding: const EdgeInsets.all(40),
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetPath.noRecords,
                          height: 150.h,
                          width: 150.w,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "No history yet",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppString.latoFontStyle),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "They will appear once there’s any",
                          style: TextStyle(
                              color: Color(0xFFA6A6AA),
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              fontFamily: AppString.latoFontStyle),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ...List.generate(_controller.loanHistory!.length,
                            (index) {
                          final date =
                              _controller.loanHistory![index].createdAt;
                          final amount =
                              _controller.loanHistory![index].amount.toString();
                          final status = _controller.loanHistory![index].status;
                          String convertedDate = Jiffy(date).yMMMMEEEEd;
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: ExpandableNotifier(
                              // <-- Provides ExpandableController to its children
                              child: Column(
                                children: [
                                  ScrollOnExpand(
                                    scrollOnExpand: true,
                                    scrollOnCollapse: true,
                                    child: ExpandablePanel(
                                      theme: const ExpandableThemeData(
                                        headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                        tapBodyToCollapse: true,
                                      ),
                                      header: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("DATE",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily: AppString
                                                                .latoFontStyle)),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  convertedDate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: AppString
                                                              .latoFontStyle),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("AMOUNT",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily: AppString
                                                                .latoFontStyle)),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "N ${format.format(int.parse(amount))}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: AppString
                                                              .latoFontStyle),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("STATUS",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily: AppString
                                                                .latoFontStyle)),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  status!.toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      collapsed: SizedBox(
                                        height: 20.h,
                                      ),
                                      expanded: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Container(
                                              width: double.maxFinite,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColorLight,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                  child: Text(
                                                "Loan Transactions",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontFamily: AppString
                                                            .latoFontStyle,
                                                        fontSize: 10),
                                              ))),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "DESCRIPTION",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          fontSize: 12),
                                                ),
                                                Text(
                                                  "DATE",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          fontSize: 12),
                                                ),
                                                Text(
                                                  "AMOUNT",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ..._controller
                                              .loanHistory![index].transactions!
                                              .map((elements) {
                                            return GetBuilder<
                                                    TransactionController>(
                                                init: TransactionController(),
                                                builder: (controller) {
                                                  final date = Jiffy(
                                                          elements.completedAt)
                                                      .yMMMMEEEEd;
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 3),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          elements.description!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontFamily:
                                                                      AppString
                                                                          .latoFontStyle,
                                                                  fontSize: 10),
                                                        ),
                                                        Text(
                                                          date,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontFamily:
                                                                      AppString
                                                                          .latoFontStyle,
                                                                  fontSize: 10),
                                                        ),
                                                        Text(
                                                          "N ${format.format(int.parse(elements.amount.toString()))}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontFamily:
                                                                      AppString
                                                                          .latoFontStyle,
                                                                  fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }),
                                        ],
                                      ),
                                      builder: (_, collapsed, expanded) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          child: Expandable(
                                            collapsed: collapsed,
                                            expanded: expanded,
                                            theme: const ExpandableThemeData(
                                                crossFadePoint: 0),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
          );
        });
  }

  _showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No", style: TextStyle(color: kPrimaryColor)),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () async {
        var cachedData = CachedData();
        await cachedData.cacheLoginStatus(isLoggedIn: false);
        Get.back();
        Get.offUntil(GetPageRoute(page: () => const Login()),
            (Route<dynamic> route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _profile() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const ProfileScreen());
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), spreadRadius: 4,
                  offset: const Offset(0, 0.01), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
              child: Center(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppString.welcomeUser} ${_controller.userPersonalData?.user.firstName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 14,
                                  fontFamily: AppString.latoFontStyle,
                                  fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "My Profile",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 12,
                                  fontFamily: AppString.latoFontStyle,
                                  color: Colors.black45),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 7,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ...List.generate(_profileTitle.length, (index) {
          return InkWell(
            onTap: () {
              _navigator(index);
            },
            child: ProfileTileWidget(
              icon: _profileTitle[index]['icons'],
              title: Text(
                _profileTitle[index]["title"],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14, fontFamily: AppString.latoFontStyle),
              ),
              destinationIcon: Icons.arrow_forward_ios_rounded,
            ),
          );
        }),
        InkWell(
          onTap: () {
            Get.back();
            _showAlertDialog(context);
          },
          child: ProfileTileWidget(
            icon: Icons.power_settings_new,
            iconColor: Colors.red,
            title: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14, fontFamily: AppString.latoFontStyle),
            ),
            destinationIcon: Icons.arrow_forward_ios_rounded,
          ),
        ),
      ],
    );
  }

  Widget _homeScreen() {
    final format = new NumberFormat("#,##0", "en_US");
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (controller) {
          // DateTime date1 = new DateTime.now();
          // DateTime date2 = DateTime(2021, 1, 1);
          // print(date1.difference(date2).inDays);
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), spreadRadius: 4,
                        offset:
                            const Offset(0, 0.01), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: Row(
                      children: [
                        Text(
                          "${AppString.welcomeUser} ${_controller.userPersonalData?.user.firstName ?? ""}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 20,
                                  fontFamily: AppString.latoFontStyle,
                                  fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.to(() => const SupportAndHelp());
                          },
                          icon: const Icon(
                            Icons.help_outline_outlined,
                            color: Colors.black45,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // _controller.notifications == null || _controller.notifications!.isEmpty ?   FlushBarHelper(Get.context!).showFlushBar("You currently Have no Notification", messageColor: Colors.red,
                            //     icon: Icon(Icons.error_outline, size: 20, color: Colors.red,), color: Colors.white, borderColor: Colors.red) :
                            Get.to(() => const NotificationScreen());
                          },
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Colors.black45,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                _controller.userPersonalData?.user.hasLoanOverdue == false &&
                        _controller.userPersonalData?.user.hasUnpaidLoan ==
                            false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 24.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    AppString.cashLoan,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      _controller.amountVisibility == true
                                          ? Text(
                                              "N ${format.format(int.parse(_controller.userPersonalData!.user.mainWalletAmount.toString()))}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: AppString
                                                          .latoFontStyle,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            )
                                          : Text(
                                              "* ******",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: AppString
                                                          .latoFontStyle,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                      IconButton(
                                          onPressed: () {
                                            _controller
                                                .toggleAmountVisibility();
                                          },
                                          icon: Icon(
                                            _controller.amountVisibility ==
                                                    false
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                    ],
                                  ),
                                  Text(
                                    AppString.needLoan,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: AppString.latoFontStyle,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const Spacer(),
                                  Text(
                                    AppString.applyForLoan,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily:
                                                AppString.latoFontStyle),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    _controller.loanPackages!.isEmpty ||
                                            _controller.loanPackages! == [] ||
                                            _controller.loanPackages == null
                                        ? FlushBarHelper(Get.context!).showFlushBar(
                                            "There are currently no loan packages for you. Try later!")
                                        : Get.to(() => const LoanOffer());
                                  },
                                  child: Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Center(
                                                child: Text(
                                          AppString.applyNow,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      const Color(0xFF0C2842),
                                                  fontWeight: FontWeight.w700),
                                        ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )
                    : _controller.userPersonalData?.user.hasLoanOverdue ==
                                false &&
                            _controller.userPersonalData?.user.hasUnpaidLoan ==
                                true &&
                            _controller
                                    .userPersonalData?.user.currentLoanStatus ==
                                'approved'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 24.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppString.cashLoan,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: AppString
                                                        .latoFontStyle),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height: 28,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                AppString.approved,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          _controller.amountVisibility == true
                                              ? Text(
                                                  "N ${format.format(int.parse(_controller.userPersonalData!.user.mainWalletAmount.toString()))}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              : Text(
                                                  "* ******",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: AppString
                                                              .latoFontStyle,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                          IconButton(
                                              onPressed: () {
                                                _controller
                                                    .toggleAmountVisibility();
                                              },
                                              icon: Icon(
                                                _controller.amountVisibility ==
                                                        false
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.white,
                                                size: 15,
                                              )),
                                        ],
                                      ),
                                      Text(
                                        AppString.pendingDisbursemntHeader,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily:
                                                    AppString.latoFontStyle,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        AppString.pendingDisbursemnt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppString.latoFontStyle,
                                                overflow: TextOverflow.clip),
                                      ),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 10,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          )
                        : _controller.userPersonalData?.user.hasLoanOverdue ==
                                    false &&
                                _controller
                                        .userPersonalData?.user.hasUnpaidLoan ==
                                    true &&
                                _controller.userPersonalData?.user
                                        .mainWalletAmount !=
                                    null &&
                                _controller.userPersonalData?.user
                                        .currentLoanStatus ==
                                    'disbursed'
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 24.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppString.cashLoan,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: AppString
                                                            .latoFontStyle),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  height: 28,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF30D6B0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                      child: Text(
                                                    AppString.disbursed,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  )),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              _controller.amountVisibility ==
                                                      true
                                                  ? Text(
                                                      "N ${format.format(int.parse(_controller.userPersonalData!.user.mainWalletAmount.toString()))}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily: AppString
                                                                  .latoFontStyle,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )
                                                  : Text(
                                                      "* ******",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily: AppString
                                                                  .latoFontStyle,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                              IconButton(
                                                  onPressed: () {
                                                    _controller
                                                        .toggleAmountVisibility();
                                                  },
                                                  icon: Icon(
                                                    _controller.amountVisibility ==
                                                            false
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.white,
                                                    size: 15,
                                                  )),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _controller.index == null &&
                                                          _controller
                                                                  .loanDetails ==
                                                              null
                                                      ? FlushBarHelper(
                                                              Get.context!)
                                                          .showFlushBar(
                                                              "You have no Loan Disbursed")
                                                      : Get.to(
                                                          () => LoanDetails(
                                                                isLoanOverDue:
                                                                    false,
                                                              ));
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                          child: Text(
                                                        AppString.withDraw,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 10,
                                                                color: const Color(
                                                                    0xFF0C2842),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppString.loanOverDue,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: AppString
                                                            .latoFontStyle),
                                              ),
                                              DaysCountDown(
                                                due: DateTime.parse(
                                                  _controller
                                                      .userPersonalData
                                                      ?.user
                                                      .secondaryWalletDueAt,
                                                ),
                                                finishedText:
                                                    "Your Loan is OverDue",
                                              )
                                              // CountDownText(
                                              //   due: DateTime.parse(_controller
                                              //       .userPersonalData
                                              //       ?.user
                                              //       .secondaryWalletDueAt),
                                              //   finishedText:
                                              //       "Your Loan is OverDue",
                                              //   showLabel: true,
                                              //   longDateName: true,
                                              //   daysTextLong: " Days ",
                                              //   hoursTextLong: " Hours ",
                                              //   minutesTextLong: " Minutes ",
                                              //   secondsTextLong: " Seconds ",
                                              //   style: TextStyle(
                                              //       color: Colors.white,
                                              //       fontSize: 12),
                                              // )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : _controller.userPersonalData?.user
                                            .hasLoanOverdue ==
                                        true &&
                                    _controller.userPersonalData?.user
                                            .hasUnpaidLoan ==
                                        true
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 24.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppString.cashLoan,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily: AppString
                                                                .latoFontStyle),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      height: 28,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              7,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            AppString.overDue,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  _controller.amountVisibility ==
                                                          true
                                                      ? Text(
                                                          "N ${format.format(int.parse(_controller.userPersonalData!.user.mainWalletAmount.toString()))}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      AppString
                                                                          .latoFontStyle,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        )
                                                      : Text(
                                                          "* ******",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      AppString
                                                                          .latoFontStyle,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                  IconButton(
                                                      onPressed: () {
                                                        _controller
                                                            .toggleAmountVisibility();
                                                      },
                                                      icon: Icon(
                                                        _controller.amountVisibility ==
                                                                false
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.white,
                                                        size: 15,
                                                      )),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _controller.index ==
                                                                  null &&
                                                              _controller
                                                                      .loanDetails ==
                                                                  null
                                                          ? FlushBarHelper(
                                                                  Get.context!)
                                                              .showFlushBar(
                                                                  "You have no Loan Disbursed")
                                                          : Get.to(
                                                              () => LoanDetails(
                                                                    isLoanOverDue:
                                                                        true,
                                                                  ));
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF0C2842),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            AppString
                                                                .viewDetails,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppString.loanOverDue,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily: AppString
                                                                .latoFontStyle),
                                                  ),

                                                  DaysCountDown(
                                                    due: DateTime.tryParse(
                                                        _controller
                                                                .userPersonalData
                                                                ?.user
                                                                .secondaryWalletDueAt ??
                                                            ""),
                                                    finishedText:
                                                        "Your Loan is OverDue",
                                                  )

                                                  // CountDownText(
                                                  //   due: DateTime.parse(_controller
                                                  //       .userPersonalData
                                                  //       ?.user
                                                  //       .secondaryWalletDueAt,) ,
                                                  //   finishedText:
                                                  //       "You Loan is OverDue",
                                                  //   showLabel: true,
                                                  //   longDateName: true,
                                                  //   daysTextLong: " DAYS ",
                                                  //   hoursTextLong: " HOURS ",
                                                  //   minutesTextLong: " MINUTES ",
                                                  //   secondsTextLong: " SECONDS ",
                                                  //   style: TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontSize: 12),
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 10),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: _controller.isFetchingTransaction == true
                        ? Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: WillPopScope(
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              AssetPath.loading,
                                              theme:
                                                  const SvgTheme(fontSize: 25),
                                              height: 25,
                                              width: 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.transparent,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.9,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onWillPop: () => Future.value(false)),
                          )
                        : _controller.isFetchingTransactionHasError == true
                            ? Container(
                                padding: const EdgeInsets.all(40),
                                height: MediaQuery.of(context).size.height / 3,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AssetPath.error,
                                        height: 80),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      _controller.error ??
                                          "Oh! Something’s Not Right",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppString.latoFontStyle),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "We Could’t Process Your Loan Application",
                                      style: TextStyle(
                                          color: Color(0xFFA6A6AA),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: AppString.latoFontStyle),
                                    ),
                                  ],
                                ),
                              )
                            : _controller.transactionHistory!.isEmpty ||
                                    _controller.transactionHistory == [] ||
                                    _controller.transactionHistory == null
                                ? Container(
                                    padding: const EdgeInsets.all(40),
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              AppString.transactions,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 14,
                                                      fontFamily: AppString
                                                          .latoFontStyle),
                                            )),
                                        const Spacer(),
                                        SvgPicture.asset(
                                          AssetPath.noTransaction,
                                          height: 80,
                                          theme: const SvgTheme(fontSize: 25),
                                        ),
                                        const Spacer(),
                                        Text(
                                          AppString.noTransactionYet,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      AppString.latoFontStyle),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          AppString.transactionWillAppear,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      AppString.latoFontStyle,
                                                  color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                AppString.transactions,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black45,
                                                        fontSize: 14,
                                                        fontFamily: AppString
                                                            .latoFontStyle),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ViewAllTransaction());
                                                  },
                                                  child: Text(
                                                    AppString.viewAll,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize: 14,
                                                            fontFamily: AppString
                                                                .latoFontStyle),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                              child: SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            controller: _scrollController,
                                            child: Column(
                                              children: [
                                                ...List.generate(
                                                    _controller.transactionHistory!
                                                                .length >
                                                            3
                                                        ? 3
                                                        : _controller
                                                            .transactionHistory!
                                                            .length, (index) {
                                                  String date = Jiffy(_controller
                                                          .transactionHistory?[
                                                              index]
                                                          .createdAt)
                                                      .yMMMMd;
                                                  return TransactionTile(
                                                    padding: 0.0,
                                                    image: SvgPicture.asset(
                                                      AssetPath.transIcon,
                                                      theme: const SvgTheme(
                                                          fontSize: 25),
                                                    ),
                                                    title: Text(
                                                        _controller
                                                            .transactionHistory![
                                                                index]
                                                            .description!,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    AppString
                                                                        .latoFontStyle)),
                                                    subTitle: Text(date,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    AppString
                                                                        .latoFontStyle,
                                                                color: Colors
                                                                    .black45)),
                                                    amount: Text(
                                                      "N ${format.format(int.parse(_controller.transactionHistory![index].amount!.toString()))}",
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily: AppString
                                                                  .latoFontStyle),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          )),
                                        ]),
                                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: CarouselSlider(
                          options: CarouselOptions(
                              scrollDirection: Axis.vertical,
                              height: MediaQuery.of(context).size.height / 8,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          items: List.generate(_carouselItems.length, (index) {
                            return CarouselWidget(
                              imagePath: _carouselItems[index]["image_path"],
                              title: _carouselItems[index]["title"],
                              message: _carouselItems[index]["message"],
                              children: [
                                ..._carouselItems.map((x) {
                                  int index = _carouselItems.indexOf(x);
                                  return Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index
                                          ? const Color(0xFF70B2E2)
                                          : const Color(0xFFD3EDFF),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }))),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }

  CachedData cachedData = CachedData();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    Widget cancelButton = TextButton(
      child: const Text(
        "NO",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "YES",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        cachedData.cacheLoginStatus(isLoggedIn: false).whenComplete(() {
          Get.offAll(() => const OnBoardingScreen());
        });
        // if (Platform.isAndroid) {
        //   SystemNavigator.pop();
        // } else if (Platform.isIOS) {
        //   exit(0);
        // }
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Do you want to exit app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return (await showDialog(
          context: context,
          builder: (context) => alert,
        )) ??
        false;
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<TransactionController>(
          init: TransactionController(),
          builder: (controller) {
            if (controller.isUserDataUpdated.value) {
              return Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: _selectedIndex == 1
                      ? Text(
                          "Loan History",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                        )
                      : const SizedBox(),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                ),
                body: WillPopScope(child: _screens(), onWillPop: _onWillPop),
                bottomNavigationBar: BottomNavigationBar(
                    selectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppString.latoFontStyle,
                        fontSize: 14),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: AppString.latoFontStyle, fontSize: 14),
                    currentIndex: _selectedIndex,
                    fixedColor: Theme.of(context).primaryColor,
                    onTap: _onItemTapped,
                    backgroundColor: Colors.white,
                    elevation: 3,
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 0
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.home_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 1
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.history,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'History'),
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 2
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'Profile'),
                    ]),
              );
            } else {
              return Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: _selectedIndex == 1
                      ? Text(
                          "Loan History",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                        )
                      : const SizedBox(),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                ),
                body: Center(child: CircularProgressIndicator()),
                bottomNavigationBar: BottomNavigationBar(
                    selectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppString.latoFontStyle,
                        fontSize: 14),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: AppString.latoFontStyle, fontSize: 14),
                    currentIndex: _selectedIndex,
                    fixedColor: Theme.of(context).primaryColor,
                    onTap: _onItemTapped,
                    backgroundColor: Colors.white,
                    elevation: 3,
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 0
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.home_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 1
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.history,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'History'),
                      BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: _selectedIndex == 2
                                        ? kPrimaryColorLight
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          label: 'Profile'),
                    ]),
              );
            }
          }),
    );
  }
}
