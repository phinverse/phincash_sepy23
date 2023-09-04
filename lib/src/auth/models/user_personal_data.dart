import 'dart:convert';

UserPersonalData userPersonalDataFromJson(String str) =>
    UserPersonalData.fromJson(json.decode(str));

String userPersonalDataToJson(UserPersonalData data) =>
    json.encode(data.toJson());

class UserPersonalData {
  UserPersonalData({
    required this.message,
    required this.user,
  });
  late final String message;
  late final User user;

  UserPersonalData.fromJson(Map<String, dynamic> json) {
    message = json['0'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['0'] = message;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.userPhoto,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.maritalStatus,
    required this.religion,
    required this.highestEduLevel,
    required this.residentialAddress,
    required this.dateOfBirth,
    required this.mainWalletAmount,
    required this.secondaryWalletAmount,
    this.secondaryWalletDueAt,
    required this.maxLoanLimit,
    this.currentLoanId,
    required this.onboardStage,
    required this.kycVerificationStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.hasLoanOverdue,
    required this.hasUnpaidLoan,
    required this.fullName,
    required this.loans,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String middleName;
  late final dynamic userPhoto;
  late final String email;
  late final String phoneNumber;
  late final String gender;
  late final String maritalStatus;
  late final String religion;
  late final String highestEduLevel;
  late final String residentialAddress;
  late final String dateOfBirth;
  late final int mainWalletAmount;
  late final int secondaryWalletAmount;
  late final dynamic secondaryWalletDueAt;
  late final String maxLoanLimit;
  late final dynamic currentLoanId;
  late final String onboardStage;
  late final String kycVerificationStatus;
  late final String createdAt;
  late final String updatedAt;
  late final String currentLoanStatus;
  late final bool hasLoanOverdue;
  late final bool hasUnpaidLoan;
  late final String fullName;
  late final List<dynamic> loans;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    userPhoto = json['user_photo'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    religion = json['religion'];
    highestEduLevel = json['highest_edu_level'];
    residentialAddress = json['residential_address'];
    dateOfBirth = json['date_of_birth'];
    mainWalletAmount = json['main_wallet_amount'];
    secondaryWalletAmount = json['secondary_wallet_amount'];
    secondaryWalletDueAt = json['secondary_wallet_due_at'];
    maxLoanLimit = json['max_loan_limit'];
    currentLoanId = json['current_loan_id'];
    onboardStage = json['onboard_stage'];
    kycVerificationStatus = json['kyc_verification_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currentLoanStatus = json['current_loan_status'] ?? "";
    hasLoanOverdue = json['has_loan_overdue'];
    hasUnpaidLoan = json['has_unpaid_loan'];
    fullName = json['full_name'];
    loans = List.castFrom<dynamic, dynamic>(json['loans']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['middle_name'] = middleName;
    _data['user_photo'] = userPhoto;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['gender'] = gender;
    _data['marital_status'] = maritalStatus;
    _data['religion'] = religion;
    _data['highest_edu_level'] = highestEduLevel;
    _data['residential_address'] = residentialAddress;
    _data['date_of_birth'] = dateOfBirth;
    _data['main_wallet_amount'] = mainWalletAmount;
    _data['secondary_wallet_amount'] = secondaryWalletAmount;
    _data['secondary_wallet_due_at'] = secondaryWalletDueAt;
    _data['max_loan_limit'] = maxLoanLimit;
    _data['current_loan_id'] = currentLoanId;
    _data['onboard_stage'] = onboardStage;
    _data['kyc_verification_status'] = kycVerificationStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['current_loan_status'] = currentLoanStatus;
    _data['has_loan_overdue'] = hasLoanOverdue;
    _data['has_unpaid_loan'] = hasUnpaidLoan;
    _data['full_name'] = fullName;
    _data['loans'] = loans;
    return _data;
  }
}
