import 'dart:convert';

SupportedBanks supportedBanksFromJson(String str) => SupportedBanks.fromJson(json.decode(str));

String supportedBanksToJson(SupportedBanks data) => json.encode(data.toJson());

class SupportedBanks {
  SupportedBanks({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<SupportBanks>? data;

  factory SupportedBanks.fromJson(Map<String, dynamic> json) => SupportedBanks(
    status: json["status"],
    message: json["message"],
    data: List<SupportBanks>.from(json["data"].map((x) => SupportBanks.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SupportBanks {
  SupportBanks({
    this.name,
    this.code,
  });

  String? name;
  String? code;

  factory SupportBanks.fromJson(Map<String, dynamic> json) => SupportBanks(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}
