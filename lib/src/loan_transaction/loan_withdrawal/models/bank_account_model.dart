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

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
    status: json["status"],
    message: json["message"],
    data: List<BankAccount>.from(
        json["data"]["bankAccounts"].map((x) => BankAccount.fromJson(x))),
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

  int? id; // Change this line to int?
  String? bankName;
  String? bankCode;
  String? accountName;
  String? accountNumber;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userPhone;
  int? bvnStatus;
  int? accountVerifyStatus;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    id: json["id"] is int ? json["id"] : (json["id"] is String ? int.tryParse(json["id"]) : null),
    bankName: json["bank_name"] as String?,
    bankCode: json["bank_code"] as String?,
    accountName: json["account_name"] as String?,
    accountNumber: json["account_number"] as String?,
    userId: json["user_id"] is int ? json["user_id"] : (json["user_id"] is String ? int.tryParse(json["user_id"]) : null),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"] as String),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"] as String),
    userPhone: json['user_phone'] as String?,
    bvnStatus: json['bvn_status'] == null
        ? null
        : json['bvn_status'] is int
        ? json['bvn_status']
        : (json['bvn_status'] is String ? int.tryParse(json['bvn_status']) : null),
    accountVerifyStatus: json['account_verify_status'] == null
        ? null
        : json['account_verify_status'] is int
        ? json['account_verify_status']
        : (json['account_verify_status'] is String ? int.tryParse(json['account_verify_status']) : null),
  );


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
    "account_verify_status": accountVerifyStatus,
  };
}
