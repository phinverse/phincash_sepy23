import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phincash/services/dio_services/dio_services.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/src/auth/registration/registration_model/verify_user_data_model.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../repository/cached_data.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';
import '../../../../widget/custom_success_dialog.dart';
import '../../../auth/models/user_personal_data.dart';

class WithdrawalController extends GetxController {
  final transactionController = Get.put(TransactionController());
  final registrationController = Get.put(RegistrationController());
  CachedData cachedData = CachedData();
  String? selectedBankAccount;
  String? selectedBank;
  String? accountNumber;
  String? bankName;
  String? loanAmount;
  bool? isBankAccountSelected = false;
  int? bankAccountId;
  String? pin;
  String? bankCCVCode;
  String? selectedBankName;

  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  TextEditingController get searchTextEditingController =>
      _searchTextEditingController;
  TextEditingController get loanAmountController => _loanAmountController;
  TextEditingController get pinController => _pinController;
  TextEditingController get cardNameController => _cardNameController;
  TextEditingController get accountNameController => _accountNameController;
  TextEditingController get accountNumberController => _accountNumberController;
  final List<SelectedListItem> banks = [
    SelectedListItem(isSelected: false, name: "ACCESS BANK"),
    SelectedListItem(isSelected: false, name: "CITIBANK"),
    SelectedListItem(isSelected: false, name: "DIAMOND BANK"),
    SelectedListItem(isSelected: false, name: "ECOBANK NIGERIA"),
    SelectedListItem(isSelected: false, name: "ENTERPRISE BANK LIMITED"),
    SelectedListItem(isSelected: false, name: "FIDELITY BANK NIGERIA"),
    SelectedListItem(isSelected: false, name: "FIRST BANK OF NIGERIA"),
    SelectedListItem(isSelected: false, name: "FIRST CITY MONUMENT BANK"),
    SelectedListItem(isSelected: false, name: "FSDH Merchant Bank"),
    SelectedListItem(isSelected: false, name: "GUARANTY TRUST BANK (GT Bank)"),
    SelectedListItem(isSelected: false, name: "HERITAGE BANK PLC"),
    SelectedListItem(isSelected: false, name: "KEYSTONE BANK LIMITED"),
    SelectedListItem(isSelected: false, name: "RAND MERCHANT BANK"),
    SelectedListItem(isSelected: false, name: "SKYE BANK"),
    SelectedListItem(
        isSelected: false, name: "STANBIC IBTC BANK NIGERIA LIMITED"),
    SelectedListItem(isSelected: false, name: "STANDARD CHARTERED BANK"),
    SelectedListItem(isSelected: false, name: "STERLING BANK"),
    SelectedListItem(isSelected: false, name: "UNION BANK OF NIGERIA"),
    SelectedListItem(isSelected: false, name: "UNITED BANK FOR AFRICA"),
    SelectedListItem(isSelected: false, name: "UNITY BANK PLC"),
    SelectedListItem(isSelected: false, name: "WEMA BANK"),
    SelectedListItem(isSelected: false, name: "ZENITH BANK"),
    SelectedListItem(isSelected: false, name: "SUNTRUST BANK NIGERIA LIMITED"),
    SelectedListItem(isSelected: false, name: "PROVIDUSBANK PLC"),
    SelectedListItem(isSelected: false, name: "JAIZ BANK LIMITED"),
    SelectedListItem(isSelected: false, name: "FCMB GROUP PLC"),
    SelectedListItem(isSelected: false, name: "FBN HOLDINGS PLC"),
    SelectedListItem(isSelected: false, name: "STANBIC IBTC HOLDINGS PLC"),
    SelectedListItem(isSelected: false, name: "CORONATION MERCHANT BANK"),
    SelectedListItem(isSelected: false, name: "FBN MERCHANT BANK"),
  ];

  // @override
  // void dispose() {
  //   pinController.dispose();
  //   super.dispose();
  // }

  void selectAccount(int index) {
    Get.back();
    selectedBankAccount =
        transactionController.bankAccounts![index].accountNumber;
    bankAccountId = transactionController.bankAccounts![index].id;
    accountNumber = transactionController.bankAccounts![index].accountNumber;
    bankName = transactionController.bankAccounts![index].bankName;
    update();
  }

  void bankSelected() {
    isBankAccountSelected = true;
    update();
  }

  void selectBank(int index) {
    Get.back();
    selectedBank = registrationController.supportedBanks![index].name;
    bankCCVCode = registrationController.supportedBanks![index].code;
    update();
  }

  Future<void> addAccount() async {
    if (formKeyAddBankAccount.currentState!.validate()) {
      formKeyAddBankAccount.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        addBankAccount(
            accountName: accountNameController.text,
            accountNumber: accountNumberController.text,
            bankName: selectedBank!,
            bankCode: bankCCVCode!);
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  deleteAccount({required String? bankId}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .deletedBankAccount(bankId: bankId)
          .then((value) async {
        await transactionController.getAvailableBankAccounts().then((value) {
          Get.back();
          ProgressDialogHelper().hideProgressDialog(Get.context!);
          FlushBarHelper(Get.context!)
              .showFlushBar("Account Deleted Successfully");
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

  addBankAccount({
    required String accountName,
    required String accountNumber,
    required String bankName,
    required String bankCode,
  }) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .saveBankDetails(
              accountName: accountName,
              accountNumber: accountNumber,
              bankName: bankName,
              bankCode: bankCode)
          .then((value) async {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        Get.offAll(() => const HomeScreen());
        FlushBarHelper(Get.context!).showFlushBar("Account Added Successfully");
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

  confirmWithdrawal() async {
    final amount = int.parse(loanAmount!.replaceAll(",", "").trim());
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .withdrawFunds(
              pin: pin!,
              amount: amount.toInt(),
              bankId: bankAccountId!.toString())
          .then((value) async {
        await getUserPersonalData().then((value) async {
          Get.back();
          ProgressDialogHelper().hideProgressDialog(Get.context!);
          Get.offAll(() => const HomeScreen());
          SuccessDialog().showSuccessDialog(Get.context!);
        });
      });
    } on DioError catch (err) {
      pinController.clear();
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      pinController.clear();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  Future<void> _launchUrl({required String paymentLink}) async {
    final Uri _url = Uri.parse(paymentLink);
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_url';
    }
  }

  verifyUser() async {
    try {
      ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
      await DioServices().verifyUserData().then((value) async {
        var response = VerifyUserData.fromJson(value.data);
        await _launchUrl(paymentLink: response.data!.verificationUrl!)
            .then((value) async {
          await getUserPersonalData().then((value) async {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const HomeScreen());
            // SuccessDialog().showSuccessDialog(Get.context!);
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

  final scaffoldKeyAddBankAccount = GlobalKey<ScaffoldState>();
  final formKeyAddBankAccount = GlobalKey<FormState>();
  final formKeyPin = GlobalKey<FormState>();
  final scaffoldKeyPin = GlobalKey<ScaffoldState>();

  Future<void> getUserPersonalData() async {
    try {
      await DioServices().getUserPersonalData().then((value) async {
        await cachedData.cacheUserPersonalData(
            userPersonalData: UserPersonalData.fromJson(value.data));
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

  @override
  void onInit() {
    update();
    super.onInit();
  }
}
