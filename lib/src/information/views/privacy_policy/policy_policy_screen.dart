import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/information/views/privacy_policy/controller/policy_and_privacy_controller.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<PrivacyPolicyController>();
    return GetBuilder<PrivacyPolicyController>(
      init: PrivacyPolicyController(),
        builder: (controller){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
          Get.back();
        },),),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ...List.generate(kPrivacyPolicy.length, (index) => Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text("${index+1}. ${kPrivacyPolicy[index]['heading']}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                  //     const SizedBox(height: 15,),
                  //     Text("${kPrivacyPolicy[index]['body']}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                  //     const SizedBox(height: 24,),
                  //   ],
                  // )),
                  Text("${_controller.policyResponseData?.data?.title}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(height: 15,),
                  Text("${_controller.policyResponseData?.data?.body}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                  const SizedBox(height: 24,),
                  Text("${_controller.disclaimerResponseData?.data?.title}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(height: 15,),
                  Text("${_controller.disclaimerResponseData?.data?.body}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                  const SizedBox(height: 24,),
                  Text("${_controller.termsAndServicesResponseData?.data?.title}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(height: 15,),
                  Text("${_controller.termsAndServicesResponseData?.data?.body}", textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black, fontSize: 14),),
                  const SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
