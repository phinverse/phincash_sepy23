import 'dart:convert';

BvnResponse bvnResponseFromJson(String str) =>
    BvnResponse.fromJson(json.decode(str));

String bvnResponseToJson(BvnResponse data) => json.encode(data.toJson());

class BvnResponse {
  BvnResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final Data data;

  BvnResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.url,
    required this.reference,
  });
   String? url;
   String? reference;

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'] != null ? json['url'] : null;
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['reference'] = reference;
    return _data;
  }
}
