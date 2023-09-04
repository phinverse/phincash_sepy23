import 'dart:convert';

BvnConsent bvnConsentFromJson(String str) =>
    BvnConsent.fromJson(json.decode(str));

String bvnConsentToJson(BvnConsent data) => json.encode(data.toJson());
class BvnConsent {
  BvnConsent({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final Data data;

  BvnConsent.fromJson(Map<String, dynamic> json){
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
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.reference,
     this.callbackUrl,
    required this.bvnData,
    required this.createdAt,
  });
  late final String firstName;
  late final String lastName;
  late final String status;
  late final String reference;
  late final dynamic callbackUrl;
  late final BvnData bvnData;
  late final String createdAt;
  
  Data.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    lastName = json['last_name'];
    status = json['status'];
    reference = json['reference'];
    callbackUrl = dynamic;
    bvnData = BvnData.fromJson(json['bvn_data']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['status'] = status;
    _data['reference'] = reference;
    _data['callback_url'] = callbackUrl;
    _data['bvn_data'] = bvnData.toJson();
    _data['created_at'] = createdAt;
    return _data;
  }
}

class BvnData {
  BvnData({
     this.nin,
     this.email,
    required this.gender,
    required this.surname,
     this.serialNo,
    required this.faceImage,
    required this.firstName,
     this.landmarks,
     this.branchName,
    required this.middleName,
     this.nameOnCard,
    required this.dateOfBirth,
    required this.lgaOfOrigin,
    required this.watchlisted,
     this.lgaOfCapture,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.maritalStatus,
    required this.stateOfOrigin,
     this.enrollBankCode,
    required this.enrollUserName,
     this.enrollmentDate,
    required this.lgaOfResidence,
    required this.stateOfCapture,
     this.additionalInfo1,
    required this.productReference,
    required this.stateOfResidence,
  });
  late final dynamic nin;
  late final dynamic email;
  late final String gender;
  late final String surname;
  late final dynamic serialNo;
  late final String faceImage;
  late final String firstName;
  late final dynamic landmarks;
  late final dynamic branchName;
  late final String middleName;
  late final dynamic nameOnCard;
  late final String dateOfBirth;
  late final String lgaOfOrigin;
  late final String watchlisted;
  late final dynamic lgaOfCapture;
  late final String phoneNumber1;
  late final String phoneNumber2;
  late final String maritalStatus;
  late final String stateOfOrigin;
  late final dynamic enrollBankCode;
  late final String enrollUserName;
  late final dynamic enrollmentDate;
  late final String lgaOfResidence;
  late final String stateOfCapture;
  late final dynamic additionalInfo1;
  late final String productReference;
  late final String stateOfResidence;

  BvnData.fromJson(Map<String, dynamic> json){
    nin = json['nin'];
    email = json['email'];
    gender = json['gender'];
    surname = json['surname'];
    serialNo = json['serialNo'];
    faceImage = json['faceImage'];
    firstName = json['firstName'];
    landmarks = json['landmarks'];;
    branchName = json['branchName'];
    middleName = json['middleName'];
    nameOnCard = json['nameOnCard'];
    dateOfBirth = json['dateOfBirth'];
    lgaOfOrigin = json['lgaOfOrigin'];
    watchlisted = json['watchlisted'];
    lgaOfCapture = json['lgaOfCapture'];
    phoneNumber1 = json['phoneNumber1'];
    phoneNumber2 = json['phoneNumber2'];
    maritalStatus = json['maritalStatus'];
    stateOfOrigin = json['stateOfOrigin'];
    enrollBankCode = json['enrolBankCode'];
    enrollUserName = json['enrollUserName'];
    enrollmentDate = json['enrollmentDate'];
    lgaOfResidence = json['lgaOfResidence'];
    stateOfCapture = json['stateOfCapture'];
    additionalInfo1 = json['additionalInfo1'];
    productReference = json['productReference'];
    stateOfResidence = json['stateOfResidence'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nin'] = nin;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['surname'] = surname;
    _data['serialNo'] = serialNo;
    _data['faceImage'] = faceImage;
    _data['firstName'] = firstName;
    _data['landmarks'] = landmarks;
    _data['branchName'] = branchName;
    _data['middleName'] = middleName;
    _data['nameOnCard'] = nameOnCard;
    _data['dateOfBirth'] = dateOfBirth;
    _data['lgaOfOrigin'] = lgaOfOrigin;
    _data['watchlisted'] = watchlisted;
    _data['lgaOfCapture'] = lgaOfCapture;
    _data['phoneNumber1'] = phoneNumber1;
    _data['phoneNumber2'] = phoneNumber2;
    _data['maritalStatus'] = maritalStatus;
    _data['stateOfOrigin'] = stateOfOrigin;
    _data['enrollBankCode'] = enrollBankCode;
    _data['enrollUserName'] = enrollUserName;
    _data['enrollmentDate'] = enrollmentDate;
    _data['lgaOfResidence'] = lgaOfResidence;
    _data['stateOfCapture'] = stateOfCapture;
    _data['additionalInfo1'] = additionalInfo1;
    _data['productReference'] = productReference;
    _data['stateOfResidence'] = stateOfResidence;
    return _data;
  }
}