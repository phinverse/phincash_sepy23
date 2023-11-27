import 'dart:convert';

BvnDetails bvnDetailsFromJson(String str) =>
    BvnDetails.fromJson(json.decode(str));

String bvnDetailsToJson(BvnDetails data) => json.encode(data);

class BvnDetails {
  final String status;
  final String message;
  final BvnData? data;

  BvnDetails({
    required this.status,
    required this.message,
    this.data,
  });

  factory BvnDetails.fromJson(Map<String, dynamic> json) {
    return BvnDetails(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] != null ? BvnData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class BvnData {
  final String firstName;
  final String lastName;
  final String status;
  final String reference;
  final String? callbackUrl;
  final BvnConsentInfo? bvnConsentInfo;
  final String createdAt;

  BvnData({
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.reference,
    this.callbackUrl,
    this.bvnConsentInfo,
    required this.createdAt,
  });

  factory BvnData.fromJson(Map<String, dynamic> json) {
    return BvnData(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      status: json['status'] as String,
      reference: json['reference'] as String,
      callbackUrl: json['callback_url'] as String?,
      bvnConsentInfo: json['bvn_data'] != null ? BvnConsentInfo.fromJson(json['bvn_data'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] as String,
    );
  }
}

class BvnConsentInfo {
  final String status;
  final String message;
  final BvnInfo data;

  BvnConsentInfo({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BvnConsentInfo.fromJson(Map<String, dynamic> json) {
    return BvnConsentInfo(
      status: json['status'] as String,
      message: json['message'] as String,
      data: BvnInfo.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class BvnInfo {
  final String nin;
  final String email;
  final String gender;
  final String surname;
  final String? serialNo;
  final String? faceImage;
  final String firstName;
  final String? landmarks;
  final String? branchName;
  final String? middleName;
  final String? nameOnCard;
  final String? dateOfBirth;
  final String? lgaOfOrigin;
  final String? watchlisted;
  final String? lgaOfCapture;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? maritalStatus;
  final String? stateOfOrigin;
  final String? enrollBankCode;
  final String? enrollUserName;
  final String? enrollmentDate;
  final String? lgaOfResidence;
  final String? stateOfCapture;
  final String? additionalInfo1;
  final String? productReference;
  final String? stateOfResidence;

  BvnInfo({
    required this.nin,
    required this.email,
    required this.gender,
    required this.surname,
    this.serialNo,
    this.faceImage,
    required this.firstName,
    this.landmarks,
    this.branchName,
    this.middleName,
    this.nameOnCard,
    this.dateOfBirth,
    this.lgaOfOrigin,
    this.watchlisted,
    this.lgaOfCapture,
    this.phoneNumber1,
    this.phoneNumber2,
    this.maritalStatus,
    this.stateOfOrigin,
    this.enrollBankCode,
    this.enrollUserName,
    this.enrollmentDate,
    this.lgaOfResidence,
    this.stateOfCapture,
    this.additionalInfo1,
    this.productReference,
    this.stateOfResidence,
  });

  factory BvnInfo.fromJson(Map<String, dynamic> json) {
    return BvnInfo(
      nin: json['nin'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      surname: json['surname'] as String,
      serialNo: json['serialNo'] as String?,
      faceImage: json['faceImage'] as String?,
      firstName: json['firstName'] as String,
      landmarks: json['landmarks'] as String?,
      branchName: json['branchName'] as String?,
      middleName: json['middleName'] as String,
      nameOnCard: json['nameOnCard'] as String?,
      dateOfBirth: json['dateOfBirth'] as String,
      lgaOfOrigin: json['lgaOfOrigin'] as String,
      watchlisted: json['watchlisted'] as String,
      lgaOfCapture: json['lgaOfCapture'] as String?,
      phoneNumber1: json['phoneNumber1'] as String,
      phoneNumber2: json['phoneNumber2'] as String?,
      maritalStatus: json['maritalStatus'] as String,
      stateOfOrigin: json['stateOfOrigin'] as String,
      enrollBankCode: json['enrollBankCode'] as String?,
      enrollUserName: json['enrollUserName'] as String,
      enrollmentDate: json['enrollmentDate'] as String?,
      lgaOfResidence: json['lgaOfResidence'] as String,
      stateOfCapture: json['stateOfCapture'] as String,
      additionalInfo1: json['additionalInfo1'] as String?,
      productReference: json['productReference'] as String,
      stateOfResidence: json['stateOfResidence'] as String,
    );
  }
}
