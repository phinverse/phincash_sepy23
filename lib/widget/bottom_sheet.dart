import 'package:flutter/material.dart';

class MyBottomSheet{
  void showDismissibleBottomSheet({
    required BuildContext context,
    List<Widget>? children,
    Widget? child,
    double? height,
  }){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
          constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/1.8,),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: child ??
              Column(
                children: [
                  const SizedBox(height: 10,),
                  Container(height: 5, width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),),
                  const SizedBox(height: 30,),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: children!
                      ),
                    ),
                  ),
                ],
              ),
        ));
  }

  void showNonDismissibleBottomSheet({
    required BuildContext context,
    required List<Widget> children,
    double? height,
  }){
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
          constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/1.8,),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Container(height: 5, width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),),
              const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: children
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}