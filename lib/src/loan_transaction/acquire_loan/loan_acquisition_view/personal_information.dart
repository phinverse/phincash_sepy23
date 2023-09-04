import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/loan_acquisition_view/bvn_authication.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';


class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  Object? onYesSelected;
  String? _selectedMaritalStatus;
  String? _selectedEducationLevel;
  String? _selectedResidentialStatus;
  String? _selectedLanguage;
  String? _selectedReligion;
  DateTime? _selectedDateForResidentialLiving;
  bool _selectedDateForResidentialLivingPicked = false;
  final List<String> _maritalStatus = ["Single", "Married", "Divorced"];
  final List<String> _educationLevel = ["OND", "HND", "BSC", "SSCE"];
  final List<String> _residentialStatus = ["House owner","Tenant"];
  final List<String> _language = ["English", "Igbo" "Yoruba", "Hausa"];
  final List<String> _religion = ["Christianity", "Islam", "Others"];

  Future <void> pickWorkStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState((){
        _selectedDateForResidentialLiving = picked;
        _selectedDateForResidentialLivingPicked = true;
      });
    }
  }

  Widget dateWhenYouStartedLivingInYourResidenceForm (BuildContext c){
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
              _selectedDateForResidentialLivingPicked == false ? const Text("When did you start living there?", style: TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),) :
              Text(getDate(_selectedDateForResidentialLiving.toString()), style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54)
            ],
          ),
        ),
      ),
    );
  }

  void showReligionBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 250, children:
    List.generate(_religion.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedReligion = _religion[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_religion[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedReligion == _religion[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }

  void showResidentialStatusBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 250, children:
    List.generate(_residentialStatus.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedResidentialStatus = _residentialStatus[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_residentialStatus[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedResidentialStatus == _residentialStatus[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }

  void showEducationLevelBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 350, children:
    List.generate(_educationLevel.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedEducationLevel = _educationLevel[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_educationLevel[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedEducationLevel == _educationLevel[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }

  void showLanguageBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 300, children:
    List.generate(_language.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedLanguage = _language[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_language[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedLanguage == _language[index] ? Container(height: 18, width: 18,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(Icons.check, size: 12, color: Colors.white,),
              ): const SizedBox()
            ],
          ),
        ),);
    },));
  }


  void showMaritalStatusBottomSheet(BuildContext context){
    MyBottomSheet().showDismissibleBottomSheet(context: context, height: 300, children:
    List.generate(_maritalStatus.length, (index){
      return InkWell(
        onTap: (){
          Get.back();
          setState((){
            _selectedMaritalStatus = _maritalStatus[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_maritalStatus[index], style: const TextStyle(color: Colors.black, fontSize: 17),),
              _selectedMaritalStatus == _maritalStatus[index] ? Container(height: 18, width: 18,
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
        child: Scaffold(resizeToAvoidBottomInset: false,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Personal Information", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){
              Get.back();
              },
                icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                    child: Text("Kindly provide your work information to get a better loan offer as soon as possible",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                    )),
                const SizedBox(height: 30,),
                Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Gender", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 18, fontWeight: FontWeight.w400)),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Radio(value: "Male", groupValue: onYesSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      onYesSelected = value;
                                    });
                                  },
                                  activeColor: kPrimaryColor,
                                ),
                              ),
                              const Text("Male", style: TextStyle(fontSize: 16, fontFamily: AppString.latoFontStyle, color: Color(0xFF25282B)),),
                              const SizedBox(width: 15,),
                              SizedBox(
                                child: Radio(value: "Female", groupValue: onYesSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      onYesSelected = value;
                                    });
                                  },
                                  activeColor: kPrimaryColor,
                                ),
                              ),
                              const Text("Female", style: TextStyle(fontSize: 16, fontFamily: AppString.latoFontStyle, color: Color(0xFF25282B)),),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Container(height: 55, width: double.maxFinite,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                            child: TextButton(
                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                              onPressed: (){
                                showEducationLevelBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedEducationLevel ?? "Highest Education Level", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
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
                                showMaritalStatusBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedMaritalStatus ?? "Marital Status", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
                                  const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          FormFieldWidget(
                            labelText: "Number of children",
                            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                          ),
                          const SizedBox(height: 30,),
                          FormFieldWidget(
                            labelText: "Email",
                            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                          ),
                          const SizedBox(height: 30,),

                          FormFieldWidget(
                            labelText: "Home address",
                            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                          ),
                          const SizedBox(height: 30,),

                          Container(height: 65, width: double.maxFinite,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                            child: TextButton(
                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                              onPressed: (){
                                showResidentialStatusBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedResidentialStatus ?? "Residential Status", style: TextStyle(color: _selectedResidentialStatus == null ? Colors.black45 : Colors.black, fontSize: 15, fontFamily: AppString.latoFontStyle),),
                                  const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),

                          dateWhenYouStartedLivingInYourResidenceForm(context),
                          const SizedBox(height: 30,),

                          Container(height: 55, width: double.maxFinite,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                            child: TextButton(
                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                              onPressed: (){
                                showLanguageBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedLanguage ?? "First Language", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
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
                                showReligionBottomSheet(context);
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedReligion ?? "Religion", style: const TextStyle(color: Colors.black45, fontSize: 15, fontFamily: AppString.latoFontStyle),),
                                  const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),

                          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.lock_outlined, color: kPrimaryColorLight,),
                              const SizedBox(width: 20,),
                              Text("Phincash security guarantee", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle),),
                            ],
                          ),
                          const SizedBox(height: 30,),

                          ButtonWidget(
                              onPressed: (){
                                Get.to(()=> const BVNVerification());
                              },
                              buttonText: "Continue",
                              height: 60, width: double.maxFinite
                          ),
                          const SizedBox(height: 100,),

                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}
