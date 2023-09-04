// To parse this JSON data, do
//
//     final loanHistoryModel = loanHistoryModelFromJson(jsonString);

import 'dart:convert';

LoanHistoryModel loanHistoryModelFromJson(String str) => LoanHistoryModel.fromJson(json.decode(str));

String loanHistoryModelToJson(LoanHistoryModel data) => json.encode(data.toJson());

class LoanHistoryModel {
  LoanHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<LoanHistory>? data;

  factory LoanHistoryModel.fromJson(Map<String, dynamic> json) => LoanHistoryModel(
    status: json["status"],
    message: json["message"],
    data: List<LoanHistory>.from(json["data"].map((x) => LoanHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LoanHistory {
  LoanHistory({
    this.id,
    this.amount,
    this.status,
    this.loanPackageId,
    this.dueDate,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.transactions,
  });

  int? id;
  int? amount;
  String? status;
  int? loanPackageId;
  DateTime? dueDate;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Transaction>? transactions;

  factory LoanHistory.fromJson(Map<String, dynamic> json) => LoanHistory(
    id: json["id"],
    amount: json["amount"],
    status: json["status"],
    loanPackageId: json["loan_package_id"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "status": status,
    "loan_package_id": loanPackageId,
    "due_date": dueDate == null ? null : dueDate?.toIso8601String(),
    "user_id": userId,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
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
  dynamic completedAt;
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
    completedAt: json["completed_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "completed_at": completedAt,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}
