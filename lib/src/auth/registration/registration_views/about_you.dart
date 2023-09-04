import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/bottom_sheet.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';
class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final _controller = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    void showGenderBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: 200, children:
      List.generate(_controller.gender.length, (index){
        return GetBuilder<RegistrationController>(
          init: RegistrationController(),
            builder: (controller){
          return InkWell(
            onTap: (){
              _controller.selectGender(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_controller.gender[index], style: const TextStyle(color: Colors.black, fontSize: 14),),
                  _controller.selectedGender == _controller.gender[index] ? Container(height: 14, width: 14,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                    child: const Icon(Icons.check, size: 12, color: Colors.white,),
                  ): const SizedBox()
                ],
              ),
            ),);
        });
      },));
    }

    void showReligionBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: 250, children:
      List.generate(_controller.religion.length, (index){
        return GetBuilder<RegistrationController>(
            init: RegistrationController(),
            builder: (controller){
              return InkWell(
                onTap: (){
                  _controller.selectReligion(index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_controller.religion[index], style: const TextStyle(color: Colors.black, fontSize: 14),),
                      _controller.selectedReligion == _controller.religion[index] ? Container(height: 14, width: 14,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                        child: const Icon(Icons.check, size: 12, color: Colors.white,),
                      ): const SizedBox()
                    ],
                  ),
                ),);
            });
      },));
    }

    void showMaritalStatusBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: 250, children:
      List.generate(_controller.maritalStatus.length, (index){
        return GetBuilder<RegistrationController>(
            init: RegistrationController(),
            builder: (controller){
              return InkWell(
                onTap: (){
                  _controller.selectMaritalStatus(index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_controller.maritalStatus[index], style: const TextStyle(color: Colors.black, fontSize: 14),),
                      _controller.selectedMaritalStatus == _controller.maritalStatus[index] ? Container(height: 14, width: 14,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                        child: const Icon(Icons.check, size: 12, color: Colors.white,),
                      ): const SizedBox()
                    ],
                  ),
                ),);
            });
      },));
    }

    Widget dateOfBirthForm (BuildContext c){
      String getDate(String? date){
        final formattedDate = Jiffy(date).yMMMMEEEEd;
        return formattedDate;
      }
      return GetBuilder<RegistrationController>(
        init: RegistrationController(),
          builder: (controller){
        return Container(height: 45, width: double.maxFinite,
          decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
          child: TextButton(
            onPressed: ()=> _controller.pickWorkStartDate(c),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controller.dateSelected == false ? const Text("Date Of Birth", style: TextStyle(color: Colors.black45, fontSize: 14, fontFamily: AppString.latoFontStyle),) :
                  Text(getDate(_controller.selectedDateOfBirth.toString()), style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.black54)
                ],
              ),
            ),
          ),
        );
      });
    }

    void showEducationLevelBottomSheet(BuildContext context){
      MyBottomSheet().showDismissibleBottomSheet(context: context, height: 300, children:
      List.generate(_controller.educationLevel.length, (index){
        return GetBuilder<RegistrationController>(
            init: RegistrationController(),
            builder: (controller){
              return InkWell(
                onTap: (){
                  _controller.selectEducationLevel(index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_controller.educationLevel[index], style: const TextStyle(color: Colors.black, fontSize: 14),),
                      _controller.selectedEducationalLevel == _controller.educationLevel[index] ? Container(height: 14, width: 14,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                        child: const Icon(Icons.check, size: 12, color: Colors.white,),
                      ): const SizedBox()
                    ],
                  ),
                ),);
            });
      },));
    }
    return SafeArea(top: false, bottom: false,
        child: GetBuilder<RegistrationController>(
          init: RegistrationController(),
            builder: (controller){
              getFormattedDate(String date) {
                var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
                var inputDate = inputFormat.parse(date);
                var outputFormat = DateFormat('MM/dd/yyyy');
                return outputFormat.format(inputDate);
              }
          return Scaffold(
            key: _controller.scaffoldKeyAboutYou,
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("About You",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _controller.formKeyAboutYou,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      // const Spacer(flex: 1,),
                      ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                          child: Text("We would like to know more about you. Kindly provide the following information",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54, fontWeight: FontWeight.w500),)),
                      // const SizedBox(height: 20,),
                      // ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                      //     child: Text("Kindly provide the right answers to our questions to get better loan offers",
                      //       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,fontFamily: AppString.latoFontStyle, color: Colors.black45),)),
                      const SizedBox(height: 30,),
                      Container(height: 45, width: double.maxFinite,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                          onPressed: (){
                            showGenderBottomSheet(context);
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_controller.selectedGender ?? "Gender", style: TextStyle(color: _controller.selectedGender == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Container(height: 45, width: double.maxFinite,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                          onPressed: (){
                            showMaritalStatusBottomSheet(context);
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_controller.selectedMaritalStatus ?? "Marital Status",
                                style: TextStyle(color: _controller.selectedMaritalStatus == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      // Text("The full name on your BVN account", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontSize: 20),),
                      // const SizedBox(height: 20,),
                      Container(height: 45, width: double.maxFinite,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                          onPressed: (){
                            showReligionBottomSheet(context);
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_controller.selectedReligion ?? "Religion", style: TextStyle(color: _controller.selectedReligion == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Container(height: 45, width: double.maxFinite,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 0.7), borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                          onPressed: (){
                            showEducationLevelBottomSheet(context);
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_controller.selectedEducationalLevel ?? "Highest Education Level",
                                style: TextStyle(color: _controller.selectedEducationalLevel == null ? Colors.black45 : Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle),),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      FormFieldWidget(
                        validator: (value) => (value!.isEmpty? "Please enter your residential address" : null),
                        controller: _controller.residentialAddressController,
                        labelText: "Residential Address",
                        onChanged: (value){
                          _controller.bvnResidentialAddress = value;
                        },
                        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                      ),
                      const SizedBox(height: 30,),
                      dateOfBirthForm(context),
                      const SizedBox(height: 15,),
                      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lock_outlined, color: kPrimaryColorLight,),
                          const SizedBox(width: 10,),
                          Text("Phincash security guarantee",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle, fontSize: 14),),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      ButtonWidget(
                          onPressed: (){
                            _controller.UserData(firstName: _controller.firstNameController.text, lastName: _controller.surNameController.text, middleName: _controller.middleNameController.text,
                              email: _controller.emailController.text, phoneNumber: _controller.bvnPhoneNumberController.text, maritalStatus: _controller.selectedMaritalStatus, religion: _controller.selectedReligion!,
                              educationalLevel: _controller.selectedEducationalLevel!, residentialAddress: _controller.bvnResidentialAddress!,
                                dateOfBirth: getFormattedDate(_controller.selectedDateOfBirth.toString()).toString().trim(), gender: _controller.selectedGender!
                            );
                          },
                          buttonText: AppString.continueBtnTxt,
                          height: 48, width: double.maxFinite
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
    );
  }
}
