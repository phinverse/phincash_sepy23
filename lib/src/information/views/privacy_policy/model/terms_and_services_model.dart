// To parse this JSON data, do
//
//     final termsAndServicesResponseData = termsAndServicesResponseDataFromJson(jsonString);

import 'dart:convert';

TermsAndServicesResponseData termsAndServicesResponseDataFromJson(String str) => TermsAndServicesResponseData.fromJson(json.decode(str));

String termsAndServicesResponseDataToJson(TermsAndServicesResponseData data) => json.encode(data.toJson());

class TermsAndServicesResponseData {
  TermsAndServicesResponseData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory TermsAndServicesResponseData.fromJson(Map<String, dynamic> json) => TermsAndServicesResponseData(
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
    this.slug,
    this.title,
    this.body,
  });

  String? slug;
  String? title;
  String? body;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    slug: json["slug"] == null ? null : json["slug"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug == null ? null : slug,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
  };
}
