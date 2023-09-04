import 'package:flutter/material.dart';
class MyDialog {

  showMyDialog(BuildContext? context, double height, double? width, List<Widget>? children,){
    showDialog(context: context!,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(height: height, width: width,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: children!,
                )
            ),
          );}
    );
  }
}