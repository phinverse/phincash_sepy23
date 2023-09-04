import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import '../../../constants/app_string.dart';
import '../../../constants/asset_path.dart';


class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(TransactionController());
    return GetBuilder<TransactionController>(
      init: TransactionController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(resizeToAvoidBottomInset: false,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
              title: Text("FAQ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
              leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: _controller.faq!.isEmpty || _controller.faq == [] || _controller.faq == null ?
                      Container(padding: const EdgeInsets.all(40),height: MediaQuery.of(context).size.height / 2, width: double.maxFinite,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetPath.noRecords,height: 150, width: 150,),
                            const SizedBox(height: 15,),
                            Text("No history yet", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                            const SizedBox(height: 15,),
                            const Text("They will appear once there’s any", style: TextStyle(color: Color(0xFFA6A6AA), fontSize: 12, fontWeight: FontWeight.w200, fontFamily: AppString.latoFontStyle),),
                          ],
                        ),
                      ) : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            Column(
                              children: [
                                ...List.generate(_controller.faq!.length, (index){
                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: ExpandableNotifier(  // <-- Provides ExpandableController to its children
                                      child: Column(
                                        children: [
                                          ScrollOnExpand(
                                            scrollOnExpand: true, scrollOnCollapse: true,
                                            child: ExpandablePanel(
                                              theme: const ExpandableThemeData(headerAlignment: ExpandablePanelHeaderAlignment.center, tapBodyToCollapse: true,),
                                              header: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                child: Text(_controller.faq![index].question!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                                              ),
                                              collapsed: const SizedBox(height: 20,),
                                              expanded:
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10,),
                                                  Text(_controller.faq![index].answer!, textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium?.copyWith( fontFamily: AppString.latoFontStyle, fontSize: 14),),
                                                ],
                                              ),
                                              builder: (_, collapsed, expanded) {
                                                return Padding(
                                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                  child: Expandable(
                                                    collapsed: collapsed,
                                                    expanded: expanded,
                                                    theme: const ExpandableThemeData(crossFadePoint: 0),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
      );
    });
  }
}
