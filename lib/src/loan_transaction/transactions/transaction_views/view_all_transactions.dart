import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/constants/colors.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/loan_transaction/widgets/transaction_tile.dart';
import '../../../../constants/asset_path.dart';
import '../../../../widget/button_widget.dart';
import '../../models/dummy_models.dart';



class ViewAllTransaction extends StatefulWidget {
  const ViewAllTransaction({Key? key}) : super(key: key);

  @override
  State<ViewAllTransaction> createState() => _ViewAllTransactionState();
}

class _ViewAllTransactionState extends State<ViewAllTransaction> {
  final _controller = Get.put(TransactionController());
  final List _transactions = DummyData.transactions;
  final List _transactionSettled = DummyData.transactionSettling;

  @override
  Widget build(BuildContext context) {
    showTransactionInDialog({required String headerText, required String amount, required String date, required String time, required String status}){
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SizedBox(height: MediaQuery.of(context).size.height / 1.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),
                          Lottie.asset('assets/lottie/transaction_details.json', height: 150, width: 250, alignment: Alignment.center),
                          const SizedBox(height: 30,),
                          Text(headerText,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                          const SizedBox(height: 20,),
                          Text("STATUS: SUCCESSFUL", textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontFamily: AppString.latoFontStyle, color: Colors.black54),),
                          const SizedBox(height: 10,),
                          Text(amount,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF30D6B0), fontSize: 30, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                          const SizedBox(height: 25,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Date:  ",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                      Text(date,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("Time:  ",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                      Text(time,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Status:  ",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black45, fontSize: 18, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                                      const SizedBox(height: 10,),
                                      Text(status,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 18, fontFamily: AppString.latoFontStyle),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          ButtonWidget(
                              onPressed: (){
                                Get.back();
                              },
                              buttonText: "Ok",
                              height: 55, width: double.maxFinite
                          ),
                          const SizedBox(height: 30,)
                        ],
                      ),
                    ),
                  )
              ),
            );}
      );
    }
    return SafeArea(top: false, bottom: false,
        child: GetBuilder<TransactionController>(
          init: TransactionController(),
            builder: (controller){
              final format = new NumberFormat("#,##0", "en_US");
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(backgroundColor: Colors.white,centerTitle: true,
                leading:  IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab, indicatorWeight: 5,
                  indicatorColor: kPrimaryColorLight, labelColor: kPrimaryColorLight,
                  unselectedLabelColor: Colors.black45, labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 14, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: "In",),
                    Tab(text: "Out",),
                  ],
                ),
                title: Text(AppString.transactions, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontSize: 20, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700)),
              ),
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      _controller.transactionHistory!.where((element) => element.type == "disbursement" || element.type == "deposit").isEmpty ? Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AssetPath.noRecords, width: 300, height: 200,),
                              const Text("No history yet", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                              const SizedBox(height: 10,),
                              const Text("They will appear once there’s any", style: TextStyle(color: Color(0xFFA6A6AA), fontSize: 15, fontWeight: FontWeight.w200, fontFamily: AppString.latoFontStyle),),
                            ],
                          )
                        ),) :
                      Column(
                        children: [
                          ..._controller.transactionHistory!.where((element) => element.type == "disbursement" || element.type == "deposit").map((e){
                          return InkWell(
                            onTap: (){
                              showTransactionInDialog(
                                  amount: "N ${format.format(int.parse(e.amount.toString()))}",
                                  headerText: e.description!,
                                  date:  Jiffy(e.createdAt!).yMMMMEEEEd,
                                  time: DateFormat('hh:mm a').format(e.createdAt!),
                                status: e.status!
                              );
                            },
                            child: TransactionTile(height: 75,
                              image:  SvgPicture.asset(AssetPath.transIcon, theme: const SvgTheme(fontSize: 25),),
                              title: Text(e.description!, overflow: TextOverflow.fade, maxLines: 1, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: AppString.latoFontStyle)),
                              subTitle: Row(
                                children: [
                                  Text(Jiffy(e.createdAt!).yMMMMd,  overflow: TextOverflow.fade, maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w700,
                                          fontFamily: AppString.latoFontStyle, color: Colors.black45)),
                                  const SizedBox(width: 10,),
                                  Text(DateFormat('hh:mm a').format(e.createdAt!),  overflow: TextOverflow.fade, maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w700,
                                          fontFamily: AppString.latoFontStyle, color: Colors.black45)),
                                ],
                              ),
                              amount: Text("N ${format.format(int.parse(e.amount.toString()))}",
                                overflow: TextOverflow.fade, maxLines: 1, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                            ),
                          );
                        }).toList(),
                      ],)
                    ],
                  ),
                  Column(
                    children: [
                      _controller.transactionHistory!.where((element) => element.type == "withdrawal" || element.type == "repayment").isEmpty ?
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 60,),
                              SvgPicture.asset(AssetPath.noRecords, width: 300, height: 200,),
                              const Text("No history yet", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                              const SizedBox(height: 10,),
                              const Text("They will appear once there’s any", style: TextStyle(color: Color(0xFFA6A6AA), fontSize: 12, fontWeight: FontWeight.w200, fontFamily: AppString.latoFontStyle),),
                            ],
                          ),
                        ),) :
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ..._controller.transactionHistory!.where((element) => element.type == "withdrawal" || element.type == "repayment").map((e){
                                return  InkWell(
                                  onTap: (){
                                    showTransactionInDialog(
                                        amount: "N ${format.format(int.parse(e.amount.toString()))}",
                                        headerText: e.description!,
                                        date:  Jiffy(e.createdAt!).yMMMMd,
                                        time: DateFormat('hh:mm a').format(e.createdAt!),
                                      status: e.status!
                                    );
                                  },
                                  child: TransactionTile(height: 75,
                                    image:  SvgPicture.asset(AssetPath.transIcon, theme: const SvgTheme(fontSize: 25),),
                                    title: Text(e.description!, overflow: TextOverflow.fade, maxLines: 1, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: AppString.latoFontStyle)),
                                    subTitle: Row(
                                      children: [
                                        Text(Jiffy(e.createdAt!).yMMMMEEEEd,  overflow: TextOverflow.fade, maxLines: 1,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w700,
                                                fontFamily: AppString.latoFontStyle, color: Colors.black45)),
                                        const SizedBox(width: 20,),
                                        Text(DateFormat('hh:mm a').format(e.createdAt!),  overflow: TextOverflow.fade, maxLines: 1,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w700,
                                                fontFamily: AppString.latoFontStyle, color: Colors.black45)),
                                      ],
                                    ),
                                    amount: Text("N ${format.format(int.parse(e.amount.toString()))}",  overflow: TextOverflow.fade, maxLines: 1, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: AppString.latoFontStyle),),
                                  ),
                                );
                              }
                              ).toList(),
                            ],
                          )
                    ],
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}
