// To parse this JSON data, do
//
//     final registrationResponseModel = registrationResponseModelFromJson(jsonString);

import 'dart:convert';

RegistrationResponseModel registrationResponseModelFromJson(String str) =>
    RegistrationResponseModel.fromJson(json.decode(str));

String registrationResponseModelToJson(RegistrationResponseModel data) =>
    json.encode(data.toJson());

class RegistrationResponseModel {
  RegistrationResponseModel({
    this.status,
    this.message,
    this.otherInfo,
  });

  String? status;
  String? message;
  OtherInfo? otherInfo;

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) =>
      RegistrationResponseModel(
        status: json["status"],
        message: json["message"],
        otherInfo: OtherInfo.fromJson(json["otherInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otherInfo": otherInfo!.toJson(),
      };
}

class OtherInfo {
  OtherInfo({
    this.user,
    this.accessToken,
    this.accessTokenType,
  });

  User? user;
  String? accessToken;
  String? accessTokenType;

  factory OtherInfo.fromJson(Map<String, dynamic> json) => OtherInfo(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        accessTokenType: json["access_token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "access_token": accessToken,
        "access_token_type": accessTokenType,
      };
}

class User {
  User({
    this.phoneNumber,
    this.onboardStage,
    this.maxLoanLimit,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.hasLoanOverdue,
    this.hasUnpaidLoan,
    this.fullName,
  });

  String? phoneNumber;
  String? onboardStage;
  String? maxLoanLimit;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  bool? hasLoanOverdue;
  bool? hasUnpaidLoan;
  String? fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        phoneNumber: json["phone_number"],
        onboardStage: json["onboard_stage"],
        maxLoanLimit: json["max_loan_limit"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        hasLoanOverdue: json["has_loan_overdue"],
        hasUnpaidLoan: json["has_unpaid_loan"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "onboard_stage": onboardStage,
        "max_loan_limit": maxLoanLimit,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "has_loan_overdue": hasLoanOverdue,
        "has_unpaid_loan": hasUnpaidLoan,
        "full_name": fullName,
      };
}
