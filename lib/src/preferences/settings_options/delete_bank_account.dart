import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/loan_withdrawal/loan_withdrawal_controller/withdrawal_controller.dart';
import '../../../constants/app_string.dart';
import '../../../constants/asset_path.dart';
import '../../../constants/colors.dart';
import '../../loan_transaction/loan_withdrawal/views/add_bank_account.dart';

class DeleteBankAccount extends StatefulWidget {
  const DeleteBankAccount({Key? key}) : super(key: key);

  @override
  State<DeleteBankAccount> createState() => _DeleteBankAccountState();
}

class _DeleteBankAccountState extends State<DeleteBankAccount> {
  final _withdrawalController = Get.put(WithdrawalController());

  Future<bool> _onWillPop({required int index}) async {
    Widget cancelButton = TextButton(
      child: const Text("NO", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("YES", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
        _withdrawalController.deleteAccount(bankId: _withdrawalController.transactionController.bankAccounts![index].id.toString());
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete Account", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kPrimaryColor, fontSize: 23, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.bold,)),
      content: Text("Are you sure you want to delete this bank account?",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle,)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return (await showDialog(
      context: context,
      builder: (context) => alert,
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: GetBuilder<WithdrawalController>(
          init: WithdrawalController(),
            builder: (controller){
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("Disbursement Account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(()=> const AddBankAccount());
                    },
                    child: Card(
                      child: Container(
                        width: double.maxFinite,
                        height: 45, padding: EdgeInsets.all(10),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add bank account", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16, fontFamily: AppString.latoFontStyle),),
                            Icon(Icons.add, color: kPrimaryColor, size: 25,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  _withdrawalController.transactionController.bankAccounts!.isEmpty || _withdrawalController.transactionController.bankAccounts == null ?
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child:   Container(padding: const EdgeInsets.all(40),height: MediaQuery.of(context).size.height / 2, width: double.maxFinite,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetPath.noRecords,height: 150, width: 150,),
                            const SizedBox(height: 15,),
                            Text("No history yet", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                            const SizedBox(height: 15,),
                            const Text("They will appear once there’s any", style: TextStyle(color: Color(0xFFA6A6AA), fontSize: 12, fontWeight: FontWeight.w200, fontFamily: AppString.latoFontStyle),),
                          ],
                        ),
                      )
                  ) : SingleChildScrollView(
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(_withdrawalController.transactionController.bankAccounts!.length, (index){
                              return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10), color: Color(0xffA6A6AA).withOpacity(0.3),
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(_withdrawalController.transactionController.bankAccounts![index].bankName!,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kPrimaryColor, fontSize: 18,
                                                    fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                              const SizedBox(height: 10,),
                                              Text(_withdrawalController.transactionController.bankAccounts![index].accountNumber!,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54, fontSize: 12,
                                                    fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                              const SizedBox(height: 10,),
                                              Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(_withdrawalController.transactionController.bankAccounts![index].accountName!,
                                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54, fontSize: 12,
                                                        fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                                  const SizedBox(width: 40,),
                                                  Icon(Icons.account_balance_outlined, color: kPrimaryColor, size: 20,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    _onWillPop(index: index);
                                  }, icon: Icon(Icons.delete_outline_rounded, color: Colors.red, size: 25,))
                                ],
                              );
                            })
                          ],
                        ),
                      )
                ],
              ),
            ),
          );
        })
    );
  }
}
