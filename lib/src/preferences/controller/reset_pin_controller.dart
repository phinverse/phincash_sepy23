import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:phincash/repository/cached_data.dart';
import '../../../services/dio_service_config/dio_error.dart';
import '../../../services/dio_services/dio_services.dart';
import '../../../utils/helpers/flushbar_helper.dart';
import '../../../utils/helpers/progress_dialog_helper.dart';
import 'package:flutter/material.dart';
import '../../auth/models/user_personal_data.dart';
import '../../loan_transaction/transactions/transaction_views/home_screen.dart';

class ResetPinController extends GetxController{
  String? currentPin;
  String? resetPin;
  String? confirmResetPin;
  CachedData cachedData = CachedData();
  // EmergencyContactData? emergencyContactData;
  final emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  List<String> nextOfKinRelationshipList = ["Friends", "Sibling", "Colleagues", "Relatives", "Classmates", "Others"];
  final TextEditingController nextOfKinEmail = TextEditingController();
  final TextEditingController nextOfKinName = TextEditingController();
  final TextEditingController nextOfKinAddress = TextEditingController();
  final TextEditingController nextOfKinPhoneNumber = TextEditingController();
  String? nextOfKinRelationship;

  final TextEditingController secondNextOfKinEmail = TextEditingController();
  final TextEditingController secondNextOfKinName = TextEditingController();
  final TextEditingController secondNextOfKinAddress = TextEditingController();
  final TextEditingController secondNextOfKinPhoneNumber = TextEditingController();
  String? secondNextOfKinRelationship;

  // Future<EmergencyContactData> fetchContacts() async {
  //   EmergencyContactData? data;
  //   await cachedData.getEmergencyContact().then((value) {
  //     data = value;
  //   });
  //   return data!;
  // }

  // _initData() async {
  //   await fetchContacts().then((value) {
  //     emergencyContactData = value;
  //     update();
  //   });
  // }


  // @override
  // void onInit() {
  //   _initData();
  //   update();
  //   super.onInit();
  // }

  void selectFirstNextOFKin(int index){
    Get.back();
    nextOfKinRelationship = nextOfKinRelationshipList[index];
    update();
  }

  void selectSecondNextOfKin(int index){
    Get.back();
    secondNextOfKinRelationship = nextOfKinRelationshipList[index];
    update();
  }

  final formKey = GlobalKey <FormState>();
  final scaffoldKey= GlobalKey <ScaffoldState>();

  // Future<void> updateNextOfKin()async{
  //   ProgressDialogHelper().showProgressDialog(Get.context!, "Saving Contact Details...");
  //   try{
  //     await DioServices().collectEmergencyContact(name: nextOfKinName.text, email: nextOfKinEmail.text,
  //         relationship: nextOfKinRelationship!, address: nextOfKinAddress.text, phoneNumber: nextOfKinPhoneNumber.text).whenComplete(() async{
  //       ProgressDialogHelper().hideProgressDialog(Get.context!);
  //       Get.offAll(()=> const CollectUserBankDetails());
  //       });
  //   }on DioError catch (err){
  //     final errorMessage = DioException.fromDioError(err).toString();
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.response?.data["message"] ?? errorMessage);
  //     throw errorMessage;
  //   } catch (err){
  //     ProgressDialogHelper().hideProgressDialog(Get.context!);
  //     FlushBarHelper(Get.context!).showFlushBar( err.toString());
  //     throw err.toString();
  //   }
  // }

  Future <void> getUserPersonalData() async {
    try {
      await DioServices().getUserPersonalData().then((value) async {
        await cachedData.cacheUserPersonalData(userPersonalData: UserPersonalData.fromJson(value.data));
      });
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar( err.response?.data["message"] ?? errorMessage);
      throw errorMessage;
    }catch (err){
      ProgressDialogHelper().hideProgressDialog(Get.context!);
      FlushBarHelper(Get.context!).showFlushBar( err.toString());
      throw err.toString();
    }
  }

  changePin()async{
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing...");
    try{
      await DioServices().resetPin(currentPin: currentPin!, resetPin: resetPin!, confirmResetPin: confirmResetPin!).then((value) async {
        await getUserPersonalData().then((value) async {
          ProgressDialogHelper().hideProgressDialog(Get.context!);
          Get.offAll(()=> const HomeScreen());
          FlushBarHelper(Get.context!).showFlushBar("Your PIN reset was successful", borderColor: Colors.green, messageColor: Colors.green,
              color: Colors.white,icon: Icon(Icons.check_circle, color: Colors.green, size: 30,));
        });
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
}