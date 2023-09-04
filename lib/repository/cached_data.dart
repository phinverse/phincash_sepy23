import 'dart:convert';
import 'package:phincash/src/auth/registration/registration_model/bvn_response_model.dart';
import 'package:phincash/src/preferences/model/emergency_contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/auth/models/user_personal_data.dart';
import '../src/auth/registration/registration_model/bvn_consent_model.dart';

class CachedData {
  Future<String?> getAuthToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    return token;
  }

  Future<bool?> getCsvUpLoadStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool? csvStatus = sharedPreferences.getBool("isUpLoadingCsv");
    return csvStatus;
  }

  Future<void> cacheCsvUploadStatus({required bool isUpLoadingCsv}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isUpLoadingCsv", isUpLoadingCsv);
  }

  Future<void> cacheAuthToken({required String? token}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token!);
  }

  Future<void> cacheEmergencyContact(
      {required EmergencyContactData emergencyContactData}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "emergency-contact", json.encode(emergencyContactData.toJson()));
  }

  Future<EmergencyContactData?> getEmergencyContact() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? emergencyContactData =
        sharedPreferences.getString("emergency-contact");
    return emergencyContactData == null
        ? null
        : EmergencyContactData.fromJson(jsonDecode(emergencyContactData));
  }

  Future<void> cacheUserPersonalData(
      {required UserPersonalData userPersonalData}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "doctorDetails", json.encode(userPersonalData.toJson()));
  }

  Future<UserPersonalData?> getUserPersonalData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString("doctorDetails");
    return userData == null
        ? null
        : UserPersonalData.fromJson(jsonDecode(userData));
  }

  Future<bool> getLoginStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool? userData = sharedPreferences.getBool("isLoggedIn");
    return userData ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", isLoggedIn);
  }

  Future<void> cacheBvnRequestDetails(
      {required BvnResponse bvnResponse}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "bvnrequest", json.encode(bvnResponse.toJson()));
  }

  Future<BvnResponse?> getBvnRequestDetails() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? bvnResponse = sharedPreferences.getString("bvnrequest");
    return bvnResponse == null
        ? null
        : BvnResponse.fromJson(jsonDecode(bvnResponse));
  }
   Future<void> cacheBvnConsentDetails(
      {required BvnConsent bvnConsent}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "bvnconsent", json.encode(bvnConsent.toJson()));
  }
   Future<BvnConsent?> getBvnConsentDetails() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? bvnConsent = sharedPreferences.getString("bvnconsent");
    return bvnConsent == null
        ? null
        : BvnConsent.fromJson(jsonDecode(bvnConsent));
  }

// Future<void> saveUserDetails({required UserDetails userDetails}) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setString("saveUserDetails", jsonEncode(userDetails.toJson()));
// }
// Future<UserDetails> fetchUserDetails() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   String? userData = sharedPreferences.getString("saveUserDetails");
//   return UserDetails.fromJson(jsonDecode(userData!));
// }
}
