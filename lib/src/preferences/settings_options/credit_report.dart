import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/models/dummy_models.dart';
import 'package:phincash/src/preferences/widget/credit_report_tile.dart';
import '../../../constants/app_string.dart';


class CreditReport extends StatelessWidget {
  const CreditReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List creditReport = DummyData.creditReportItem;
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Credit report",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
            child: Column(
              children: [
                const SizedBox(height: 70,),
                ...List.generate(creditReport.length, (index){
                  return CreditReportTileWidget(
                    leading: SvgPicture.asset(creditReport[index]["image_path"], theme: const SvgTheme(fontSize: 25),),
                    title: Text(creditReport[index]["title"], style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontFamily: AppString.latoFontStyle,fontSize: 18, fontWeight: FontWeight.w700),),
                    subtitle: Row(
                      children: [
                        Text(creditReport[index]["rating"].toString(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFD62D30), fontSize: 23, fontWeight: FontWeight.w700),),
                        const SizedBox(width: 10,),
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFFD62D30),
                                Colors.white,
                              ])
                          ),
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        )
    );
  }
}
