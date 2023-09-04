// To parse this JSON data, do
//
//     final loanAcquisitionResponseData = loanAcquisitionResponseDataFromJson(jsonString);

import 'dart:convert';

LoanAcquisitionResponseData loanAcquisitionResponseDataFromJson(String str) => LoanAcquisitionResponseData.fromJson(json.decode(str));

String loanAcquisitionResponseDataToJson(LoanAcquisitionResponseData data) => json.encode(data.toJson());

class LoanAcquisitionResponseData {
  LoanAcquisitionResponseData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory LoanAcquisitionResponseData.fromJson(Map<String, dynamic> json) => LoanAcquisitionResponseData(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    this.amount,
    this.status,
    this.loanPackageId,
    this.dueDate,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? amount;
  String? status;
  int? loanPackageId;
  DateTime? dueDate;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amount: json["amount"] == null ? null : json["amount"],
    status: json["status"] == null ? null : json["status"],
    loanPackageId: json["loan_package_id"] == null ? null : json["loan_package_id"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : amount,
    "status": status == null ? null : status,
    "loan_package_id": loanPackageId == null ? null : loanPackageId,
    "due_date": dueDate == null ? null : dueDate?.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "id": id == null ? null : id,
  };
}
