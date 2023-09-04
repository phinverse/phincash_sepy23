import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/acquire_loan/loan_acquisition_view/add_card.dart';
import '../../../../constants/app_string.dart';

class LinkCard extends StatefulWidget {
  const LinkCard({Key? key}) : super(key: key);

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation:  0.0, centerTitle: true,
            title: Text("Authorize auto-debit", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 25, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
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
                Text("Let’s help you pay early",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 22, fontFamily: AppString.latoFontStyle, color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10,),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2, minHeight: 50),
                    child: Text("Kindly authorize us to debit your card for easy loan repayments. Add a card and you will  be debited only when your loan is due ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontFamily: AppString.latoFontStyle, color: Colors.black45),
                    )),
                const Spacer(),
                InkWell(onTap: (){
                  Get.to(()=> const AddCardScreen());
                },
                  child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(height: MediaQuery.of(context).size.height / 10, width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(25),
                      child: Center(
                        child: Text("Add credit or debit card", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontFamily: AppString.latoFontStyle, fontSize: 18),),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 10,),
              ],
            ),
          )
        )
    );
  }
}
