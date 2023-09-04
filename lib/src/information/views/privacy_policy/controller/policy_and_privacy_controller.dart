import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:phincash/src/information/views/privacy_policy/model/disclaimer_model.dart';
import 'package:phincash/src/information/views/privacy_policy/model/privacy_policy_model.dart';
import 'package:phincash/src/information/views/privacy_policy/model/terms_and_services_model.dart';
import '../../../../../services/dio_service_config/dio_error.dart';
import '../../../../../services/dio_services/dio_services.dart';
import '../../../../loan_transaction/transactions/models/app_setting_response_model.dart';

class PrivacyPolicyController extends GetxController{
  PrivacyPolicyResponseData? policyResponseData;
  DisclaimerResponseData? disclaimerResponseData;
  TermsAndServicesResponseData? termsAndServicesResponseData;
  AppSettingsResponseData? appSettingsResponseData;
  getPrivacyPolicy()async{
    try{
      await DioServices().getPrivacyPolicy().then((value){
        policyResponseData = PrivacyPolicyResponseData.fromJson(value.data);
        update();
      });
    }on DioError catch (err){
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err){
      throw err.toString();
    }
  }

  getDisclaimer()async{
    try{
      await DioServices().getDisclaimer().then((value){
        disclaimerResponseData = DisclaimerResponseData.fromJson(value.data);
        update();
      });
    }on DioError catch (err){
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err){
      throw err.toString();
    }
  }

  getTermsAndServices()async{
    try{
      await DioServices().getTermsAndServices().then((value){
        termsAndServicesResponseData = TermsAndServicesResponseData.fromJson(value.data);
        update();
      });
    }on DioError catch (err){
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err){
      throw err.toString();
    }
  }

  GetAppSettings()async{
    try{
      await DioServices().getAppSettings().then((value){
        appSettingsResponseData = AppSettingsResponseData.fromJson(value.data);
        update();
      });
    }on DioError catch (err){
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (err){
      throw err.toString();
    }
  }

  @override
  void onInit() {
    getTermsAndServices();
    getDisclaimer();
    getPrivacyPolicy();
    GetAppSettings();
    update();
    super.onInit();
  }
}