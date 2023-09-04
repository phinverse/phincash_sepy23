

import 'package:flutter/material.dart';
import 'package:phincash/constants/asset_path.dart';

class DummyData {
  DummyData._();

  static const defaultImageUrl = "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile_preferences-picture-973460_640.png";

  static final transactions = [
    {
      "transaction_title": "Loan Disbursement",
      "amount": "+N5,000",
      "date": "March 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N5,000",
      "date": "Jan 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Withdrawal",
      "amount": "-N5,000",
      "date": "March 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N50,000",
      "date": "Feb 27, 05:00 PM",
    },
    {
      "transaction_title": "Loan Withdrawal",
      "amount": "-N15,000",
      "date": "May 10, 02:00 PM",
    },
    {
      "transaction_title": "Loan Withdrawal",
      "amount": "-N57,000",
      "date": "December 10, 01:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N100,000",
      "date": "March 10, 05:00 PM",
    },
  ];

  static final creditReportItem = [
    {
      "image_path": "assets/svg_assets/credit_report_checked.svg",
      "title": "Credit score",
      "rating": 60,
    },
    {
      "image_path": "assets/svg_assets/account.svg",
      "title": "Bank account score",
      "rating": 85,
    },
    {
      "image_path": "assets/svg_assets/calc.svg",
      "title": "Salary score",
      "rating": 79,
    },
    {
      "image_path": "assets/svg_assets/card.svg",
      "title": "Bank card score",
      "rating": 79,
    },
    {
      "image_path": "assets/svg_assets/credit_card.svg",
      "title": "Credit card payment missed",
      "rating": 79,
    }
  ];

  static final loanExtensionOption = [
    {
      "days": "7 Days",
      "amount": "N5,000",
      "date": "29 March 2022",
    },
    {
      "days": "15 Days",
      "amount": "N10,000",
      "date": "29 March 2022",
    },
    {
      "days": "21 Days",
      "amount": "N20,000",
      "date": "29 March 2022",
    },
    {
      "days": "30 Days",
      "amount": "N30,000",
      "date": "29 January 2022",
    },
  ];

  static final transactionSettling = [
    {
      "transaction_title": "Loan Repayment",
      "amount": "+N5,000",
      "date": "March 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N5,000",
      "date": "Jan 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N5,000",
      "date": "March 10, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N50,000",
      "date": "Feb 27, 05:00 PM",
    },
    {
      "transaction_title": "Loan Repayment",
      "amount": "-N15,000",
      "date": "May 10, 02:00 PM",
    },
  ];

  static final notifications = [
    {
      "subtitle": "March 10, 05:00 PM",
      "body": "Welcome to Phincash! You can find important from Phincash here. We’re glad to have you here.",
    },
    {
      "subtitle": "March 10, 05:00 PM",
      "body": "Your Phincash repayment of N20,200 was recieved. Thanks for paying back.",
    },
    {
      "subtitle": "March 10, 05:50 PM",
      "body": "Your Phincash loan of N20,000 has been sent. Your first repayment is due is 15 days.",
    },
  ];

  static final settingOptions = [
    {
      "title": "Reset PIN",
    },
    {
      "title": "About Us",
    },
    {
      "title": "Terms & Conditions",
    },
  ];

  static final profileSettingOptions = [
    {
      "title": "Name",
      "body": "Kunle Chukwudi Buhari",
    },
    {
      "title": "Gender",
      "body": "Male",
    },
    {
      "title": "Birthday",
      "body": "04-06-2002",
    },
    {
      "title": "BVN",
      "body": "222228888856",
    },
    {
      "title": "Mobile Number",
      "body": "08063995990",
    },
    {
      "title": "ID",
      "body": "99585736356",
    },
  ];

  static final carouselHeadings = [
    {
      "title": "Loan is less than 5 mins",
      "message": "Reliable disbursement",
      "image_path": AssetPath.carouselImage1,
    },
    {
      "title": "Seamless repayment",
      "message": "Flexible repayment options",
      "image_path": AssetPath.carouselImage2,
    },
    {
      "title": "Don’t be left behind!",
      "message": "Repay early to enjoy better loan offer",
      "image_path": AssetPath.carouselImage3
    },
  ];

  static final transactionsHistory = [
    {
      "payment": "Loan disbursement",
      "date": "May 29,  2022",
      "amount": "N30,000",
      "status": "DISBURSED",
    },
    {
      "payment": "Loan repayment",
      "date": "January 15,  2022",
      "amount": "N300,000",
      "status": "PAID",
    },
    {
      "payment": "Loan repayment",
      "date": "March 10,  2022",
      "amount": "N35,000",
      "status": "PAID",
    },
  ];
  static final profileTitle = [
    // {
    //   "title": "Card",
    //   "icons": Icons.credit_card
    // },
    // {
    //   "title": "Credit report",
    //   "icons": Icons.sticky_note_2_outlined
    // },
    {
      "title": "Support",
      "icons": Icons.contact_support_outlined
    },
    // {
    //   "title": "Setting",
    //   "icons": Icons.settings
    // },
    {
      "title": "Privacy policy",
      "icons": Icons.lock
    },
    {
      "title": "FAQ",
      "icons": Icons.help_outline_outlined
    },
    {
      "title": "Reset PIN",
      "icons": Icons.pin
    },
    {
      "title": "Delete Account",
      "icons": Icons.account_balance_outlined
    },
  ];

}







enum ReportDataIndex {
  VitalSigns,
  MedicalConditions,
  PregnancyDetails,
  RoutineInvestigations,
  Medications,
  FollowUpAppointment,
  DoctorComment
}

class ReportData {
  String reportText;
  ReportDataIndex reportData;

  ReportData({required this.reportText, required this.reportData});
}
