// To parse this JSON data, do
//
//     final repaymentLinkModel = repaymentLinkModelFromJson(jsonString);

import 'dart:convert';

RepaymentLinkModel repaymentLinkModelFromJson(String str) => RepaymentLinkModel.fromJson(json.decode(str));

String repaymentLinkModelToJson(RepaymentLinkModel data) => json.encode(data.toJson());

class RepaymentLinkModel {
  RepaymentLinkModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory RepaymentLinkModel.fromJson(Map<String, dynamic> json) => RepaymentLinkModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.paymentLink,
  });

  String? paymentLink;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentLink: json["payment_link"],
  );

  Map<String, dynamic> toJson() => {
    "payment_link": paymentLink,
  };
}
