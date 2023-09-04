import 'dart:convert';

FaqResponseData faqResponseDataFromJson(String str) => FaqResponseData.fromJson(json.decode(str));

String faqResponseDataToJson(FaqResponseData data) => json.encode(data.toJson());

class FaqResponseData {
  FaqResponseData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<FAQ>? data;

  factory FaqResponseData.fromJson(Map<String, dynamic> json) => FaqResponseData(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<FAQ>.from(json["data"].map((x) => FAQ.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FAQ {
  FAQ({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
    question: json["question"] == null ? null : json["question"],
    answer: json["answer"] == null ? null : json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question == null ? null : question,
    "answer": answer == null ? null : answer,
  };
}
