// To parse this JSON data, do
//
//     final accountVerifyModel = accountVerifyModelFromJson(jsonString);

import 'dart:convert';

AccountVerifyModel accountVerifyModelFromJson(String str) =>
    AccountVerifyModel.fromJson(json.decode(str));

String accountVerifyModelToJson(AccountVerifyModel data) =>
    json.encode(data.toJson());

class AccountVerifyModel {
  AccountVerifyModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AccountVerifyModel.fromJson(Map<String, dynamic> json) =>
      AccountVerifyModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.accountNumber,
    this.accountName,
  });

  String? accountNumber;
  String? accountName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
      };
}
