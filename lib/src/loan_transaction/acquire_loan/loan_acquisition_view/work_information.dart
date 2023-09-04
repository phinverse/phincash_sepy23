import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/loan_acquisition_view/personal_information.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';


class WorkInformation extends StatefulWidget {
  const WorkInformation({Key? key}) : super(key: key);

  @override
  State<WorkInformation> createState() => _WorkInformationState();
}

class _WorkInformationState extends State<WorkInformation> {
  final List<String> _employmentStatus = ["Unemployed", "Employed"];

  final List<String> _companyCategory = ["Government/Public", "Finance", "Health", "Military/Police/Security", "Construction/Manufacture", "Fashion/ Entertainment", "Farming", "Others"];
  String? _selectedEmploymentStatus;
  String? _selectedCompanyCategory;
  DateTime? selectedWorkStartDate;
  DateTime? selectedSalaryDate;
  bool isWorkStartDatePicked = false;
  bool isSalaryDatePicked = false;

  Future <void> pickWorkStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState((){
        selectedWorkStartDate = picked;
        isWorkStartDatePicked = true;
      });
    }
  }

  Future <void> pickSalaryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState((){
        selectedSalaryDate = picked;
        isSalaryDatePicked = true;
      });
    }
  }

  Widget dateStartDateForm (BuildContext c){
    String getDate(String? date){
      final formattedDate = Jiffy(date).yMMMMEEEEd;
      return formattedDate;
    }
    return Container(height: 55, width: double.maxFinite,
      decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: ()=> pickWorkStartDate(c),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isWorkStartDatePicked == false ? const Text("When did you started living there?", style: TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),) :
              Text(getDate(selectedWorkStartDate.toString()), style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54)
            ],
          ),
        ),
      ),
    );
  }

  Widget salaryDateForm (BuildContext c){
    String getDate(String? date){
      final formattedDate = Jiffy(date).yMMMMEEEEd;
      return formattedDate;
    }
    return Container(height: 55, width: double.maxFinite,
      decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: ()=> pickSalaryDate(c),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isSalaryDatePicked == false ? const Text("Salary Date", style: TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),) :
              Text(getDate(selectedSalaryDate.toString()), style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54)
            ],
          ),
        ),
      ),
    );
  }

  void showEmploymentStatusBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 250, children:
    List.generate(_employmentStatus.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedEmploymentStatus = _employmentStatus[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_employmentStatus[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedEmploymentStatus == _employmentStatus[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }
  void showCompanyCategoryBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 400, children:
    List.generate(_companyCategory.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedCompanyCategory = _companyCategory[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_companyCategory[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedCompanyCategory == _companyCategory[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Work Information",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(flex: 2,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                    child: Text("Kindly provide your work information to get a better loan offer as soon as possible",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                const Spacer(),
                Container(height: 55, width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                    onPressed: (){
                      showEmploymentStatusBottomSheet(context);
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedEmploymentStatus ?? "Employment status", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(height: 55, width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                    onPressed: (){
                      showCompanyCategoryBottomSheet(context);
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedCompanyCategory ?? "Company Category", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                FormFieldWidget(
                  labelText: "Job title",
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                ),
                const SizedBox(height: 30,),
                dateStartDateForm(context),
                const SizedBox(height: 30,),
                FormFieldWidget(
                  labelText: "Monthly income",
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                ),
                const SizedBox(height: 30,),
                salaryDateForm(context),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_outlined, color: kPrimaryColorLight,),
                    const SizedBox(width: 20,),
                    Text("Phincash security guarantee", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle),),
                  ],
                ),
                const Spacer(),
                ButtonWidget(
                    onPressed: (){
                      Get.to(()=> const PersonalInformation());
                    },
                    buttonText: "Continue",
                    height: 60, width: double.maxFinite
                ),
                const Spacer(flex: 8,),
              ],
            ),
          ),
        )
    );
  }
}
