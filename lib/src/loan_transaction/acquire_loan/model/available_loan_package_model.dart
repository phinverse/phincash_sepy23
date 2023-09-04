// To parse this JSON data, do
//
//     final availableLoanPackages = availableLoanPackagesFromJson(jsonString);

import 'dart:convert';

AvailableLoanPackages availableLoanPackagesFromJson(String str) => AvailableLoanPackages.fromJson(json.decode(str));

String availableLoanPackagesToJson(AvailableLoanPackages data) => json.encode(data.toJson());

class AvailableLoanPackages {
  AvailableLoanPackages({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<LoanPackages>? data;

  factory AvailableLoanPackages.fromJson(Map<String, dynamic> json) => AvailableLoanPackages(
    status: json["status"],
    message: json["message"],
    data: List<LoanPackages>.from(json["data"].map((x) => LoanPackages.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LoanPackages {
  LoanPackages({
    this.id,
    this.name,
    this.amount,
    this.duration,
    this.interestRate,
    this.overdueInterestRate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? amount;
  int? duration;
  String? interestRate;
  double? overdueInterestRate;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LoanPackages.fromJson(Map<String, dynamic> json) => LoanPackages(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
    duration: json["duration"],
    interestRate: json["interest_rate"],
    overdueInterestRate: json["overdue_interest_rate"].toDouble(),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "duration": duration,
    "interest_rate": interestRate,
    "overdue_interest_rate": overdueInterestRate,
    "status": status,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}
