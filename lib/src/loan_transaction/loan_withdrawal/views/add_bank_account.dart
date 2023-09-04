import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/widget/button_widget.dart';
import 'package:phincash/widget/formfield_widget.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/helpers/flushbar_helper.dart';
import '../../../../widget/bottom_sheet.dart';
import '../loan_withdrawal_controller/withdrawal_controller.dart';
class AddBankAccount extends StatefulWidget {
  const AddBankAccount({Key? key}) : super(key: key);

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  @override
  Widget build(BuildContext context) {

    final _withdrawalController = Get.put(WithdrawalController());

    void showBankBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(height: 5, width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),),
            const SizedBox(height: 30,),
            Align(alignment: Alignment.centerLeft,
                child: Text("Supported Banks", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),)),
            const SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(_withdrawalController.registrationController.supportedBanks!.length, (index){
                        return InkWell(
                          onTap: (){
                            _withdrawalController.selectBank(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_withdrawalController.registrationController.supportedBanks![index].name!, style: const TextStyle(color: Colors.black, fontSize: 14),),
                                _withdrawalController.selectedBank == _withdrawalController.registrationController.supportedBanks![index].name ? Container(height: 14, width: 14,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                                  child: const Icon(Icons.check, size: 12, color: Colors.white,),
                                ): const SizedBox()
                              ],
                            ),
                          ),);
                      },)
                    ]
                ),
              ),
            ),
          ],
        ),
      );
    }

    // void showBankDropDown(){
    //   DropDownState(
    //     DropDown(
    //       submitButtonText: "Done",
    //       searchHintText: "Search",
    //       bottomSheetTitle: "Select Bank",
    //       searchBackgroundColor: Colors.black12,
    //       dataList: _withdrawalController.banks,
    //       selectedItems: (List<dynamic> selectedList) {
    //         print(selectedList.toString());
    //       },
    //       selectedItem: (String selected) {
    //         setState(() {
    //           _withdrawalController.selectedBank = selected;
    //         });
    //       },
    //       enableMultipleSelection: false,
    //       searchController: _withdrawalController.searchTextEditingController,
    //     ),
    //   ).showModal(context);
    // }
    return GetBuilder<WithdrawalController>(
      init: WithdrawalController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(resizeToAvoidBottomInset: false,
          key: _withdrawalController.scaffoldKeyAddBankAccount,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Bank Account",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _withdrawalController.formKeyAddBankAccount,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0,10.0,24.0,0.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.8, minHeight: 50),
                        child: Text("Kindly provide one of your bank accounts that can receive the money.",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black87, fontWeight: FontWeight.w400),)),
                    const SizedBox(height: 10,),
                    FormFieldWidget(
                      controller: _withdrawalController.accountNameController,
                      prefixIcon: Icon(Icons.person, color: Colors.black45, size: 25,),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      labelText: "Bank Account Name",
                      validator: (value) => value!.isEmpty ? "Please enter Account Name": null,

                      labelStyle:const TextStyle(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),
                    ),
                    const SizedBox(height: 25,),
                    Container(height: 67, width: double.maxFinite,
                      padding: EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(border: Border.all(color: kPrimaryColorLight, width: 0.7), borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance, color: Colors.black45,),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                              onPressed: (){
                                showBankBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_withdrawalController.selectedBank ?? "Name of your Bank",
                                    style: TextStyle(color: _withdrawalController.selectedBank == null || _withdrawalController.selectedBank == "Name of your bank" ?
                                    Colors.black45 : Colors.black87, fontSize: 14, fontFamily: AppString.latoFontStyle),),

                                  const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    FormFieldWidget(
                      controller: _withdrawalController.accountNumberController,
                      prefixIcon: Icon(Icons.pin, color: Colors.black45, size: 25,),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      labelText: "Bank Account Number",
                      validator: (value) => value!.isEmpty ? "Please enter Account Number": null,
                      labelStyle:const TextStyle(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),
                    ),
                    const SizedBox(height: 25,),

                    // Container(height: 67, width: double.maxFinite,
                    //   padding: EdgeInsets.only(left: 8.0),
                    //   decoration: BoxDecoration(border: Border.all(color: kPrimaryColorLight, width: 0.7), borderRadius: BorderRadius.circular(15)),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.branding_watermark, color: Colors.black45,),
                    //       Expanded(
                    //         child: TextButton(
                    //           style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                    //           onPressed: (){},
                    //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(_withdrawalController.bankCCVCode ?? "CCV Code",
                    //                 style: TextStyle(color: _withdrawalController.bankCCVCode == null || _withdrawalController.bankCCVCode == "CCV Code" ?
                    //                 Colors.black45 : Colors.black87, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                    //
                    //               const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock_outlined, color: kPrimaryColorLight, size: 25,),
                        const SizedBox(width: 10,),
                        Text("Phincash security guarantee", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 14, color: Colors.black45,),),
                      ],
                    ),
                    const SizedBox(height: 35,),
                    ButtonWidget(
                        onPressed: (){
                          if(_withdrawalController.selectedBank == null || _withdrawalController.bankCCVCode == null){
                            FlushBarHelper(Get.context!).showFlushBar("Please Select a Bank");
                          }else{
                            _withdrawalController.addAccount();
                          }
                        },
                        buttonText: "Save",
                        height: 48, width: double.maxFinite
                    ),

                  ],),
              ),
            ),
          ),
        ),
      );
    });
  }
}
