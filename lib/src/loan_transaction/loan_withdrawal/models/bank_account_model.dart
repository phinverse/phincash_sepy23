// To parse this JSON data, do
//
//     final bankAccountModel = bankAccountModelFromJson(jsonString);

import 'dart:convert';

BankAccountModel bankAccountModelFromJson(String str) =>
    BankAccountModel.fromJson(json.decode(str));

String bankAccountModelToJson(BankAccountModel data) =>
    json.encode(data.toJson());

class BankAccountModel {
  BankAccountModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<BankAccount>? data;

  factory BankAccountModel.fromJson(Map<String, dynamic> json) =>
      BankAccountModel(
        status: json["status"],
        message: json["message"],
        data: List<BankAccount>.from(
            json["data"].map((x) => BankAccount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BankAccount {
  BankAccount({
    this.id,
    this.bankName,
    this.bankCode,
    this.accountName,
    this.accountNumber,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.userPhone,
    this.bvnStatus,
    this.accountVerifyStatus,
  });

  int? id;
  String? bankName;
  String? bankCode;
  String? accountName;
  String? accountNumber;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userPhone;
  int? bvnStatus;
  int? accountVerifyStatus;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
      id: json["id"],
      bankName: json["bank_name"],
      bankCode: json["bank_code"],
      accountName: json["account_name"],
      accountNumber: json["account_number"],
      userId: json["user_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      userPhone: json['user_phone'],
      bvnStatus: json['bvn_status'],
      accountVerifyStatus: json['account_verify_status']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "bank_code": bankCode,
        "account_name": accountName,
        "account_number": accountNumber,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_phone": userPhone,
        "bvn_status": bvnStatus,
        "account_verify_status": accountVerifyStatus
      };
}
