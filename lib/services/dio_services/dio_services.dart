import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:phincash/services/dio_service_config/dio_client.dart';
import '../../repository/cached_data.dart';
import '../../src/auth/registration/registration_model/account_verify_model.dart';

class DioServices {
  CachedData cachedData = CachedData();
  late Dio dioNetWorkServices;
  DioServices() {
    dioNetWorkServices = DioClient().dio;
  }

  Future<Response> registerUser(
      {required String phoneNumber, required String password}) async {
    var postBody = jsonEncode({
      'phone_number': phoneNumber,
      'password': password,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/create-account", data: postBody);
    return response;
  }

  Future<Response> resetPin(
      {required String currentPin,
      required String resetPin,
      required String confirmResetPin}) async {
    var postBody = jsonEncode({
      'current_pim': currentPin,
      'new_pin': resetPin,
      'new_pin_confirmation': confirmResetPin,
    });
    final response = await dioNetWorkServices
        .patch("/api/v1/account/change-pin", data: postBody);
    return response;
  }

  Future<Response> collectEmergencyContact(
      {required String name,
      required String email,
      required String relationship,
      required String address,
      required String phoneNumber}) async {
    var postBody = jsonEncode({
      'name': name,
      'email': email,
      'relationship': relationship,
      'contact_address': address,
      'phone_number': phoneNumber
    });
    final response = await dioNetWorkServices.post("/api/v1/emergency-contacts",
        data: postBody);
    return response;
  }

  Future<Response> loginUser(
      {required String phoneNumber, required String password}) async {
    var postBody = jsonEncode({
      'phone_number': phoneNumber,
      'password': password,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/login", data: postBody);
    return response;
  }

  Future<Response> acquireLoan({required String packageId}) async {
     var postBody = jsonEncode({
      'loan_package': packageId,
    });
    final response = await dioNetWorkServices
        .post("/api/v1/loan_packages", data: postBody);
    return response;
  }

  Future<Response> createTransactionPin({required String pin}) async {
    String? token = await cachedData.getAuthToken();
    var postBody = jsonEncode({
      'pin': pin,
    });
    final response = await dioNetWorkServices.post("/api/v1/account/create-pin",
        options: token != null
            ? Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  "authorization": "Bearer ${token}",
                },
              )
            : Options(),
        data: postBody);
    return response;
  }

  Future<Response> updateAccount(
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
    var postBody = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender,
      'marital_status': maritalStatus,
      'religion': religion,
      'highest_edu_level': educationalLevel,
      'residential_address': residentialAddress,
      'date_of_birth': dateOfBirth,
    });
    final response =
        await dioNetWorkServices.patch("/api/v1/account", data: postBody);
    return response;
  }

  Future<Response> verifyOtp(
      {required String phoneNumber, required String otp}) async {
    var postBody = jsonEncode({
      'phone_number': phoneNumber,
      'otp': otp,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/validate-otp", data: postBody);
    print(response.data);
    return response;
  }

  Future<Response> getUserPersonalData() async {
    final response = await dioNetWorkServices.get("/api/v1/account");
    return response;
  }

  Future<Response> getContactFile(
      {required Map<dynamic, dynamic> contactList}) async {
    var formData = jsonEncode({'contacts': contactList});
    final response = await dioNetWorkServices.post("/api/v1/contacts/import",
        data: formData);
    return response;
  }

  Future<Response> getEmergencyContacts() async {
    final response = await dioNetWorkServices.get("/api/v1/emergency-contacts");
    return response;
  }

  Future<Response> getFaq() async {
    final response = await dioNetWorkServices.get("/api/v1/misc/faqs");
    return response;
  }

  Future<Response> getTermsAndServices() async {
    final response =
        await dioNetWorkServices.get("/api/v1/misc/pages/terms-of-service");
    return response;
  }

  Future<Response> getDisclaimer() async {
    final response =
        await dioNetWorkServices.get("/api/v1/misc/pages/disclaimer");
    return response;
  }

  Future<Response> getPrivacyPolicy() async {
    final response =
        await dioNetWorkServices.get("/api/v1/misc/pages/privacy-policy");
    return response;
  }

  Future<Response> verifyBVN(
      {required String bvn,
      required String firstname,
      required String lastname}) async {
    String? token = await cachedData.getAuthToken();
    var postBody =
        jsonEncode({'bvn': bvn, 'firstname': firstname, 'lastname': lastname});
    debugPrint(postBody);
    final response =
        await dioNetWorkServices.post("/api/v1/account/verify-my-bvn",
            options: token != null
                ? Options(
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                      "authorization": "Bearer ${token}",
                    },
                  )
                : Options(),
            data: postBody);
    print("return");
    return response;
  }

  Future<Response> confirmBVN({
    required String reference,
  }) async {
    String? token = await cachedData.getAuthToken();
    var postBody = jsonEncode({
      'reference': reference,
    });
    //debugPrint("reference$reference");
    //debugPrint("postbody$postBody");
      final response =
      await dioNetWorkServices.post("/api/v1/account/bvn_consent",
           options: token != null
              ? Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              "authorization": "Bearer ${token}",
            },
          )
              : Options(),
          data: postBody);

    /*/print(response);
    response.data.forEach((key, value){
      print('$key: $value');
    });
    print(response.runtimeType);
    print("========================");*/

    return response;
  }



  Future<Response> sendPasswordResetCode(
      {required String resetPasswordPhoneNumber}) async {
    var postBody = jsonEncode({
      'phone_number': resetPasswordPhoneNumber,
    });
    final response = await dioNetWorkServices.post("/api/v1/recover-password",
        data: postBody);
    return response;
  }

  Future<Response> validateResetCode(
      {required String resetPasswordPhoneNumber, required String code}) async {
    var postBody =
        jsonEncode({'phone_number': resetPasswordPhoneNumber, 'code': code});
    final response = await dioNetWorkServices
        .post("/api/v1/validate-reset-code", data: postBody);
    return response;
  }

  Future<Map<String, dynamic>> checkTransactionStatus(
      String transactionId) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://phincash.cloud/api/v1/check-transaction-status/$transactionId',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error response here
        print('Failed to verify transaction');
        return {}; // You can return an empty map or throw an exception as needed
      }
    } catch (e) {
      // Handle Dio errors or network exceptions here
      print('Error: $e');
      return {}; // You can return an empty map or throw an exception as needed
    }
  }

      Future<Response> resendLoginOtp({required String phoneNumber}) async {
    var postBody = jsonEncode({
      'phone_number': phoneNumber,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/resend-otp", data: postBody);
    return response;
  }

  Future<Response> saveBankDetails(
      {required String accountName,
      required String accountNumber,
      required String bankName,
      required String bankCode,
      String? bvn}) async {
    var postBody = jsonEncode({
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
      'bank_code': bankCode,
      "bvn": bvn
    });
    final response =
        await dioNetWorkServices.post("/api/v1/bank-accounts", data: postBody);
    return response;
  }

  Future<Response> saveCardDetails(
      {
  /*required String cardNumber,
      required String cvv,
      required String expiryMonth,
      required String expiryYear,*/
      String? bvn}) async {
    var postBody = jsonEncode({
      /*'cardNo': cardNumber,
      'cvv': cvv,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,*/
      'amount': 100
    });
    print("PostBody:");
    print(postBody);
    final response =
        await dioNetWorkServices.post("/api/v1/add-cards", data: postBody);
        print("addcard response - $response");
    return response;
  }

  Future<Response> saveVerifiedBankDetails(
      {required String accountName,
      required String accountNumber,
      required String bankName,
      required String bankCode,
      String? dob,
      String? userPhone,
      String? bvn}) async {
    var postBody = jsonEncode({
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
      'bank_code': bankCode,
      "bvn": bvn,
      "user_phone": userPhone,
      "date_of_birth": dob,
      // "bvn_status": true,
      //"account_verify_status": true,
    });
    print(postBody);
    final response = await dioNetWorkServices
        .post("/api/v1/user/account/verified-account-details", data: postBody);
    return response;
  }

  Future<AccountVerifyModel> verifyBankDetails({
    required String accountNumber,
    required String bankCode,
  }) async {
    var postBody = jsonEncode({
      'account_number': accountNumber,
      'account_bank': bankCode,
    });
    final response = await dioNetWorkServices
        .post("/api/v1/verify-my-bank-account", data: postBody);
    print(response.data);
    return AccountVerifyModel.fromJson(response.data);
  }

  Future<Response> withdrawFunds(
      {required String pin,
      required int amount,
      required String bankId}) async {
    var postBody = jsonEncode({
      'pin': pin,
      'amount': amount,
      'bank_account_id': bankId,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/withdraw", data: postBody);
    return response;
  }

  Future<Response> verifyUserData() async {
    final response = await dioNetWorkServices.post("/api/v1/identity/verify");
    return response;
  }

  Future<Response> deletedBankAccount({required String? bankId}) async {
    final response = await dioNetWorkServices
        .delete("/api/v1/bank-accounts/$bankId");
    return response;
  }

  Future<Response> resetAccountPassword(
      {required String resetPasswordPhoneNumber,
      required String code,
      required String password,
      required String confirmPassword}) async {
    var postBody = FormData.fromMap({
      'phone_number': resetPasswordPhoneNumber,
      'code': code,
      'password': password,
      'password_confirmation': confirmPassword
    });
    final response =
        await dioNetWorkServices.post("/api/v1/reset-password", data: postBody);
    return response;
  }

  Future<Response> getTransaction() async {
    final response = await dioNetWorkServices.get("/api/v1/transactions");
    return response;
  }

  Future<Response> getSupportedBanks() async {
    final response = await dioNetWorkServices.get("/api/v1/misc/banks");
    return response;
  }

  Future<Response> onBoardingStage({required String onBoardStage}) async {
    var postBody = jsonEncode({
      'onboard_stage': onBoardStage,
    });
    final response = await dioNetWorkServices
        .patch("/api/v1/account/change-onboard-stage", data: postBody);
    return response;
  }

  Future<Response> depositFundToWallet({required String amount}) async {
    var postBody = jsonEncode({
      'amount': amount,
    });
    final response =
        await dioNetWorkServices.post("/api/v1/deposit", data: postBody);
    return response;
  }

  Future<Response> getAppSettings() async {
    final response = await dioNetWorkServices.get("/api/v1/misc/settings");
    return response;
  }

  Future<Response> getLoanHistory() async {
    final response = await dioNetWorkServices.get("/api/v1/loans");
    return response;
  }

  Future<Response> getBankAccounts() async {
    final response = await dioNetWorkServices.get("/api/v1/bank-accounts");
    return response;
  }

  Future<Response> getLoanPackages() async {
    String? token = await cachedData.getAuthToken();
    final response = await dioNetWorkServices.get(
      "/api/v1/loan_packages",
      options: token != null
          ? Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                "authorization": "Bearer ${token}",
              },
            )
          : Options(),
    );
    return response;
  }

  Future<Response> getNotification() async {
    final response = await dioNetWorkServices.get("/api/v1/notifications");
    return response;
  }

  Future<Response> getLoanDetails({required String loanId}) async {
    final response = await dioNetWorkServices.get("/api/v1/loan_packages/$loanId");
    return response;
  }

  Future<Response> repayLoan({required String loanId}) async {
    final response =
        await dioNetWorkServices.post("/api/v1/loans/$loanId/repay");
    return response;
  }

  Future<String> uploadImage(File file) async {
    String? token = await cachedData.getAuthToken();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile_image":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response =
        await dioNetWorkServices.post("/api/v1/account/upload-profile-photo",
            options: token != null
                ? Options(
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                      "authorization": "Bearer ${token}",
                    },
                  )
                : Options(),
            data: formData);
    return response.data['status'];
  }
}
