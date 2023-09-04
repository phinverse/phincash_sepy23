import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/model/loan_acquisition_response_data.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/widget/loan_acquisition_declined_dialog.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/widget/loan_approval_pending.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import '../../../../repository/cached_data.dart';
import '../../../../services/dio_service_config/dio_error.dart';
import '../../../../services/dio_services/dio_services.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../utils/helpers/progress_dialog_helper.dart';
import '../../../auth/models/user_personal_data.dart';
import '../widget/loan_acquisition_success_dialog.dart';

class LoanAcquisitionController extends GetxController{
  final transactionController = Get.find<TransactionController>();
  String? selectedLoanAmount;
  String? selectedRepaymentPeriod;
  String? loanInterestRate;
  String? packageId;
  CachedData cachedData = CachedData();
  // final _controller = Get.put(PrivacyPolicyController());

  void selectLoanPackages(int index){
    Get.back();
    selectedLoanAmount = transactionController.loanPackages![index].amount.toString();
    selectedRepaymentPeriod = transactionController.loanPackages![index].duration.toString();
    loanInterestRate = transactionController.loanPackages![index].interestRate.toString();
    packageId = transactionController.loanPackages![index].id.toString();
    update();
  }

  AcquireLoanPackage()async{
    ProgressDialogHelper().showProgressDialog(Get.context!, "Processing Loan...");
    try{
      await DioServices().acquireLoan(packageId: packageId!).then((value) async{
        final response = LoanAcquisitionResponseData.fromJson(value.data);
        if(response.data?.status == "disbursed"){
          await getUserPersonalData().then((value) async {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(()=> const HomeScreen());
            LoanSuccessDialog().showSuccessDialog(Get.context!);
          });
        }else if (response.data?.status == "pending"){
          await getUserPersonalData().then((value) async {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(()=> const HomeScreen());
            LoanApprovalPendingDialog().showApprovalDialog(Get.context!);
          });
        } else {
          await getUserPersonalData().then((value) async {
            ProgressDialogHelper().hideProgressDialog(Get.context!);
            Get.offAll(()=> const HomeScreen());
            LoanDeclinedDialog().showLoanDeclinedDialog(Get.context!);
          });
        }
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

  @override
  void onInit() {
    update();
    super.onInit();
  }
}