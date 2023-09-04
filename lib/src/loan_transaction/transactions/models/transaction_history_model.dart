// To parse this JSON data, do
//
//     final transactionHistoryResponse = transactionHistoryResponseFromJson(jsonString);

import 'dart:convert';

TransactionHistoryResponse transactionHistoryResponseFromJson(String str) => TransactionHistoryResponse.fromJson(json.decode(str));

String transactionHistoryResponseToJson(TransactionHistoryResponse data) => json.encode(data.toJson());

class TransactionHistoryResponse {
  TransactionHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<TransactionHistoryList>? data;

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) => TransactionHistoryResponse(
    status: json["status"],
    message: json["message"],
    data: List<TransactionHistoryList>.from(json["data"].map((x) => TransactionHistoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TransactionHistoryList {
  TransactionHistoryList({
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

  factory TransactionHistoryList.fromJson(Map<String, dynamic> json) => TransactionHistoryList(
    id: json["id"],
    reference: json["reference"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    amount: json["amount"],
    payload: json["payload"],
    userId: json["user_id"],
    completedAt: json["completed_at"] == null ? null : DateTime.parse(json["completed_at"]),
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
    "completed_at": completedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
