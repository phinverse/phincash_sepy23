// To parse this JSON data, do
//
//     final loanDetailsModel = loanDetailsModelFromJson(jsonString);

import 'dart:convert';

LoanDetailsModel loanDetailsModelFromJson(String str) =>
    LoanDetailsModel.fromJson(json.decode(str));

String loanDetailsModelToJson(LoanDetailsModel data) =>
    json.encode(data.toJson());

class LoanDetailsModel {
  LoanDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory LoanDetailsModel.fromJson(Map<String, dynamic> json) =>
      LoanDetailsModel(
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
    this.id,
    this.amount,
    this.status,
    this.loanPackageId,
    this.dueDate,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.loanPackage,
    this.transactions,
  });

  dynamic id;
  dynamic amount;
  String? status;
  dynamic loanPackageId;
  DateTime? dueDate;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  LoanPackage? loanPackage;
  List<Transaction>? transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        amount: json["amount"],
        status: json["status"],
        loanPackageId: json["loan_package_id"],
        dueDate: DateTime.parse(json["due_date"]),
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        loanPackage: LoanPackage.fromJson(json["loan_package"]),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "status": status,
        "loan_package_id": loanPackageId,
        "due_date": dueDate?.toIso8601String(),
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "loan_package": loanPackage?.toJson(),
        "transactions":
            List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class LoanPackage {
  LoanPackage({
    this.id,
    this.name,
    this.amount,
    this.duration,
    this.interestRate,
    this.increaseLimitBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? amount;
  int? duration;
  int? interestRate;
  int? increaseLimitBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LoanPackage.fromJson(Map<String, dynamic> json) => LoanPackage(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        duration: json["duration"],
        interestRate: json["interest_rate"],
        increaseLimitBy: json["increase_limit_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "duration": duration,
        "interest_rate": interestRate,
        "increase_limit_by": increaseLimitBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.reference,
    this.description,
    this.type,
    this.status,
    this.amount,
    this.payload,
    this.userId,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? reference;
  String? description;
  String? type;
  String? status;
  int? amount;
  dynamic payload;
  int? userId;
  DateTime? completedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        reference: json["reference"],
        description: json["description"],
        type: json["type"],
        status: json["status"],
        amount: json["amount"],
        payload: json["payload"],
        userId: json["user_id"],
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "description": description,
        "type": type,
        "status": status,
        "amount": amount,
        "payload": payload,
        "user_id": userId,
        "completed_at": completedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
