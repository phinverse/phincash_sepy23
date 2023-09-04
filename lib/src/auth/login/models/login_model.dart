// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
    this.user,
    this.accessToken,
    this.accessTokenType,
  });

  User? user;
  String? accessToken;
  String? accessTokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    accessTokenType: json["access_token_type"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "access_token": accessToken,
    "access_token_type": accessTokenType,
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phoneNumber,
    this.gender,
    this.maritalStatus,
    this.religion,
    this.highestEduLevel,
    this.residentialAddress,
    this.dateOfBirth,
    this.mainWalletAmount,
    this.secondaryWalletAmount,
    this.secondaryWalletDueAt,
    this.maxLoanLimit,
    this.currentLoanId,
    this.onboardStage,
    this.createdAt,
    this.updatedAt,
    this.currentLoanStatus,
    this.hasLoanOverdue,
    this.hasUnpaidLoan,
    this.hasVerifiedBvn,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? maritalStatus;
  String? religion;
  String? highestEduLevel;
  String? residentialAddress;
  DateTime? dateOfBirth;
  int? mainWalletAmount;
  int? secondaryWalletAmount;
  DateTime? secondaryWalletDueAt;
  String? maxLoanLimit;
  int? currentLoanId;
  String? onboardStage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? currentLoanStatus;
  bool? hasLoanOverdue;
  bool? hasUnpaidLoan;
  bool? hasVerifiedBvn;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    middleName: json["middle_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    maritalStatus: json["marital_status"],
    religion: json["religion"],
    highestEduLevel: json["highest_edu_level"],
    residentialAddress: json["residential_address"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    mainWalletAmount: json["main_wallet_amount"],
    secondaryWalletAmount: json["secondary_wallet_amount"],
    secondaryWalletDueAt: json["secondary_wallet_due_at"] == null ? null : DateTime.parse(json["secondary_wallet_due_at"]),
    maxLoanLimit: json["max_loan_limit"],
    currentLoanId: json["current_loan_id"],
    onboardStage: json["onboard_stage"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    currentLoanStatus: json['current_loan_status']==null?'':json['current_loan_status'],
    hasLoanOverdue: json["has_loan_overdue"],
    hasUnpaidLoan: json["has_unpaid_loan"],
    hasVerifiedBvn: json["has_verified_bvn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "middle_name": middleName,
    "email": email,
    "phone_number": phoneNumber,
    "gender": gender,
    "marital_status": maritalStatus,
    "religion": religion,
    "highest_edu_level": highestEduLevel,
    "residential_address": residentialAddress,
    "date_of_birth": dateOfBirth?.toIso8601String(),
    "main_wallet_amount": mainWalletAmount,
    "secondary_wallet_amount": secondaryWalletAmount,
    "secondary_wallet_due_at": secondaryWalletDueAt?.toIso8601String(),
    "max_loan_limit": maxLoanLimit,
    "current_loan_id": currentLoanId,
    "onboard_stage": onboardStage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "current_loan_status": currentLoanStatus,
    "has_loan_overdue": hasLoanOverdue,
    "has_unpaid_loan": hasUnpaidLoan,
    "has_verified_bvn": hasVerifiedBvn,
  };
}
