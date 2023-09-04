import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:phincash/repository/cached_data.dart';
import 'package:phincash/services/dio_services/dio_services.dart';
import 'package:phincash/src/auth/login/login_views/verify_otp.dart';
import 'package:phincash/src/auth/registration/registration_model/bvn_consent_model.dart';
import 'package:phincash/src/auth/registration/registration_model/bvn_response_model.dart';
import 'package:phincash/src/auth/registration/registration_model/support_banks_model.dart';
import 'package:phincash/src/auth/registration/registration_views/bvn_webview.dart';
import 'package:phincash/src/auth/registration/registration_views/emergency_contact.dart';
import 'package:phincash/src/preferences/model/emergency_contact_model.dart';
import 'package:phincash/utils/helpers/progress_dialog_helper.dart';
import '../../../../constants/constants.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../loan_transaction/transactions/transaction_views/home_screen.dart';
import '../../login/controller/login_controller.dart';
import '../../login/login_views/login.dart';
import '../../models/user_personal_data.dart';
import '../registration_model/registration_model.dart';
import 'package:flutter/material.dart';
import '../registration_views/card-details.dart';
import '../registration_views/collect_banks_details.dart';
import '../registration_views/create_transaction_pin.dart';
import 'dart:io';

import '../registration_views/selfie_page.dart';

class RegistrationController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  CachedData cachedData = CachedData();

  //List
  List<String> nextOfKinRelationshipList = [
    "Friends",
    "Sibling",
    "Colleagues",
    "Relatives",
    "Classmates",
    "Others"
  ];
  final List<String> _gender = ["male", "female"];
  final List<String> _maritalStatus = [
    "single",
    "married",
    "divorced",
    "widowed"
  ];
  final List<String> _educationLevel = ["OND", "HND", "BSC", "SSCE"];
  final List<String> _religion = ["christianity", "islam", "other"];
  List<SupportBanks>? supportedBanks = <SupportBanks>[].obs;
  String? selectedBank;
  String? bankCCVCode;

  //Getter
  List get gender => _gender;
  List get maritalStatus => _maritalStatus;
  List get religion => _religion;
  List get educationLevel => _educationLevel;

  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneValidator = RegExp(r'(^(?:[+0]9)?[0-9]{11,14}$)');

  //Variables
  bool isVerifyNumberScreen = true;
  bool isVerifyOtpScreen = false;
  bool isCompleteSignUpScreen = false;
  bool isTermsAndConditionSelected = false;
  bool? dateSelected = false;
  bool? isFetchingSupportedBanks;
  bool? isFetchingSupportedBanksHasError;
  DateTime? selectedDateOfBirth;
  String? firstNextOfKinRelationship;
  String? secondNextOfKinRelationship;
  String? bvnFirstName;
  String? bvnMiddleName;
  String? bvnSurName;
  String? bvnEmail;
  String? bvnUrl;
  String? bvnRef;
  String? bvnResidentialAddress;
  bool? isPasswordObscured = true;

  //FormFields
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController bankAccountName = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController bvnPhoneNumberController =
      TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController residentialAddressController =
      TextEditingController();
  final TextEditingController bvnController = TextEditingController();
  final TextEditingController bvnFirstnameController = TextEditingController();
  final TextEditingController bvnLastnameController = TextEditingController();
  final TextEditingController firstNextOfKinNameController =
      TextEditingController();
  final TextEditingController firstNextOfKinEmailController =
      TextEditingController();
  final TextEditingController firstNextOfKinAddressController =
      TextEditingController();
  final TextEditingController firstNextOfKinNumberController =
      TextEditingController();
  final TextEditingController secondNextOfKinNameController =
      TextEditingController();
  final TextEditingController secondNextOfKinEmailController =
      TextEditingController();
  final TextEditingController secondNextOfKinAddressController =
      TextEditingController();
  final TextEditingController secondNextOfKinNumberController =
      TextEditingController();
  final TextEditingController transactionPINController =
      TextEditingController();
  final TextEditingController validateBVNController = TextEditingController();
  final TextEditingController validateBVNfirstnameController =
      TextEditingController();
  final TextEditingController validateBVNlastnameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  String? selectedGender;
  String? selectedMaritalStatus;
  String? selectedReligion;
  String? selectedEducationalLevel;
  String? dateOfBirthday;

  @override
  void onInit() {
    getSupportedBanks();
    fetchContacts();
    super.onInit();
    update();
  }

  void selectFirstNextOFKin(int index) {
    Get.back();
    firstNextOfKinRelationship = nextOfKinRelationshipList[index];
    update();
  }

  void selectSecondNextOfKin(int index) {
    Get.back();
    secondNextOfKinRelationship = nextOfKinRelationshipList[index];
    update();
  }

  final formKeySignUp = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKeyBasicInformation = GlobalKey<ScaffoldState>();
  final formKeyBasicInformation = GlobalKey<FormState>();
  final scaffoldKeyAboutYou = GlobalKey<ScaffoldState>();
  final formKeyAboutYou = GlobalKey<FormState>();
  final scaffoldKeyBvnScreen = GlobalKey<ScaffoldState>();
  final formKeyBvnScreen = GlobalKey<FormState>();
  final scaffoldkeyBvnScreen = GlobalKey<ScaffoldState>();
  final formKeyCardScreen = GlobalKey<FormState>();
  final formKeyEmergencyContact = GlobalKey<FormState>();
  final scaffoldKeyEmergencyContact = GlobalKey<ScaffoldState>();
  final scaffoldKeyCollectBankDetail = GlobalKey<ScaffoldState>();
  final formKeyCollectBankDetails = GlobalKey<FormState>();
  final scaffoldKeyValidateBVNScreen = GlobalKey<ScaffoldState>();
  final formKeyValidateBVNScreen = GlobalKey<FormState>();

  void toggleVisibility() {
    isPasswordObscured = !isPasswordObscured!;
    update();
  }

  valid() {
    if (selectedGender == null || selectedGender == "Gender") {
      FlushBarHelper(Get.context!).showFlushBar("Please select gender");
    } else if (selectedMaritalStatus == null ||
        selectedMaritalStatus == "Marital Status") {
      FlushBarHelper(Get.context!).showFlushBar("Please select Marital Status");
    } else if (selectedReligion == null || selectedReligion == "Religion") {
      FlushBarHelper(Get.context!).showFlushBar("Please select Religion");
    } else if (selectedEducationalLevel == null ||
        selectedEducationalLevel == "Highest Education Level") {
      FlushBarHelper(Get.context!)
          .showFlushBar("Please select your Highest Educational Level");
    } else if (selectedDateOfBirth == null) {
      FlushBarHelper(Get.context!)
          .showFlushBar("Please select your Date of Birth");
    }
  }

  UserData(
      {required String firstName,
      required String lastName,
      String? middleName,
      required String email,
      required String phoneNumber,
      required String gender,
      required String? maritalStatus,
      required String religion,
      required String educationalLevel,
      required String residentialAddress,
      required String dateOfBirth}) async {
    if (formKeyAboutYou.currentState!.validate()) {
      formKeyAboutYou.currentState!.save();
      valid();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        collectUserData(
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            email: email,
            phoneNumber: phoneNumber,
            gender: gender,
            maritalStatus: maritalStatus,
            religion: religion,
            educationalLevel: educationalLevel,
            residentialAddress: residentialAddress,
            dateOfBirth: dateOfBirth);
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> collectedUserBankDetails() async {
    if (formKeyCollectBankDetails.currentState!.validate()) {
      formKeyCollectBankDetails.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        saveBankDetailsUser(
            accountName: bankAccountName.text.trim(),
            accountNumber: bankAccountNumber.text.trim(),
            bankName: selectedBank!,
            bankCode: bankCCVCode!);
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> collectedBVNDetails() async {
    if (formKeyBvnScreen.currentState!.validate()) {
      formKeyBvnScreen.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        savedBvn = bvnController.text.trim();
        saveBvnDetails(
            bvn: bvnController.text.trim(),
            firstname: bvnFirstnameController.text.trim(),
            lastname: bvnLastnameController.text.trim());
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> collectedUserCardDetails() async {
    if (formKeyCardScreen.currentState!.validate()) {
      formKeyCardScreen.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> updateOnBoardingStage({required String onBoardStage}) async {
    try {
      await DioServices().onBoardingStage(onBoardStage: onBoardStage);
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

  getSupportedBanks() async {
    isFetchingSupportedBanks = true;
    update();
    try {
      await DioServices().getSupportedBanks().then((value) {
        supportedBanks = SupportedBanks.fromJson(value.data).data;
        isFetchingSupportedBanks = false;
        update();
      });
    } on DioError catch (err) {
      isFetchingSupportedBanks = false;
      isFetchingSupportedBanksHasError = true;
      update();
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err) {
      isFetchingSupportedBanks = false;
      isFetchingSupportedBanksHasError = true;
      update();
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  // Future<void> checkConnectionForValidateBVN() async {
  //   if (formKeyValidateBVNScreen.currentState!.validate()) {
  //     formKeyValidateBVNScreen.currentState!.save();
  //     var connectivityResult = await Connectivity().checkConnectivity();
  //     if (!(connectivityResult == ConnectivityResult.none)) {
  //       validateBVN(bvn: validateBVNController.text);
  //     } else {
  //       FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
  //     }
  //   }
  // }

  Future<void> pickWorkStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1930),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      selectedDateOfBirth = picked;
      dateSelected = true;
      update();
    }
  }

  void selectGender(int index) {
    Get.back();
    selectedGender = _gender[index];
    update();
  }

  void selectMaritalStatus(int index) {
    Get.back();
    selectedMaritalStatus = _maritalStatus[index];
    update();
  }

  void selectReligion(int index) {
    Get.back();
    selectedReligion = _religion[index];
    update();
  }

  void selectEducationLevel(int index) {
    Get.back();
    selectedEducationalLevel = _educationLevel[index];
    update();
  }

  Future<void> signUp() async {
    if (formKeySignUp.currentState!.validate()) {
      if (isTermsAndConditionSelected) {
        formKeySignUp.currentState!.save();
        var connectivityResult = await Connectivity().checkConnectivity();
        if (!(connectivityResult == ConnectivityResult.none)) {
          registerUser();
        } else {
          FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
        }
      } else {
        FlushBarHelper(Get.context!)
            .showFlushBar("Accept the Terms & Conditions");
      }
    }
  }

  void selectTermsAndCondition() {
    isTermsAndConditionSelected = !isTermsAndConditionSelected;
    update();
  }

  void moveBackToVerifyOTPScreen() {
    isVerifyNumberScreen = true;
    isVerifyOtpScreen = true;
    isCompleteSignUpScreen = false;
    update();
    Get.back();
  }

  void moveBackToCreateAccountScreen() {
    isVerifyNumberScreen = true;
    isVerifyOtpScreen = false;
    isCompleteSignUpScreen = false;
    update();
    Get.back();
  }

  saveBvnDetails(
      {required String bvn,
      required String firstname,
      required String lastname}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .verifyBVN(
        bvn: bvn,
        firstname: firstname,
        lastname: lastname,
      )
          .then((value) async {
        final response = BvnResponse.fromJson(jsonDecode(value.data));
        if (response.status == 'success') {
          ProgressDialogHelper().hideProgressDialog(Get.context!);
          if (response.data.url != null && response.data.url!.isNotEmpty) {
            await cachedData.cacheBvnRequestDetails(
                bvnResponse: BvnResponse.fromJson(jsonDecode(value.data)));
            bvnUrl = response.data.url;
            bvnRef = response.data.reference;
            Get.to(() => BvnWebView(url: response.data.url!));
          } else {
            await cachedData.cacheBvnRequestDetails(
                bvnResponse: BvnResponse.fromJson(jsonDecode(value.data)));
            saveBankDetailsUser(
                accountName: savedBankAccountName,
                accountNumber: savedBankAccountNumber,
                bankName: savedBankName,
                bankCode: savedBankCode);
          }
          ;
        }
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!)
          .showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      if (err is DioError) {
        final errorMessage = DioException.fromDioError(err).toString();
        FlushBarHelper(Get.context!)
            .showFlushBar(err.response?.data["message"] ?? errorMessage);
        throw errorMessage;
      } else {
        FlushBarHelper(Get.context!).showFlushBar(err.toString());
        throw err.toString();
      }
    }
  }

  saveBankDetailsUser(
      {required String accountName,
      required String accountNumber,
      required String bankName,
      required String bankCode}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      BvnResponse? details = await cachedData.getBvnRequestDetails();
      String bvnRef = details!.data.reference!;
      await DioServices().confirmBVN(reference: bvnRef).then((value) async {
        final response = BvnConsent.fromJson(jsonDecode(value.data));
        // debugPrint(value.data);
        String userPhone = response.data.bvnData.phoneNumber1;
        String dob = response.data.bvnData.dateOfBirth;
        // debugPrint(dob);
        await DioServices()
            .verifyBankDetails(
          accountNumber: accountNumber,
          bankCode: bankCode,
        )
            .then((value) async {
          ;
          accountName = value.data!.accountName!;

          await DioServices()
              .saveVerifiedBankDetails(
                  accountName: accountName,
                  accountNumber: accountNumber,
                  bankName: bankName,
                  bankCode: bankCode,
                  bvn: savedBvn,
                  userPhone: userPhone,
                  dob: dob)
              .then((value) async {
            await updateOnBoardingStage(onBoardStage: "upload_profile_Photo")
                .then((value) async {
              UserPersonalData? resp = await cachedData.getUserPersonalData();
              ProgressDialogHelper().hideProgressDialog(Get.context!);
              // Get.to(() => AddCardScreen());
              Get.offAll(() => CameraApp(id: resp!.user.id.toString()));
              //Get.off(() => CameraApp(id: DateTime.now().toString()));
              // Get.offAll(() => const CreatePin());
            });
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

  saveCardDetailsUser(
      {required String cvv,
      required String cardNumber,
      required String expiryMonth,
      required String expiryYear}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try {
      await DioServices()
          .saveCardDetails(
              cardNumber: cardNumber,
              cvv: cvv,
              expiryMonth: expiryMonth,
              expiryYear: expiryYear)
          .then((value) async {
        {
          await updateOnBoardingStage(onBoardStage: "pin_creation")
              .then((value) {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            // Get.to(() => AddCardScreen());

            //Get.off(() => CameraApp(id: DateTime.now().toString()));
            Get.offAll(() => const CreatePin());
          });
        }
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

  registerUser() async {
    ProgressDialogHelper()
        .showProgressDialog(Get.context!, "Authenticating...");
    loginController.phoneNumberController.text = phoneNumberController.text;
    loginController.passwordController.text = passwordController.text;
    try {
      await DioServices()
          .registerUser(
              phoneNumber: phoneNumberController.text,
              password: passwordController.text)
          .then((value) async {
        final response = RegistrationResponseModel.fromJson(value.data);
        await cachedData
            .cacheAuthToken(token: response.otherInfo!.accessToken)
            .then((value) async {
          await updateOnBoardingStage(onBoardStage: "basic_information")
              .whenComplete(() {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const VerifyOtp());
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

  List<List<dynamic>> data = [];

  createPIN(
      {required String? pin,
      required Map<dynamic, dynamic> contactList}) async {
    try {
      ProgressDialogHelper()
          .showProgressDialog(Get.context!, "Creating Pin...");
      await DioServices().createTransactionPin(pin: pin!).then((value) async {
        if (value.statusCode == 200) {
          await cachedData
              .cacheLoginStatus(isLoggedIn: false)
              .then((value) async {
            await updateOnBoardingStage(onBoardStage: "onboard_completed");
            await getUserPersonalData().then((value) async {
              // await getContactFile(contactList: contactList).whenComplete(() {
              //   cachedData.cacheCsvUploadStatus(isUpLoadingCsv: false);
              //   ProgressDialogHelper().hideProgressDialog(Get.context!);

              FlushBarHelper(Get.context!).showFlushBar(
                  "Registration Completed. Enjoy!",
                  color: Colors.green);
              // });
            });
          });
          await getUserPersonalData().then((value) async {
            await cachedData.cacheLoginStatus(isLoggedIn: true);
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const HomeScreen());
          });
        }
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

  Future<void> saveEmergencyContacts() async {
    try {
      await DioServices().getEmergencyContacts().then((value) async {
        await cachedData.cacheEmergencyContact(
            emergencyContactData: EmergencyContactData.fromJson(value.data));
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

  Future<void> collectEmergencyContact() async {
    ProgressDialogHelper()
        .showProgressDialog(Get.context!, "Saving Contact Details...");
    try {
      await DioServices()
          .collectEmergencyContact(
              name: firstNextOfKinNameController.text,
              email: firstNextOfKinEmailController.text.isEmpty
                  ? ""
                  : firstNextOfKinEmailController.text,
              relationship: firstNextOfKinRelationship!,
              address: firstNextOfKinAddressController.text.isEmpty
                  ? ""
                  : firstNextOfKinAddressController.text,
              phoneNumber: firstNextOfKinNumberController.text)
          .whenComplete(() async {
        await DioServices()
            .collectEmergencyContact(
                name: secondNextOfKinNameController.text,
                email: secondNextOfKinEmailController.text.isEmpty
                    ? ""
                    : secondNextOfKinEmailController.text,
                relationship: secondNextOfKinRelationship!,
                address: secondNextOfKinAddressController.text.isEmpty
                    ? ""
                    : secondNextOfKinAddressController.text,
                phoneNumber: secondNextOfKinNumberController.text)
            .then((value) async {
          await saveEmergencyContacts().then((value) async {
            await updateOnBoardingStage(onBoardStage: "bank_information")
                .then((value) {
              Get.offAll(() => const CollectUserBankDetails());
            });
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

  Future<void> collectNextOfKinDetails() async {
    if (formKeyEmergencyContact.currentState!.validate()) {
      if (firstNextOfKinRelationship != null &&
          secondNextOfKinRelationship != null) {
        formKeyEmergencyContact.currentState!.save();
        var connectivityResult = await Connectivity().checkConnectivity();
        if (!(connectivityResult == ConnectivityResult.none)) {
          collectEmergencyContact();
        } else {
          FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
        }
      } else {
        FlushBarHelper(Get.context!)
            .showFlushBar("Please select Next Of Kin Relationship");
      }
    }
  }

  // validateBVN({required String? bvn}) async {
  //   ProgressDialogHelper().showProgressDialog(Get.context!, "Verifying...");
  //   try {
  //     await DioServices().verifyBVN(bvn: bvn!).then((value) async {
  //       // await getUserPersonalData().then((value) async {
  //       //   await getUserPersonalData().then((value) async {
  //       //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //       //     Get.offAll(() => const HomeScreen());
  //       //   });
  //       // });

  //       print(value);
  //     });
  //   } on DioError catch (err) {
  //     final errorMessage = DioException.fromDioError(err).toString();
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!)
  //         .showFlushBar(err.response?.data["message"] ?? errorMessage);
  //     throw errorMessage;
  //   } catch (err) {
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar(err.toString());
  //     throw err.toString();
  //   }
  // }

  // verifyBVN({required String? bvn}) async{
  //   ProgressDialogHelper().showProgressDialog(Get.context!, "Verifying...");
  //   try{
  //     await DioServices().verifyBVN(bvn: bvn!).then((value) async {
  //         await getUserPersonalData().then((value) async {
  //           await updateOnBoardingStage(onBoardStage: "emergency_contact").then((value){
  //             ProgressDialogHelper().hideProgressDialog(Get.context!);
  //             Get.offAll(()=> const EmergencyContact());
  //           });
  //         });
  //     });
  //   }on DioError catch (err){
  //     final errorMessage = DioException.fromDioError(err).toString();
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.response?.data["message"] ?? errorMessage);
  //     throw errorMessage;
  //   }catch (err){
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.toString());
  //     throw err.toString();
  //   }
  // }

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

  Future<void> getContactFile(
      {required Map<dynamic, dynamic> contactList}) async {
    cachedData.cacheCsvUploadStatus(isUpLoadingCsv: true);
    try {
      await DioServices().getContactFile(contactList: contactList);
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

  void selectBank(int index) {
    Get.back();
    selectedBank = supportedBanks![index].name;
    bankCCVCode = supportedBanks![index].code;
    update();
  }

  collectUserData(
      {required String firstName,
      required String lastName,
      String? middleName,
      required String email,
      required String phoneNumber,
      required String gender,
      required String? maritalStatus,
      required String religion,
      required String educationalLevel,
      required String residentialAddress,
      required String dateOfBirth}) async {
    ProgressDialogHelper()
        .showProgressDialog(Get.context!, "Saving Information...");
    try {
      await DioServices()
          .updateAccount(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        maritalStatus: maritalStatus,
        religion: religion,
        educationalLevel: educationalLevel,
        residentialAddress: residentialAddress,
        dateOfBirth: dateOfBirth,
      )
          .then((value) async {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        Get.to(() => const EmergencyContact());
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

  RxList<Contact> contactList = <Contact>[].obs;
  RxBool permissionDenied = false.obs;
  List<String> names = [];
  List<String> phones = [];
  RxMap<String, dynamic> contactMap = <String, dynamic>{}.obs;

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      SystemNavigator.pop();
      permissionDenied = true.obs;
    } else {
      final contacts = await FlutterContacts.getContacts(
          withThumbnail: false, withProperties: true, withGroups: true);
      contactList = contacts.obs;
      convertContactsToMap();
    }
  }

  Future<void> checkConnectionForCreatePin(
      {required Map<dynamic, dynamic> contactList}) async {
    if (formKeyBvnScreen.currentState!.validate()) {
      formKeyBvnScreen.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        createPIN(pin: transactionPINController.text, contactList: contactList);
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  convertContactsToMap() {
    contactList.forEach((contact) {
      contact.phones.toSet().forEach((phone) {
        names.add(
            contact.displayName.isEmpty ? "Anonymous" : contact.displayName);
        phones.add(phone.number);
      });
    });
    Map m = {};
    names.asMap().entries.forEach((entry) {
      int index = entry.key;
      String val = entry.value;
      Map m1 = {'name': val, 'phone': phones[index]};
      m[val] = m1;
      Map<String, dynamic> contactList = {
        "import_type": "array",
        "contacts": [
          m1,
        ]
      };
      contactMap = contactList.obs;
    });
  }

  Future<String> uploadImage(File file) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Uploading...");
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!(connectivityResult == ConnectivityResult.none)) {
      var response = await DioServices().uploadImage(file);
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      Get.offAll(() => const CreatePin());
      return response;
    } else {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      return "";
    }
  }
}
