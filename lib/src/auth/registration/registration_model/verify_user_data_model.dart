import 'dart:convert';

VerifyUserData verifyUserDataFromJson(String str) => VerifyUserData.fromJson(json.decode(str));

String verifyUserDataToJson(VerifyUserData data) => json.encode(data.toJson());

class VerifyUserData {
  VerifyUserData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory VerifyUserData.fromJson(Map<String, dynamic> json) => VerifyUserData(
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
    this.verificationUrl,
  });

  String? verificationUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    verificationUrl: json["verification_url"],
  );

  Map<String, dynamic> toJson() => {
    "verification_url": verificationUrl,
  };
}
