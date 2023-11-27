
import 'dart:convert';

BvnConsent bvnConsentFromJson(String str) =>
    BvnConsent.fromJson(json.decode(str));

String bvnConsentToJson(BvnConsent data) => json.encode(data.toJson());
class BvnConsent {
  String status;
  String message;
  Data data;

  BvnConsent({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BvnConsent.fromJson(Map<String, dynamic> json) => BvnConsent(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String firstName;
  String lastName;
  String status;
  String reference;
  dynamic callbackUrl;
  BvnData bvnData;
  DateTime createdAt;

  Data({
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.reference,
    required this.callbackUrl,
    required this.bvnData,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    status: json["status"],
    reference: json["reference"],
    callbackUrl: json["callback_url"],
    bvnData: BvnData.fromJson(json["bvn_data"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "status": status,
    "reference": reference,
    "callback_url": callbackUrl,
    "bvn_data": bvnData.toJson(),
    "created_at": createdAt.toIso8601String(),
  };
}

class BvnData {
  String nin;
  String email;
  String gender;
  String surname;
  dynamic serialNo;
  String faceImage;
  String firstName;
  dynamic landmarks;
  dynamic branchName;
  String middleName;
  dynamic nameOnCard;
  String dateOfBirth;
  String lgaOfOrigin;
  String watchlisted;
  dynamic lgaOfCapture;
  String phoneNumber1;
  dynamic phoneNumber2;
  String maritalStatus;
  String stateOfOrigin;
  dynamic enrollBankCode;
  String enrollUserName;
  dynamic enrollmentDate;
  String lgaOfResidence;
  String stateOfCapture;
  dynamic additionalInfo1;
  String productReference;
  String stateOfResidence;

  BvnData({
    required this.nin,
    required this.email,
    required this.gender,
    required this.surname,
    required this.serialNo,
    required this.faceImage,
    required this.firstName,
    required this.landmarks,
    required this.branchName,
    required this.middleName,
    required this.nameOnCard,
    required this.dateOfBirth,
    required this.lgaOfOrigin,
    required this.watchlisted,
    required this.lgaOfCapture,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.maritalStatus,
    required this.stateOfOrigin,
    required this.enrollBankCode,
    required this.enrollUserName,
    required this.enrollmentDate,
    required this.lgaOfResidence,
    required this.stateOfCapture,
    required this.additionalInfo1,
    required this.productReference,
    required this.stateOfResidence,
  });

  factory BvnData.fromJson(Map<String, dynamic> json) => BvnData(
    nin: json["nin"],
    email: json["email"],
    gender: json["gender"],
    surname: json["surname"],
    serialNo: json["serialNo"],
    faceImage: json["faceImage"],
    firstName: json["firstName"],
    landmarks: json["landmarks"],
    branchName: json["branchName"],
    middleName: json["middleName"],
    nameOnCard: json["nameOnCard"],
    dateOfBirth: json["dateOfBirth"],
    lgaOfOrigin: json["lgaOfOrigin"],
    watchlisted: json["watchlisted"],
    lgaOfCapture: json["lgaOfCapture"],
    phoneNumber1: json["phoneNumber1"],
    phoneNumber2: json["phoneNumber2"],
    maritalStatus: json["maritalStatus"],
    stateOfOrigin: json["stateOfOrigin"],
    enrollBankCode: json["enrollBankCode"],
    enrollUserName: json["enrollUserName"],
    enrollmentDate: json["enrollmentDate"],
    lgaOfResidence: json["lgaOfResidence"],
    stateOfCapture: json["stateOfCapture"],
    additionalInfo1: json["additionalInfo1"],
    productReference: json["productReference"],
    stateOfResidence: json["stateOfResidence"],
  );

  Map<String, dynamic> toJson() => {
    "nin": nin,
    "email": email,
    "gender": gender,
    "surname": surname,
    "serialNo": serialNo,
    "faceImage": faceImage,
    "firstName": firstName,
    "landmarks": landmarks,
    "branchName": branchName,
    "middleName": middleName,
    "nameOnCard": nameOnCard,
    "dateOfBirth": dateOfBirth,
    "lgaOfOrigin": lgaOfOrigin,
    "watchlisted": watchlisted,
    "lgaOfCapture": lgaOfCapture,
    "phoneNumber1": phoneNumber1,
    "phoneNumber2": phoneNumber2,
    "maritalStatus": maritalStatus,
    "stateOfOrigin": stateOfOrigin,
    "enrollBankCode": enrollBankCode,
    "enrollUserName": enrollUserName,
    "enrollmentDate": enrollmentDate,
    "lgaOfResidence": lgaOfResidence,
    "stateOfCapture": stateOfCapture,
    "additionalInfo1": additionalInfo1,
    "productReference": productReference,
    "stateOfResidence": stateOfResidence,
  };
}