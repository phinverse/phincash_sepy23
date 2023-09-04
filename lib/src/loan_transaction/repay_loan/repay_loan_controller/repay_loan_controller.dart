import 'package:get/get.dart';

class RepayLoanController extends GetxController{
  final List<String> paymentMethod = ["Bank transfer", "Debit card"];
  final List<String> cardList = ["**** **** 8921 8900", "**** **** 8324 8900"];
  Object? onSelected;
  int? selectedIndex;
  String? selectedPaymentMethod;
  String? selectedCard;

  void selectCard(int index){
    Get.back();
      selectedCard = cardList[index];
      update();
  }
  void selectPaymentMethod(int index){
    Get.back();
      selectedPaymentMethod = paymentMethod[index];
      update();
  }
  void selectLoanOption(int index){
      selectedIndex = index;
      update();
  }
  void onChangeLoanOption(Object value){
      onSelected = value;
      update();
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }
}