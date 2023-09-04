// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<NotificationList>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationList {
  NotificationList({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  DateTime? readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: Data.fromJson(json["data"]),
    readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Data {
  Data({
    this.accountId,
    this.notificationType,
    this.notificationText,
    this.loanId,
  });

  int? accountId;
  String? notificationType;
  String? notificationText;
  int? loanId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accountId: json["account_id"] == null ? null : json["account_id"],
    notificationType: json["notification_type"],
    notificationText: json["notification_text"],
    loanId: json["loan_id"] == null ? null : json["loan_id"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId == null ? null : accountId,
    "notification_type": notificationType,
    "notification_text": notificationText,
    "loan_id": loanId == null ? null : loanId,
  };
}
