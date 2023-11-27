import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/transactions/controller/transaction_controller.dart';
import 'package:phincash/src/preferences/widget/setting_option_tile.dart';
import '../../../constants/app_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(TransactionController());
    String imageUrl = "${_controller.userPersonalData!.user.userPhoto}"
        .replaceFirst('public/', '');
    String baseUrl = 'https://phincash.cloud/storage/app/public/';
    return SafeArea(
        top: false,
        bottom: false,
        child: GetBuilder<TransactionController>(
            init: TransactionController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: AppString.latoFontStyle,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
                body: Column(
                  children: [
                    const Spacer(),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5)),
                      child: ClipOval(
                        child: Image.network(
                          "${baseUrl}$imageUrl",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SettingOptionTile(
                        optionTitle: Text(
                          "Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        ),
                        destinationIcon: Text(
                          "${_controller.userPersonalData!.user.firstName} ${_controller.userPersonalData!.user.lastName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black45,
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 12),
                        )),
                    SettingOptionTile(
                        optionTitle: Text(
                          "Gender",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        ),
                        destinationIcon: Text(
                          "${_controller.userPersonalData!.user.gender}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black45,
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 12),
                        )),
                    SettingOptionTile(
                        optionTitle: Text(
                          "Email",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        ),
                        destinationIcon: Text(
                          "${_controller.userPersonalData!.user.email}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black45,
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 12),
                        )),
                    SettingOptionTile(
                        optionTitle: Text(
                          "Phone",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                        ),
                        destinationIcon: Text(
                          "${_controller.userPersonalData!.user.phoneNumber}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black45,
                                  fontFamily: AppString.latoFontStyle,
                                  fontSize: 12),
                        )),
                    const Spacer(
                      flex: 14,
                    ),
                  ],
                ),
              );
            }));
  }
}
