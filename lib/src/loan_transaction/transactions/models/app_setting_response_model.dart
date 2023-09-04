// To parse this JSON data, do
//
//     final appSettingsResponseData = appSettingsResponseDataFromJson(jsonString);

import 'dart:convert';

AppSettingsResponseData appSettingsResponseDataFromJson(String str) => AppSettingsResponseData.fromJson(json.decode(str));

String appSettingsResponseDataToJson(AppSettingsResponseData data) => json.encode(data.toJson());

class AppSettingsResponseData {
  AppSettingsResponseData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AppSettingsResponseData.fromJson(Map<String, dynamic> json) => AppSettingsResponseData(
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
    this.appName,
    this.appLogo,
    this.appCurrency,
    this.appCurrencySymbol,
    this.supportedGateways,
    this.contactEmail,
    this.contactPhone,
    this.contactAddress,
    this.minEmergencyContact,
    this.automaticDisbursement,
  });

  String? appName;
  String? appLogo;
  String? appCurrency;
  String? appCurrencySymbol;
  String? supportedGateways;
  String? contactEmail;
  String? contactPhone;
  String? contactAddress;
  String? minEmergencyContact;
  String? automaticDisbursement;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appName: json["app_name"] == null ? null : json["app_name"],
    appLogo: json["app_logo"] == null ? null : json["app_logo"],
    appCurrency: json["app_currency"] == null ? null : json["app_currency"],
    appCurrencySymbol: json["app_currency_symbol"] == null ? null : json["app_currency_symbol"],
    supportedGateways: json["supported_gateways"] == null ? null : json["supported_gateways"],
    contactEmail: json["contact_email"] == null ? null : json["contact_email"],
    contactPhone: json["contact_phone"] == null ? null : json["contact_phone"],
    contactAddress: json["contact_address"] == null ? null : json["contact_address"],
    minEmergencyContact: json["min_emergency_contact"] == null ? null : json["min_emergency_contact"],
    automaticDisbursement: json["automatic_disbursement"] == null ? null : json["automatic_disbursement"],
  );

  Map<String, dynamic> toJson() => {
    "app_name": appName == null ? null : appName,
    "app_logo": appLogo == null ? null : appLogo,
    "app_currency": appCurrency == null ? null : appCurrency,
    "app_currency_symbol": appCurrencySymbol == null ? null : appCurrencySymbol,
    "supported_gateways": supportedGateways == null ? null : supportedGateways,
    "contact_email": contactEmail == null ? null : contactEmail,
    "contact_phone": contactPhone == null ? null : contactPhone,
    "contact_address": contactAddress == null ? null : contactAddress,
    "min_emergency_contact": minEmergencyContact == null ? null : minEmergencyContact,
    "automatic_disbursement": automaticDisbursement == null ? null : automaticDisbursement,
  };
}
