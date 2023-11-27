import 'dart:convert';

EmergencyContactData emergencyContactDataFromJson(String str) => EmergencyContactData.fromJson(json.decode(str));

String emergencyContactDataToJson(EmergencyContactData data) => json.encode(data.toJson());

class EmergencyContactData {
  EmergencyContactData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<EmergencyContacts>? data;

  factory EmergencyContactData.fromJson(Map<String, dynamic> json) => EmergencyContactData(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<EmergencyContacts>.from(json["data"].map((x) => EmergencyContacts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EmergencyContacts {
  EmergencyContacts({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.relationship,
    this.contactAddress,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? relationship;
  String? contactAddress;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EmergencyContacts.fromJson(Map<String, dynamic> json) => EmergencyContacts(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    email: json["email"] == null ? null : json["email"],
    relationship: json["relationship"] == null ? null : json["relationship"],
    contactAddress: json["contact_address"] == null ? null : json["contact_address"],
    userId: json["user_id"] == null ? null : int.tryParse(json["user_id"] ?? ""),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "email": email == null ? null : email,
    "relationship": relationship == null ? null : relationship,
    "contact_address": contactAddress == null ? null : contactAddress,
    "user_id": userId == null ? null : userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
