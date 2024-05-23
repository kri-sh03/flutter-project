// To parse this JSON data, do
//
//     final getPersonalDetailsModel = getPersonalDetailsModelFromJson(jsonString);

import 'dart:convert';

GetPersonalDetailsModel getPersonalDetailsModelFromJson(String str) =>
    GetPersonalDetailsModel.fromJson(json.decode(str));

String getPersonalDetailsModelToJson(GetPersonalDetailsModel data) =>
    json.encode(data.toJson());

class GetPersonalDetailsModel {
  PersonalStruct personalStruct;
  String status;
  String errMsg;

  GetPersonalDetailsModel({
    required this.personalStruct,
    required this.status,
    required this.errMsg,
  });

  factory GetPersonalDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetPersonalDetailsModel(
        personalStruct: PersonalStruct.fromJson(json["personalStruct"]),
        status: json["status"] ?? "",
        errMsg: json["ErrMsg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "personalStruct": personalStruct.toJson(),
        "status": status,
        "ErrMsg": errMsg,
      };
}

class PersonalStruct {
  String fatherNameTitle;
  String motherNameTitle;
  String fatherName;
  String motherName;
  String annualIncome;
  String tradingExperience;
  String occupation;
  String gender;
  String emailOwner;
  String phoneOwner;
  String politicalExpo;
  String maritalStatus;
  String education;
  String nomineeOpted;
  String emailOwnerName;
  String phoneOwnerName;
  String occOthers;
  String educationOthers;

  PersonalStruct({
    required this.fatherNameTitle,
    required this.motherNameTitle,
    required this.fatherName,
    required this.motherName,
    required this.annualIncome,
    required this.tradingExperience,
    required this.occupation,
    required this.gender,
    required this.emailOwner,
    required this.phoneOwner,
    required this.politicalExpo,
    required this.maritalStatus,
    required this.education,
    required this.nomineeOpted,
    required this.educationOthers,
    required this.phoneOwnerName,
    required this.emailOwnerName,
    required this.occOthers,
  });

  factory PersonalStruct.fromJson(Map<String, dynamic>? json) => PersonalStruct(
        fatherNameTitle: json!["fathertitle"] ?? "",
        motherNameTitle: json["mothertitle"] ?? "",
        fatherName: json["fathername"] ?? "",
        motherName: json["mothername"] ?? "",
        annualIncome: json["annualincome"] ?? "",
        tradingExperience: json["tradingexperience"] ?? "",
        occupation: json["occupation"] ?? "",
        gender: json["gender"] ?? "",
        emailOwner: json["emailowner"] ?? "",
        phoneOwner: json["phoneowner"] ?? "",
        politicalExpo: json["politicalexpo"] ?? "",
        maritalStatus: json["maritalstatus"] ?? "",
        education: json["education"] ?? "",
        nomineeOpted: json["nomineeopted"] ?? "",
        phoneOwnerName: json["phoneownername"] ?? "",
        emailOwnerName: json["emailOwnername"] ?? "",
        educationOthers: json["educationothers"] ?? "",
        occOthers: json["occupationothers"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fathername": fatherName,
        "mothername": motherName,
        "annualincome": annualIncome,
        "tradingexperience": tradingExperience,
        "occupation": occupation,
        "gender": gender,
        "emailowner": emailOwner,
        "phoneowner": phoneOwner,
        "politicalexpo": politicalExpo,
        "maritalstatus": maritalStatus,
        "education": education,
        "nomineeopted": nomineeOpted,
        "phoneownername": phoneOwnerName,
        "emailOwnername": emailOwnerName,
        "educationothers": educationOthers,
        "occupationothers": occOthers,
      };
}
