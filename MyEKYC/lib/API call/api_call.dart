// import 'dart:convert';
// import 'dart:typed_data';

// import '../Cookies/HttpClient.dart';
// import '../Cookies/cookies.dart';
// import '../Custom%20Widgets/custom_snackBar.dart';
// import '../Model/card_details_model.dart';
// import '../Model/get_bank_detail_ifsc_model.dart';
// import '../Model/get_bank_details_model.dart';
// import 'package:flutter/material.dart';

// import '../Model/get_pers_info_model.dart';

// exceptionShowSnackBarContent(String content) {
//   print(content);
//   if (content.contains("Network is unreachable")) {
//     return "Network is unreachable";
//   } else if (content.contains("Connection refused")) {
//     return "Network Error";
//   } else {
//     return content;
//   }
// }

// logout(context) {}

// otpCallAPI({required json, required context}) async {
//   try {
//     var response = await CustomHttpClient.putWithOutCookie("api/sendOtp", json);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// validateOTPAPI({required json, required context}) async {
//   try {
//     var response =
//         await CustomHttpClient.putWithOutCookie("api/validotp", json);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["msg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// getDropDownValues({required context, required json}) async {
//   try {
//     //  postWithOutCookie("dropDowndata", json)
//     var response = await CustomHttpClient.post("dropDowndata", json, context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     print(e.toString());
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// loginAPI({required context, required json}) async {
//   try {
//     print(json);
//     var response =
//         await CustomHttpClient.logInPut("api/newuser", json, context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["msg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// fetchCardDetailApi(BuildContext context) async {
//   try {
//     var response = await CustomHttpClient.get("CardDetails", context);
//     print(response.body);
//     if (response.statusCode == 200) {
//       CardDetailsModel cardDetailsModel =
//           cardDetailsModelFromJson(response.body);
//       if (cardDetailsModel.status == "S") {
//         return cardDetailsModel;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, cardDetailsModel.errMsg, Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// fetchBankDetailApi(BuildContext context) async {
//   try {
//     var response = await CustomHttpClient.get("BankDetails", context);
//     print(response.body);
//     if (response.statusCode == 200) {
//       BankDetailsModel bankDetailsModel =
//           bankDetailsModelFromJson(response.body);
//       if (bankDetailsModel.status == "S") {
//         return bankDetailsModel;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, bankDetailsModel.errMsg, Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// // fetchPersonalDetailFromApi(BuildContext context) async {
// //   try {
// //     var response = await get("PersonalDetails", context);
// //     print(response.body);
// //     if (response.statusCode == 200) {
// //       PersonalDetailModel personalDetailModel =
// //           personalDetailModalFromJson(response.body);

// //       if (personalDetailModel.status == "S") {
// //         return personalDetailModel;
// //       } else {
// //         if (!context.mounted) return;
// //         showSnackbar(context, personalDetailModel.errMsg, Colors.red);
// //       }
// //     }
// //   } catch (e) {
// //     if (!context.mounted) return;
// //     showSnackbar(
// //         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
// //   }
// //   return null;
// // }

// postManualEntryDetail({
//   required BuildContext context,
//   required json,

//   // required List<dynamic> file
// }) async {
//   try {
//     var response =
//         await CustomHttpClient.post('api/manual_entry', json, context);

//     if (response.statusCode == 200) {
//       Map res = jsonDecode(response.body);

//       if (res["status"] == "S") {
//         return res;
//       } else {
//         showSnackbar(context, res["msg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     return exceptionShowSnackBarContent(e.toString());
//   }

//   return null;
// }

// // addPersInfo({
// //   required BuildContext context,
// //   required String maritalStatus,
// //   required String gender,
// //   required String emailOwner,
// //   required String phoneOwner,
// //   required String fatherName,
// //   required String motherName,
// //   required String annualIncome,
// //   required String tradingExperience,
// //   required String occupation,
// //   required String politicalExpo,
// //   required String education,
// //   required String nomineeOpted,
// // }) async {
// //   try {
// //     var response = await put(
// //         "InsertDetails",
// //         // PersInfoModel(
// //         //     maritalStatus: maritalStatus,
// //         //     gender: gender,
// //         //     emailOwner: emailOwner,
// //         //     phoneOwner: phoneOwner,
// //         //     fatherName: fatherName,
// //         //     motherName: motherName,
// //         //     annualIncome: annualIncome,
// //         //     tradingExperience: tradingExperience,
// //         //     occupation: occupation,
// //         //     politicalExpo: politicalExpo,
// //         //     education: education,
// //         //     nomineeOpted: nomineeOpted),
// //         {
// //           "maritalStatus": maritalStatus,
// //           "gender": gender,
// //           "emailOwner": emailOwner,
// //           "phoneOwner": phoneOwner,
// //           "fatherName": fatherName,
// //           "motherName": motherName,
// //           "annualIncome": annualIncome,
// //           "tradingExperience": tradingExperience,
// //           "occupation": occupation,
// //           "politicalExpo": politicalExpo,
// //           "education": education,
// //           "nomineeOpted": nomineeOpted
// //         },
// //         context);
// //     print("response.body ${response.body}");

// //     if (response.statusCode == 200) {
// //       Map res = jsonDecode(response.body);
// //       if (res["status"] == "S") {
// //         return "success";
// //       } else {
// //         return res["msg"];
// //       }
// //     }
// //   } catch (e) {
// //     print("EXCEPTION IN PUT: $e");
// //     return exceptionShowSnackBarContent(e.toString());
// //   }
// //   return null;
// // }

// fetchPersonalDetailFromApi(BuildContext context) async {
//   try {
//     var response = await CustomHttpClient.get("PersonalDetails", context);

//     if (response.statusCode == 200) {
//       print("fetchpersonal details");
//       print(response.body);
//       GetPersonalDetailsModel personalDetailModel =
//           getPersonalDetailsModelFromJson(response.body);

//       if (personalDetailModel.status == "S") {
//         return personalDetailModel;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, personalDetailModel.errMsg, Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// addPersInfo({
//   required BuildContext context,
//   required String maritalStatus,
//   required String gender,
//   required String emailOwner,
//   required String phoneOwner,
//   required String fatherName,
//   required String motherName,
//   required String annualIncome,
//   required String tradingExperience,
//   required String occupation,
//   required String politicalExpo,
//   required String education,
//   required String nomineeOpted,
// }) async {
//   print(jsonEncode({
//     "maritalStatus": maritalStatus,
//     "gender": gender,
//     "emailOwner": emailOwner,
//     "phoneOwner": phoneOwner,
//     "fatherName": fatherName,
//     "motherName": motherName,
//     "annualIncome": annualIncome,
//     "tradingExperience": tradingExperience,
//     "occupation": occupation,
//     "politicalExpo": politicalExpo,
//     "education": education,
//     "nomineeOpted": nomineeOpted
//   }));
//   try {
//     var response = await CustomHttpClient.put(
//         "InsertDetails",
//         {
//           "maritalStatus": maritalStatus,
//           "gender": gender,
//           "emailOwner": emailOwner,
//           "phoneOwner": phoneOwner,
//           "fatherName": fatherName,
//           "motherName": motherName,
//           "annualIncome": annualIncome,
//           "tradingExperience": tradingExperience,
//           "occupation": occupation,
//           "politicalExpo": politicalExpo,
//           "education": education,
//           "nomineeOpted": nomineeOpted
//         },
//         context);
//     print("response.body ${response}");

//     if (response.statusCode == 200) {
//       Map res = jsonDecode(response.body);
//       if (res["status"] == "S") {
//         return res;
//       } else {
//         showSnackbar(context, res["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     print("EXCEPTION IN PUT: $e");
//     return exceptionShowSnackBarContent(e.toString());
//   }
//   return null;
// }

// postPanNo({
//   required context,
//   required String pannumber,
//   required String pandob,
// }) async {
//   try {
//     var response = await CustomHttpClient.post(
//         "api/getpanstatus",
//         {
//           "pannumber": pannumber,
//           "pandob": pandob,
//         },
//         context);

//     if (response.statusCode == 200) {
//       Map res = jsonDecode(response.body);
//       if (res["status"] == "S") {
//         return res;
//       } else {
//         showSnackbar(context, res["msg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     return exceptionShowSnackBarContent(e.toString());
//   }
//   return null;
// }

// getAddressStatusAPI({required BuildContext context}) async {
//   try {
//     var response = await CustomHttpClient.get("api/addressStatus", context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, json['errmsg'], Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// getAddressAPI({required BuildContext context}) async {
//   try {
//     var response = await CustomHttpClient.get("api/getAddress", context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, json['errmsg'], Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// getKraPanSoapAPI({required BuildContext context}) async {
//   try {
//     var response =
//         await CustomHttpClient.post("api/get_kra_pan_soap", {}, context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         return "";
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// kycInfoAPI({required json, required BuildContext context}) async {
//   try {
//     var response = await CustomHttpClient.post("api/kycinfo", json, context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, json['msg'], Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// getDigiLockerUrlAPI({required BuildContext context}) async {
//   try {
//     var response = await CustomHttpClient.get(
//         "redirect_url", context, "http://192.168.2.132:28095/api/");
//     print(response.body);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, json['errmsg'], Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// getBankDetailsAPI({required BuildContext context, required ifscCode}) async {
//   try {
//     var response = await CustomHttpClient.put(
//         "IfscDetails", {"ifscCode": ifscCode}, context);
//     if (response.statusCode == 200) {
//       FetchBankDetailByIfsc fetchBankDetailByIfsc =
//           fetchBankDetailByIfscFromJson(response.body);
//       if (fetchBankDetailByIfsc.status == "S") {
//         return fetchBankDetailByIfsc;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, fetchBankDetailByIfsc.errMsg, Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

// insertBankDetailsAPI({required context, required json}) async {
//   try {
//     var response =
//         await CustomHttpClient.put("InsertBankDetail", json, context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         print(json["errMsg"]);
//         showSnackbar(context, json["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// getBankWithAccountDetailsAPI({required context}) async {
//   try {
//     var response = await CustomHttpClient.get("BankDetails", context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// fileUpload({required context, required headerMap, required files}) async {
//   print(files);
//   try {
//     var response = await CustomHttpClient.uploadFiles(
//         "api/multifileupload", files, headerMap);
//     if (response.statusCode == 200) {
//       String responseBody = await response.stream.bytesToString();

//       Map json = jsonDecode(responseBody);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["errmsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// addNomineeAPI(
//     {required context, required deleteIds, required inputJsonData}) async {
//   try {
//     var response = await CustomHttpClient.addNomineePost(
//         context, "postNomFile", deleteIds, inputJsonData);
//     if (response.statusCode == 200) {
//       String responseBody = await response.stream.bytesToString();

//       Map json = jsonDecode(responseBody);
//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(context, json["errMsg"], Colors.red);
//       }
//     }
//   } catch (e) {
//     print(e);
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// fetchFileIdAPI({required context}) async {
//   try {
//     var response = await CustomHttpClient.get("api/fetchIdName", context);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         // showSnackbar(
//         //     context, json["errmsg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// Future<Uint8List> fetchFile({required context, required String id}) async {
//   try {
//     var response = await CustomHttpClient.get("api/pdffile?id=$id", context);
//     if (response.statusCode == 200) {
//       var a = response.bodyBytes;
//       print(response.bodyBytes);
//       return a;
//     } else {
//       throw Exception("Some thing went wrong");
//     }
//   } catch (e) {
//     throw Exception(exceptionShowSnackBarContent(e.toString()));
//   }
// }

// generatePdf({required context}) async {
//   try {
//     var response = await CustomHttpClient.post(
//         "GeneratePdf", "", context, "http://192.168.2.132:28094/api/");
//     print(response.body);
//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// initiateEsign({required context}) async {
//   try {
//     var response = await CustomHttpClient.get(
//       "/sign/initEsignPro", context,
//       //  mainUrl = "https://192.168.2.5:28094/"
//     );
//     print(response.body.runtimeType);
//     if (response.statusCode == 200) {
//       return response.body;
//       // Map json = jsonDecode(response.body);

//       // if (json["status"] == "S") {
//       //   return json;
//       // } else {
//       //   showSnackbar(
//       //       context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       // }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// checkEsignCompletedInAPI({required context}) async {
//   // try {
//   var response = await CustomHttpClient.put(
//     "sign/CheckEsigneCompleted", "",
//     context,
//     //  mainUrl = "http://192.168.2.132:28094/api/"
//   );
//   print("check");
//   print(response.body);
//   if (response.statusCode == 200 && response.body.toString().isNotEmpty) {
//     Map json = jsonDecode(response.body);

//     if (json["status"] == "S") {
//       return json;
//     }
//     // else {
//     //   showSnackbar(
//     //       context, json["msg"] ?? "Some thing went wrong", Colors.red);
//     // }
//   }
//   // } catch (e) {
//   //   print("error $e");
//   //   showSnackbar(
//   //       context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   // }
// }
// // formSubmission

// formSubmissionAPI({required context}) async {
//   try {
//     var response = await CustomHttpClient.post(
//       "formSubmission", "", context,
//       // mainUrl = "http://192.168.2.132:28094/api/"
//     );
//     print("formsubmission");

//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// getDigiInfoAPI({required context, required String digi_id}) async {
//   try {
//     var response = await CustomHttpClient.post(
//       "digiinfo",
//       "",
//       context,
//       {"digi_id": digi_id},
//       // mainUrl = "http://192.168.2.132:28095/api/",
//     );
//     print("response");
//     print(response.body);

//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     print("$digi_id $e");
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// getIPVDetailsAPI({required context}) async {
//   try {
//     var response = await CustomHttpClient.get("api/ipv/status", context);

//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// getUserDetailsInAPI({required context}) async {
//   try {
//     var response = await CustomHttpClient.post("api/digiid", "", context);

//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

// digiIdPostInAPI({required context, required json}) async {
//   try {
//     print(json);
//     var response = await CustomHttpClient.post("api/digiidfile", json, context);
//     print(response.body);

//     if (response.statusCode == 200) {
//       Map json = jsonDecode(response.body);

//       print(json);
//       if (json["status"] == "S") {
//         return json;
//       } else {
//         showSnackbar(
//             context, json["msg"] ?? "Some thing went wrong", Colors.red);
//       }
//     }
//   } catch (e) {
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';

import '../Cookies/HttpClient.dart';
import '../Cookies/cookies.dart';
import '../Custom%20Widgets/custom_snackBar.dart';
import '../Model/card_details_model.dart';
import '../Model/get_bank_detail_ifsc_model.dart';
import '../Model/get_bank_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/get_pers_info_model.dart';
import "../Route/route.dart" as route;

exceptionShowSnackBarContent(content) {
  print(content);
  print("exception type ${content is SocketException}");
  content = content.toString();
  if (content.contains("Network is unreachable")) {
    return "Network is unreachable";
  } else if (content.contains("Connection refused")) {
    return "Network Error";
  } else {
    return content;
  }
}

logout(context) async {
  try {
    var response = await CustomHttpClient.get("clearCookie", context);
  } catch (e) {}
  SharedPreferences sref = await SharedPreferences.getInstance();
  await sref.remove("cookies");
  await sref.remove("cookieTime");
  Navigator.pushNamedAndRemoveUntil(context, route.signup, (route) => false);
}

otpCallAPI({required json, required context}) async {
  try {
    var response = await CustomHttpClient.putWithOutCookie("sendOtp", json);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["msg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

validateOTPAPI({required json, required context}) async {
  try {
    var response =
        await CustomHttpClient.putWithOutCookie("OtpValidation", json);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["msg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getDropDownValues({required context, required code}) async {
  try {
    //  postWithOutCookie("dropDowndata", json)
    var response =
        await CustomHttpClient.getWithOutCookie("dropDowndata", {"code": code});
    print("res");
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        print("aaaa");
        showSnackbar(context, json["msg"], Colors.red);
      }
    }
  } catch (e) {
    print("objectaaa");
    print(e.toString());
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

loginAPI({required context, required json}) async {
  try {
    var response = await CustomHttpClient.logInPut("addUser", json);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["msg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

fetchCardDetailApi(BuildContext context) async {
  try {
    var response = await CustomHttpClient.get("infoCard", context);
    print(response.body);
    if (response.statusCode == 200) {
      CardDetailsModel cardDetailsModel =
          cardDetailsModelFromJson(response.body);
      if (cardDetailsModel.status == "S") {
        return cardDetailsModel;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, cardDetailsModel.errMsg, Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

fetchBankDetailApi(BuildContext context) async {
  try {
    var response = await CustomHttpClient.get("BankDetails", context);
    print(response.body);
    if (response.statusCode == 200) {
      BankDetailsModel bankDetailsModel =
          bankDetailsModelFromJson(response.body);
      if (bankDetailsModel.status == "S") {
        return bankDetailsModel;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, bankDetailsModel.errMsg, Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

// fetchPersonalDetailFromApi(BuildContext context) async {
//   try {
//     var response = await get("PersonalDetails", context);
//     print(response.body);
//     if (response.statusCode == 200) {
//       PersonalDetailModel personalDetailModel =
//           personalDetailModalFromJson(response.body);

//       if (personalDetailModel.status == "S") {
//         return personalDetailModel;
//       } else {
//         if (!context.mounted) return;
//         showSnackbar(context, personalDetailModel.errMsg, Colors.red);
//       }
//     }
//   } catch (e) {
//     if (!context.mounted) return;
//     showSnackbar(
//         context, exceptionShowSnackBarContent(e.toString()), Colors.red);
//   }
//   return null;
// }

postManualEntryDetail({
  required BuildContext context,
  required json,

  // required List<dynamic> file
}) async {
  try {
    var response = await CustomHttpClient.post('manual_entry', json, context);
    print(response.body);

    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);

      if (res["status"] == "S") {
        return res;
      } else {
        showSnackbar(context, res["msg"], Colors.red);
      }
    }
  } catch (e) {
    return exceptionShowSnackBarContent(e.toString());
  }

  return null;
}

// addPersInfo({
//   required BuildContext context,
//   required String maritalStatus,
//   required String gender,
//   required String emailOwner,
//   required String phoneOwner,
//   required String fatherName,
//   required String motherName,
//   required String annualIncome,
//   required String tradingExperience,
//   required String occupation,
//   required String politicalExpo,
//   required String education,
//   required String nomineeOpted,
// }) async {
//   try {
//     var response = await put(
//         "InsertDetails",
//         // PersInfoModel(
//         //     maritalStatus: maritalStatus,
//         //     gender: gender,
//         //     emailOwner: emailOwner,
//         //     phoneOwner: phoneOwner,
//         //     fatherName: fatherName,
//         //     motherName: motherName,
//         //     annualIncome: annualIncome,
//         //     tradingExperience: tradingExperience,
//         //     occupation: occupation,
//         //     politicalExpo: politicalExpo,
//         //     education: education,
//         //     nomineeOpted: nomineeOpted),
//         {
//           "maritalStatus": maritalStatus,
//           "gender": gender,
//           "emailOwner": emailOwner,
//           "phoneOwner": phoneOwner,
//           "fatherName": fatherName,
//           "motherName": motherName,
//           "annualIncome": annualIncome,
//           "tradingExperience": tradingExperience,
//           "occupation": occupation,
//           "politicalExpo": politicalExpo,
//           "education": education,
//           "nomineeOpted": nomineeOpted
//         },
//         context);
//     print("response.body ${response.body}");

//     if (response.statusCode == 200) {
//       Map res = jsonDecode(response.body);
//       if (res["status"] == "S") {
//         return "success";
//       } else {
//         return res["msg"];
//       }
//     }
//   } catch (e) {
//     print("EXCEPTION IN PUT: $e");
//     return exceptionShowSnackBarContent(e.toString());
//   }
//   return null;
// }

fetchPersonalDetailFromApi(BuildContext context) async {
  try {
    var response = await CustomHttpClient.get("getPersonalDetails", context);

    if (response.statusCode == 200) {
      print("fetchpersonal details");
      print(response.body);
      GetPersonalDetailsModel personalDetailModel =
          getPersonalDetailsModelFromJson(response.body);

      if (personalDetailModel.status == "S") {
        return personalDetailModel;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, personalDetailModel.errMsg, Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

addPersInfo(
    {required BuildContext context,
    required String maritalStatus,
    required String gender,
    required String emailOwner,
    required String phoneOwner,
    required String fatherName,
    required String fatherTitle,
    required String motherName,
    required String motherTitle,
    required String annualIncome,
    required String tradingExperience,
    required String occupation,
    required String politicalExpo,
    required String education,
    required String nomineeOpted,
    required String occOthers,
    required String emailOwnerName,
    required String phoneOwnerName,
    required String eduOthers}) async {
  try {
    var response = await CustomHttpClient.put(
        "addPersonalDetails",
        {
          "maritalstatus": maritalStatus,
          "gender": gender,
          "emailowner": emailOwner,
          "phoneowner": phoneOwner,
          "fathertitle": fatherTitle,
          "fathername": fatherName,
          "mothertitle": motherTitle,
          "mothername": motherName,
          "annualincome": annualIncome,
          "tradingexperience": tradingExperience,
          "occupation": occupation,
          "politicalexpo": politicalExpo,
          "education": education,
          "nomineeopted": nomineeOpted,
          "occupationothers": occOthers,
          "emailownername": emailOwnerName,
          "phoneOwnerName": phoneOwnerName,
          "educationothers": eduOthers
        },
        context);
    print("response.body ${response}");

    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      if (res["status"] == "S") {
        return res;
      } else {
        showSnackbar(context, res["errMsg"], Colors.red);
      }
    }
  } catch (e) {
    print("EXCEPTION IN PUT: $e");
    return exceptionShowSnackBarContent(e.toString());
  }
  return null;
}

postPanNo({
  required context,
  required String pannumber,
  required String pandob,
}) async {
  try {
    var response = await CustomHttpClient.post(
        "getpanstatus",
        {
          "panno": pannumber,
          "pandob": pandob,
        },
        context);
    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      if (res["status"] == "S") {
        return res;
      } else {
        showSnackbar(context, res["msg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

getAddressStatusAPI({required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.get("addressStatus", context);
    print("get address ${response.body}");
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, json['msg'], Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

getAddressAPI({required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.get("getAddress", context);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, json['errmsg'], Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

getPanAddressAPI({required BuildContext context}) async {
  try {
    print("jra");
    var response = await CustomHttpClient.get("getPanAddress", context);
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        return "";
      }
    }
  } catch (e) {
    print("oo");
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

insertKycInfoAPI({required json, required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.post("kycDetails", json, context);
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, json['msg'], Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

insertDigiInfoAPI({required json, required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.post("addDlDetails", json, context);
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, json['msg'], Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

getDigiLockerUrlAPI({required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.get(
        "constructDl_Url", context, {"appname": 'mobile'}
        //  "http://192.168.2.132:28095/api/"

        );
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, json['errmsg'], Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

getBankDetailsAPI({required BuildContext context, required ifscCode}) async {
  try {
    var response = await CustomHttpClient.put(
        "IfscDetails", {"ifsccode": ifscCode}, context);
    print(response.body);
    if (response.statusCode == 200) {
      FetchBankDetailByIfsc fetchBankDetailByIfsc =
          fetchBankDetailByIfscFromJson(response.body);
      if (fetchBankDetailByIfsc.status == "S") {
        return fetchBankDetailByIfsc;
      } else {
        if (!context.mounted) return;
        showSnackbar(context, fetchBankDetailByIfsc.errMsg, Colors.red);
      }
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
  return null;
}

insertBankDetailsAPI({required context, required json}) async {
  try {
    var response = await CustomHttpClient.put("addBankDetail", json, context);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        print(json["errMsg"]);
        showSnackbar(context, json["errMsg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getBankWithAccountDetailsAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get("getBankDetails", context);

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["errMsg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

proofUploadAPI({required context, required headerMap, required files}) async {
  try {
    var response =
        await CustomHttpClient.uploadProof("proofUploads", files, headerMap);
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      Map json = jsonDecode(responseBody);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["errmsg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

fileUploadAPI({required context, required headerMap, required files}) async {
  try {
    var response =
        await CustomHttpClient.uploadFiles("FileUploads", files, headerMap);
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      Map json = jsonDecode(responseBody);
      if (json["status"] == "S") {
        print("json $json");
        return json;
      } else {
        showSnackbar(context, json["errmsg"], Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getNomineeAPI({required context}) async {
  try {
    var response = await CustomHttpClient.post("getNomineeData", "", context);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["errMsg"], Colors.red);
      }
    }
  } catch (e) {
    print(e);
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

addNomineeAPI(
    {required context, required deleteIds, required inputJsonData}) async {
  try {
    var response = await CustomHttpClient.addNomineePost(
        context, "addNomineeData", deleteIds, inputJsonData);
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("gagga $responseBody");
      Map json = jsonDecode(responseBody);
      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(context, json["errmsg"], Colors.red);
      }
    }
  } catch (e) {
    print(e);
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

fetchFileIdAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get("getProofDetails", context);
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        // showSnackbar(
        //     context, json["errmsg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

fetchFile({required context, required String id, bool list = false}) async {
  try {
    var response = await CustomHttpClient.get("pdffile?id=$id", context);
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      if (!list) {
        return bytes;
      } else {
        return [response.headers["filename"], bytes];
        // return ["filename", bytes];
      }
    } else {
      throw Exception("Some thing went wrong");
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

Future<Uint8List> fetchFileType({required context, required String id}) async {
  try {
    var response = await CustomHttpClient.get("pdffile?id=$id", context);
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;

      return bytes;
    } else {
      throw Exception("Some thing went wrong");
    }
  } catch (e) {
    throw Exception(exceptionShowSnackBarContent(e.toString()));
  }
}

generatePdf({required context}) async {
  try {
    var response = await CustomHttpClient.post(
      "GeneratePdf", "", context,
      // "http://192.168.2.132:28094/api/"
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

initiateEsign({required context}) async {
  try {
    var response = await CustomHttpClient.get(
      "", context, {},
      // "https://uatekyc101.flattrade.in:28094/sign/initEsignPro"
      //  mainUrl = "https://192.168.2.5:28094/"
    );
    return response;
    // if (response.statusCode == 200) {
    //   return response.body;
    //   // Map json = jsonDecode(response.body);

    //   // if (json["status"] == "S") {
    //   //   return json;
    //   // } else {
    //   //   showSnackbar(
    //   //       context, json["msg"] ?? "Some thing went wrong", Colors.red);
    //   // }
    // }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getDishClosureData({required context}) async {
  try {
    var response = await CustomHttpClient.get(
      "getriskdisclosure",
      context,
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

riskdisclosureinsertInAPI(
    {required BuildContext context, required json}) async {
  try {
    var response = await CustomHttpClient.post(
      "riskdisclosureinsert", json, context,
      // "http://192.168.2.132:28094/api/"
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

checkEsignCompletedInAPI({required context}) async {
  // try {
  var response = await CustomHttpClient.get(
    "sign/CheckEsigneCompleted", "",
    context,
    //  mainUrl = "http://192.168.2.132:28094/api/"
  );

  print(response);
  if (response.toString().isNotEmpty) {
    Map json = jsonDecode(response.body);

    if (json["status"] == "S") {
      return json;
    }
    // else {
    //   showSnackbar(
    //       context, json["msg"] ?? "Some thing went wrong", Colors.red);
    // }
  }
  // } catch (e) {
  //   print("error $e");
  //   showSnackbar(
  //       context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  // }
}
// formSubmission

formSubmissionAPI({required context}) async {
  try {
    var response = await CustomHttpClient.post(
      "formSubmission", "", context,
      // mainUrl = "http://192.168.2.132:28094/api/"
    );
    print("formsubmission");

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getDigiInfoAPI({required context, required String digiId, required url}) async {
  try {
    var response = await CustomHttpClient.post(
      "getDlInfo",
      {"digi_id": digiId, "url": url},
      context,

      // mainUrl = "http://192.168.2.132:28095/api/",
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    print("$digiId $e");
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getIPVDetailsAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get("getIpvDetails", context);

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getUserDetailsForIPVInAPI({required context}) async {
  try {
    var response = await CustomHttpClient.post("ipvRequest", "", context);

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

saveIPVDetailsInAPI({required context, required json}) async {
  try {
    print(json);
    var response = await CustomHttpClient.post("getDigiDocs", json, context);
    print(response.body);

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      print(json);
      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getUserDetailsForEsignInAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get(
      "esignrequ", context, {},
      //  "http://192.168.2.156:28094/api/esignrequ"
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

saveEsignInAPI({required context, required digid}) async {
  try {
    var response = await CustomHttpClient.get(
      "saveesignfile", context,
      {"digid": digid},
      // "http://192.168.2.156:28094/api/saveesignfile"
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      if (json["status"] == "S") {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getServeBrokerDetailsApi(BuildContext context) async {
  try {
    var response = await CustomHttpClient.get('GetDematandService', context);
    print(response.body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
// print(json);
      if (json['status'] == 'S') {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

insertDemantserveApi(BuildContext context, Map demantServe) async {
  try {
    var response =
        await CustomHttpClient.post("DematServeInsert", demantServe, context);
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getReviewDetails({required BuildContext context}) async {
  try {
    var response = await CustomHttpClient.get("getReviewDetails", context);
    var json = jsonDecode(response.body);
    print(json);
    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    print(e.toString());
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getPincode({required context, required pincode}) async {
  try {
    var response =
        await CustomHttpClient.get("pincode", context, {"pincode": pincode});
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      } else {
        showSnackbar(
            context, json["msg"] ?? "Some thing went wrong", Colors.red);
      }
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getClientAddressInAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get("asClientAddress", context);
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      }
    } else {
      showSnackbar(context, json["msg"] ?? "Some thing went wrong", Colors.red);
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getRouteInfoInAPI({required context}) async {
  try {
    var response = await CustomHttpClient.get("routerinfo", context);
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      }
    } else {
      showSnackbar(context, json["msg"] ?? "Some thing went wrong", Colors.red);
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}

getRouteNameInAPI({required context, required data}) async {
  try {
    var response = await CustomHttpClient.post("routerflow", data, context);
    print(data);
    print("route ${response.body}");
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (json['status'] == 'S') {
        return json;
      }
    } else {
      showSnackbar(context, json["msg"] ?? "Some thing went wrong", Colors.red);
    }
  } catch (e) {
    showSnackbar(
        context, exceptionShowSnackBarContent(e.toString()), Colors.red);
  }
}
