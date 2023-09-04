import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phincash/src/auth/login/login_views/verify_otp.dart';
import 'package:phincash/src/auth/login/models/login_model.dart';
import 'package:phincash/src/auth/models/user_personal_data.dart';
import 'package:phincash/src/auth/registration/registration_views/bvn.dart';
import 'package:phincash/src/auth/registration/registration_views/collect_banks_details.dart';
import 'package:phincash/src/auth/registration/registration_views/emergency_contact.dart';
import 'package:phincash/src/auth/registration/registration_views/selfie_page.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import '../../../../repository/cached_data.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../services/dio_services/dio_services.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';
import '../../../loan_transaction/acquire_loan/loan_acquisition_view/add_card.dart';
import '../../registration/registration_views/basic_information.dart';
import '../../registration/registration_views/create_transaction_pin.dart';

class LoginController extends GetxController {
  CachedData cachedData = CachedData();

  final phoneValidator = RegExp(r'(^(?:[+0]9)?[0-9]{11,14}$)');

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool? isPasswordObscured = true;

  // final formKeyLogin = GlobalKey <FormState>();
  // final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKeyOtp = GlobalKey<FormState>();
  final scaffoldKeyOtpScreen = GlobalKey<ScaffoldState>();

  String? phoneNumber;

  loginUser({required String? phoneNumber, required String? password}) async {
    ProgressDialogHelper()
        .showProgressDialog(Get.context!, "Authenticating...");
    try {
      await DioServices()
          .loginUser(phoneNumber: phoneNumber!, password: password!)
          .then((value) {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        Get.offAll(() => const VerifyOtp());
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

  void toggleVisibility() {
    isPasswordObscured = !isPasswordObscured!;
    update();
  }

  resendLoginOtp({required String? phoneNumber}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Resending Otp...");
    try {
      await DioServices()
          .resendLoginOtp(phoneNumber: phoneNumberController.text)
          .whenComplete(() {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        FlushBarHelper(Get.context!).showFlushBar("Otp Sent Successful");
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

  verifyOtp({required String? phoneNumber, required String? otp}) async {
    ProgressDialogHelper()
        .showProgressDialog(Get.context!, "Verifying Code...");
    try {
      await DioServices()
          .verifyOtp(
              phoneNumber: phoneNumberController.text.toString(),
              otp: otp!.toString())
          .then((value) async {
        var response = LoginResponseModel.fromJson(value.data);
        await cachedData
            .cacheAuthToken(token: response.data?.accessToken)
            .then((value) async {
          if (response.data?.user?.onboardStage == "basic_information") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const BasicInformation());
            FlushBarHelper(Get.context!).showFlushBar(
                "kindly provide the following information to complete your registration");
          }
          // else if(response.data?.user?.onboardStage == "bvn_information"){
          //   ProgressDialogHelper().hideProgressDialog(Get.context!);
          //   Get.offAll(()=> const BvnVerificationScreen());
          // }
          else if (response.data?.user?.onboardStage == "emergency_contact") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const EmergencyContact());
          } else if (response.data?.user?.onboardStage == "bank_information") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const CollectUserBankDetails());
          } else if (response.data?.user?.onboardStage ==
              "upload_profile_Photo") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => CameraApp(
                  id: response.data!.user!.id!.toString(),
                ));
          } else if (response.data?.user?.onboardStage == "card_binding") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const AddCardScreen());
          } else if (response.data?.user?.onboardStage == "pin_creation") {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const CreatePin());
          } else if (response.data?.user?.onboardStage == "onboard_completed") {
            try {
              await getUserPersonalData();
              await cachedData.cacheLoginStatus(isLoggedIn: true);
              ProgressDialogHelper().hideProgressDialog(Get.context!);
              Get.to(() => const HomeScreen());
            } catch (error) {
              FlushBarHelper(Get.context!)
                  .showFlushBar("An error occurred: $error");
            }
          }
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

  Future<void> getUserPersonalData() async {
    try {
      await DioServices().getUserPersonalData().then((value) async {
        final response = value.data;
        print("This is the response ${response}");
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

  Future<void> checkConnectionForLogin() async {
    //if(formKeyLogin.currentState!.validate()){
    //formKeyLogin.currentState!.save();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!(connectivityResult == ConnectivityResult.none)) {
      //await updateOnBoardingStage(onBoardStage: "card_binding");
      loginUser(
          phoneNumber: phoneNumberController.text,
          password: passwordController.text);
    } else {
      FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
    }
    //}
  }

  Future<void> checkConnectionForVerifyingOTP() async {
    if (formKeyOtp.currentState!.validate()) {
      formKeyOtp.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        verifyOtp(
            phoneNumber: phoneNumber.toString(),
            otp: otpController.text.toString());
      } else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> checkConnectionForResendOTP() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!(connectivityResult == ConnectivityResult.none)) {
      resendLoginOtp(phoneNumber: phoneNumber);
    } else {
      FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
    }
  }
}
