import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/repository/cached_data.dart';
import 'package:phincash/src/auth/login/login_views/login.dart';
import 'package:phincash/src/auth/models/user_personal_data.dart';
import 'package:phincash/src/information/model/notification_model.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/model/available_loan_package_model.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/models/bank_account_model.dart';
import 'package:phincash/src/loan_transaction/transactions/models/faq_response_data.dart';
import 'package:phincash/src/loan_transaction/transactions/models/repayment_link_response_model.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import 'package:phincash/src/loan_transaction/transactions/models/loan_details_model.dart';
import 'package:phincash/src/loan_transaction/transactions/models/loan_history_model.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../services/dio_services/dio_services.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';
import '../../../auth/registration/registration_model/verify_user_data_model.dart';
import '../models/transaction_history_model.dart';
import '../transaction_views/webview_page.dart';

import 'dart:convert';

class TransactionController extends GetxController {
  CachedData cachedData = CachedData();
  var isUserDataUpdated = false.obs;
  bool? isFetchingTransaction;
  bool? isFetchingTransactionHasError;
  bool? isFetchingLoanHistory;
  bool? isFetchingLoanHistoryHasError;
  bool? isFetchingBankAccount;
  bool? isFetchingBankAccountHasError;
  bool? isFetchingAvailableLoanOffer;
  bool? isFetchingAvailableLoanOfferHasError;
  bool amountVisibility = false;
  String? error;
  int? loanAmount;
  String? amount;
  List<TransactionHistoryList>? transactionHistory =
      <TransactionHistoryList>[].obs;
  List<LoanHistory>? loanHistory = <LoanHistory>[].obs;
  List<BankAccount>? bankAccounts = <BankAccount>[].obs;
  List<LoanPackages>? loanPackages = <LoanPackages>[].obs;
  List<NotificationList>? notifications = <NotificationList>[].obs;
  List<FAQ>? faq = <FAQ>[].obs;
  UserPersonalData? userPersonalData;
  LoanDetailsModel? loanDetails;
  int? index;
  int? repaymentID;

  @override
  void onInit() {
    getUserPersonalData().then((_) => getUserData());
    getAllNotification();
    streamUserData();
    loanDetailAndHistory();
    getTransaction();
    getAvailableBankAccounts();
    getAvailableLoanPackages();
    streamNotification();
    getFAQ();
    update();
    super.onInit();
  }

  streamUserData() {
    Timer.periodic(Duration(days: 1), (timer) async {
      await getUserPersonalData().then((value) async {
        await getUserData();
      });
      update();
    });
  }

  Future<void> getUserPersonalData() async {
    try {
      await DioServices().getUserPersonalData().then((value) async {
        await cachedData.cacheUserPersonalData(
            userPersonalData: UserPersonalData.fromJson(value.data));
        isUserDataUpdated.value = true;
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  streamNotification() {
    Timer.periodic(Duration(hours: 5), (timer) {
      getAllNotification();
    });
  }

  verifyUser() async {
    try {
      ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
      await DioServices().verifyUserData().then((value) async {
        var response = VerifyUserData.fromJson(value.data);
        await _launchUrl(paymentLink: response.data!.verificationUrl!)
            .then((value) async {
          // await getUserPersonalData().then((value) async {
          //   ProgressDialogHelper().hideProgressDialog(Get.context!);
          //   Get.offAll(() => const HomeScreen());
          // SuccessDialog().showSuccessDialog(Get.context!);
          //});
        });
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  getFAQ() async {
    try {
      await DioServices().getFaq().then((value) {
        faq = FaqResponseData.fromJson(value.data).data;
        update();
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> creditWallet() async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .depositFundToWallet(amount: amount!.replaceAll(",", ""))
          .then((value) async {
        var response = RepaymentLinkModel.fromJson(value.data);
        await _launchUrl(paymentLink: response.data!.paymentLink!.toString())
            .then((value) async {
          await getUserPersonalData().then((value) async {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const HomeScreen());
          });
        });
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  loanDetailAndHistory() async {
    await getLoanHistory().then((value) async {
      if (loanHistory != null && loanHistory!.isNotEmpty) {
        index = loanHistory!.indexWhere((element) => element.status == "disbursed");
        if (index != -1) {
          repaymentID = loanHistory![index!].id;
          getLoanDetails();
        } else {
          // Handle the case where "disbursed" status is not found
          debugPrint("Not Disbursed");
        }
      } else {
        // Handle the case where loanHistory is null or empty
        debugPrint("loanHistory is null or empty");
      }
    });
  }

  getLoanDetails() async {
    try {
      await DioServices()
          .getLoanDetails(loanId: repaymentID.toString())
          .then((value) {
        loanDetails = LoanDetailsModel.fromJson(value.data);
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err) {
      throw err.toString();
    }
  }

  getAllNotification() async {
    try {
      await DioServices().getNotification().then((value) {
        notifications = NotificationModel.fromJson(value.data).data;
        update();
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err) {
      throw err.toString();
    }
  }

  creditWalletNow() {
    if (repaymentID == null) {
      FlushBarHelper(Get.context!).showFlushBar("You have no Loan Disbursed");
    } else {
      creditWallet();
    }
  }

  void LogUserOutWhenTokenExpires() async {
    await cachedData.cacheLoginStatus(isLoggedIn: false);
    Get.offAll(() => const Login());
    FlushBarHelper(Get.context!)
        .showFlushBar("Authentication Expired! Please Login",
            messageColor: Colors.red,
            icon: Icon(
              Icons.error_outline,
              size: 30,
              color: Colors.red,
            ),
            color: Colors.white,
            borderColor: Colors.red);
  }

  Future<void> _launchUrl({required String paymentLink}) async {
    //final Uri _url = Uri.parse(paymentLink);..
    Get.to(() => VerificationWebView(url: paymentLink));
    // if (!await launchUrl(
    //   _url,
    //   mode: LaunchMode.externalApplication,
    // )) {
    //   throw 'Could not launch $_url';
    // }
  }

  // repayLoan()async{
  //   ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
  //   try{
  //     await DioServices().repayLoan(loanId: repaymentID.toString()).whenComplete(()async{
  //       ProgressDialogHelper().hideProgressDialog(Get.context!);
  //       await _launchUrl().whenComplete((){
  //         Get.offAll(()=> HomeScreen());
  //       });
  //     });
  //   }on DioError catch (err){
  //     final errorMessage = DioException.fromDioError(err).toString();
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.response?.data["message"] ?? errorMessage);
  //     throw errorMessage;
  //   }
  //   catch (err){
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.toString());
  //     throw err.toString();
  //   }
  // }
  bool? isKycPending;
  Future<void> getUserData() async {
    await cachedData.getUserPersonalData().then((value) {
      userPersonalData = value;
      loanAmount = userPersonalData?.user.mainWalletAmount;
      if (userPersonalData?.user.kycVerificationStatus == "pending" ||
          userPersonalData?.user.kycVerificationStatus == "unverified") {
        isKycPending = true;
        update();
      } else {
        isKycPending = false;
      }
      update();
    });
  }

  void toggleAmountVisibility() {
    amountVisibility = !amountVisibility;
    update();
  }

  getTransaction() async {
    isFetchingTransaction = true;
    update();
    try {
      await DioServices().getTransaction().then((value) {
        void printDataTypes(dynamic data) {
          if (data is List) {
            print('List<dynamic>');
            for (var item in data) {
              printDataTypes(item); // Recursively call the function for each item in the list
            }
          } else {
            print(data.runtimeType);
          }
        }

// Define a recursive function to handle nested maps
        void printNestedData(Map<String, dynamic> data, String prefix) {
          data.forEach((key, value) {
            if (value is Map<String, dynamic>) {
              // If the value is another map, recursively call the function
              printNestedData(value, "$prefix$key.");
            } else if (value is String) {
              // If the value is a string, try to parse it as JSON
              try {
                Map<String, dynamic> parsedJson = json.decode(value);
                printNestedData(parsedJson, "$prefix$key.");
              } catch (e) {
                // It's a regular string, print it as is
                //debugPrint("$prefix$key: $value");
                debugPrint("$prefix");
                debugPrint("$key:");
                debugPrint("$value");
               }

              }
             else {
              // Otherwise, print the key and value
              debugPrint("$prefix$key: $value");
            }
          });
        }
        debugPrint("=====================");
    // Start the recursive iteration with an empty prefix
      printNestedData(value.data, "");
        transactionHistory =
            TransactionHistoryResponse.fromJson(value.data).data;
        isFetchingTransaction = false;
        update();
      });
    } on DioError catch (err) {
      isFetchingTransaction = false;
      isFetchingTransactionHasError = true;
      update();
      final errorMessage = DioException.fromDioError(err).toString();
      error = errorMessage;
      throw errorMessage;
    } catch (err) {
      isFetchingTransaction = false;
      isFetchingTransactionHasError = true;
      update();
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  Future<void> getAvailableBankAccounts() async {
    isFetchingBankAccount = true;
    update();
    try {
      await DioServices().getBankAccounts().then((value) {
        printValuesAndTypes(value.data);
        bankAccounts = BankAccountModel.fromJson(value.data).data;
        print("====================================");
        isFetchingBankAccount = false;
        update();
      });
    } on DioError catch (err) {
      isFetchingBankAccount = false;
      isFetchingBankAccountHasError = true;
      update();
      final errorMessage = DioException.fromDioError(err).toString();
      error = errorMessage;
      throw errorMessage;
    } catch (err) {
      isFetchingBankAccount = false;
      isFetchingBankAccountHasError = true;
      update();
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  getAvailableLoanPackages() async {
    isFetchingAvailableLoanOffer = true;
    update();
    try {
      await DioServices().getLoanPackages().then((value) {
        loanPackages = AvailableLoanPackages.fromJson(value.data).data;
        isFetchingAvailableLoanOffer = false;
        print("packages returned");
        update();
      });
    } on DioError catch (err) {
      isFetchingAvailableLoanOffer = false;
      isFetchingAvailableLoanOfferHasError = true;
      update();
      final errorMessage = DioException.fromDioError(err).toString();
      error = errorMessage;
      print(errorMessage);
      throw errorMessage;
    } catch (err) {
      isFetchingAvailableLoanOffer = false;
      isFetchingAvailableLoanOfferHasError = true;
      update();
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      print(err.toString());
      throw err.toString();
    }
  }

  void printValuesAndTypes(Map<String, dynamic> data, [String prefix = '']) {
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        // Recursively print inner maps
        printValuesAndTypes(value, '$prefix$key.');
      } else if (value is List<dynamic>) {
        // Print list elements
        for (int i = 0; i < value.length; i++) {
          if (value[i] is Map<String, dynamic>) {
            printValuesAndTypes(value[i], '$prefix$key[$i].');
          } else {
            // Print the key, value, and data type
            print('$prefix$key[$i]: $value[$i] (${value[i].runtimeType})');
          }
        }
      } else {
        // Print the key, value, and data type
        print('$prefix$key: $value (${value.runtimeType})');
      }
    });
  }

  Future<void> getLoanHistory() async {
    isFetchingLoanHistory = true;
    update();
    try {
      await DioServices().getLoanHistory().then((value) {
        printValuesAndTypes(value.data); // Print the values and types recursively
        try {
          final loanHistoryModel = LoanHistoryModel.fromJson(value.data);
          if (loanHistoryModel.data != null && loanHistoryModel.data!.isNotEmpty) {
            loanHistory = loanHistoryModel.data;
            debugPrint("=============================================");
            debugPrint("Loan history is assignment error!");
          } else {
            // Handle the case where "data" is empty or null
            // You can choose to set loanHistory to an empty list or handle it differently.
            loanHistory = [];
            debugPrint("=============================================");
            debugPrint("Loan history is emoty!");
            debugPrint("JSON Response: ${value.data}"); // Print the JSON response for debugging
            isFetchingLoanHistory = false;
          }
          isFetchingLoanHistory = false;
          update();
        } catch (err) {
          // Handle the error appropriately
          debugPrint("=============================================");
          debugPrint("Could not parse loan history");
          debugPrint("JSON Response: ${value.data}"); // Print the JSON response for debugging
          isFetchingLoanHistory = false;
          isFetchingLoanHistoryHasError = true;
          update();
          throw err.toString();
        }

      });
    } on DioError catch (err) {
      isFetchingLoanHistory = false;
      isFetchingLoanHistoryHasError = true;
      update();
      final errorMessage = DioException.fromDioError(err).toString();
      error = errorMessage;
      throw errorMessage;
    } catch (err) {
      isFetchingLoanHistory = false;
      isFetchingLoanHistoryHasError = true;
      update();
      throw err.toString();
    }
  }
}
