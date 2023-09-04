import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/services/dio_services/dio_services.dart';
import 'package:phincash/src/auth/forget_password/forgot_password_views/reset_password.dart';
import 'package:phincash/src/auth/forget_password/forgot_password_views/verify_forgot_password.dart';
import 'package:phincash/src/auth/login/login_views/login.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';

class ResetPasswordController extends GetxController{

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? phoneNumber;
  String? code;
  final phoneValidator = RegExp(r'(^(?:[+0]9)?[0-9]{11,14}$)');
  final formKeyForgotPasswordKey = GlobalKey <FormState>();
  final scaffoldForgotPassword = GlobalKey <ScaffoldState>();
  final formKeyForgotPasswordOtpVerifyKey = GlobalKey <FormState>();
  final scaffoldForgotPasswordOtpVerifyKey = GlobalKey <ScaffoldState>();
  final formKeyValidResetPasswordKey = GlobalKey <FormState>();
  final scaffoldValidateResetPassword = GlobalKey <ScaffoldState>();
  final formKeyResetPasswordKey = GlobalKey <FormState>();
  final scaffoldResetPassword = GlobalKey <ScaffoldState>();


  sendResetCode({required String phoneNumber}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Sending Verification Code...");
    try {
      await DioServices().sendPasswordResetCode(resetPasswordPhoneNumber: phoneNumber).then((value) {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(() => const VerifyForgotPassword());
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }


  validateResetCode({required String code}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Verifying Code...");
    try {
      await DioServices().validateResetCode(resetPasswordPhoneNumber: phoneNumber!, code: code).whenComplete(() {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        Get.offAll(() => const ResetPassword());
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  resendLoginOtp({required String? phoneNumber}) async{
    ProgressDialogHelper().showProgressDialog(Get.context!, "Resending Otp...");
    try{
      await DioServices().resendLoginOtp(phoneNumber: phoneNumber!).then((value){
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        FlushBarHelper(Get.context!).showFlushBar("Otp Sent Successful");
      });
    }on DioError catch (err){
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar( err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err){
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar( err.toString());
      throw err.toString();
    }
  }

  Future<void> checkConnectionForResendOTP() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!(connectivityResult == ConnectivityResult.none)) {
      resendLoginOtp(phoneNumber: phoneNumber);
    }else {
      FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
    }
  }

  resetAccountPassword({required String phoneNumber,required String code, required String password, required String confirmPassword}) async {
    ProgressDialogHelper().showProgressDialog(Get.context!, "Resetting Password...");
    try {
      await DioServices().resetAccountPassword(resetPasswordPhoneNumber: phoneNumber, code: code, password: password, confirmPassword: confirmPassword).then((value) {
        ProgressDialogHelper().hideProgressDialog(Get.context!);
        Get.offAll(() => const Login());
        FlushBarHelper(Get.context!).showFlushBar("Password reset successful!", messageColor: Colors.green, color: Colors.white,
            borderColor: Colors.green, icon: Icon(Icons.check_circle, color: Colors.green,size: 50,));
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar(err.toString());
      throw err.toString();
    }
  }

  Future<void> checkConnectionForResetPassword() async {
    if(formKeyForgotPasswordKey.currentState!.validate()){
      formKeyForgotPasswordKey.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        sendResetCode(phoneNumber: phoneNumberController.text);
      }else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> checkConnectionForValidateResetPassword() async {
    if(formKeyForgotPasswordOtpVerifyKey.currentState!.validate()){
      formKeyForgotPasswordOtpVerifyKey.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        validateResetCode(code: code!);
      }else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

  Future<void> checkConnectionForResetAccountPassword() async {
    if(formKeyResetPasswordKey.currentState!.validate()){
      formKeyResetPasswordKey.currentState!.save();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (!(connectivityResult == ConnectivityResult.none)) {
        resetAccountPassword(password: newPasswordController.text, confirmPassword: confirmPasswordController.text, code: code!, phoneNumber: phoneNumber!,);
      }else {
        FlushBarHelper(Get.context!).showFlushBar("No Internet Connection");
      }
    }
  }

}