import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/formfield_widget.dart';
class BVNVerification extends StatefulWidget {
  const BVNVerification({Key? key}) : super(key: key);

  @override
  State<BVNVerification> createState() => _BVNVerificationState();
}

class _BVNVerificationState extends State<BVNVerification> {
  final _controller = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            key: _controller.scaffoldKeyValidateBVNScreen,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("BVN Authentication", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){
                Get.offAll(()=> const HomeScreen());
              },
                  icon:const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
              child: Form(key: _controller.formKeyValidateBVNScreen,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Container(height: MediaQuery.of(context).size.height / 12, width: double.maxFinite,
                      decoration: BoxDecoration(color: const Color(0xffA6A6AA).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red,),
                          Text("Sorry, We could not proceed your request. \nKindly Provide your BVN for validation",
                            textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: AppString.latoFontStyle, fontSize: 12),)
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30,),
                              FormFieldWidget(
                                keyboardType: TextInputType.number,
                                controller: _controller.validateBVNController,
                                labelText: "BVN",
                                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Please enter your Bvn Number';
                                  }else if (value.length < 9) {
                                    return "Bvn must be 9 digits";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 15,),
                              Align(alignment: Alignment.center,
                                child: RichText(textAlign: TextAlign.center, text: TextSpan(text: "Can’t remember your BVN? Dial  ",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 12,),
                                    children: [
                                      TextSpan(text: "*565*0# ",recognizer: TapGestureRecognizer()
                                        ..onTap = ()async{
                                          final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path: "*565*0#",
                                          );
                                          await launchUrl(launchUri);
                                          if (!await launchUrl(launchUri)) throw 'Could not launch $launchUri';
                                        },
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, decoration: TextDecoration.underline, color: kPrimaryColorLight)),
                                      TextSpan(text: " on your phone",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppString.latoFontStyle, fontSize: 12),),
                                    ]
                                )),
                              ),
                              const SizedBox(height: 15,),

                              Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.lock_outlined, color: kPrimaryColorLight,),
                                  const SizedBox(width: 10,),
                                  Text("Phincash security guarantee",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontFamily: AppString.latoFontStyle,fontSize: 14),),
                                ],
                              ),
                              const SizedBox(height: 15,),

                              ButtonWidget(
                                  onPressed: (){
                                    // _controller.checkConnectionForValidateBVN();
                                  },
                                  buttonText: "Verify BVN",
                                  height: 48, width: double.maxFinite
                              ),
                              const SizedBox(height: 30,),

                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    });
  }
}
