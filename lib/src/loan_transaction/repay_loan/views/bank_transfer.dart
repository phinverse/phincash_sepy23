import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';

class BankTransfer extends StatelessWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Personal Information", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){
              Get.back();
            },
                icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          ),
          body: Column()
        )
    );
  }
}
