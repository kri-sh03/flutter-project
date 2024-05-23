import 'dart:io';
import 'dart:typed_data';

import '../Screens/Address.dart';
import '../Screens/esign_html.dart';
import '../Screens/preview_image.dart';
import '../Screens/manual_entry_address.dart';
import '../Screens/preview_pdf.dart';
import '../Screens/preview_video.dart';
import '../Screens/segmentselection.dart';
import '../Screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../Screens/email.dart';
import '../Screens/email_otp.dart';
import '../Screens/mobile_otp.dart';
import '../Screens/panCard.dart';
import '../Screens/signup.dart';
import '../Screens/state_selection.dart';
import 'package:flutter/material.dart';

import '../Screens/IPV.dart';
import '../Screens/congratulation.dart';
import '../Screens/bankscreen.dart';

import '../Screens/digiLocker.dart';

import '../Screens/file_upload.dart';
import '../Screens/add_nominee.dart';
import '../Screens/nominee.dart';
import '../Screens/pers_info_screen.dart';
import '../Screens/review.dart';

const splashPage = "/";
const signup = "/signup";
const mobileOTP = "/mobileOTP";
const email = "/email";
const emailOTP = "/emailOTP";
const stateSelection = "/stateSelection";
const panCard = "/pan";
const address = "/rd/digilocker";
const digiLocker = "/digiLocker";
const addressManualEntry = "/addressManualEntry";
const bankScreen = "/linkBankAccount";
const segmentSelection = "/dematServices";
const bankStatement = "/bankStatement";
const persInfo = "/profileview";
const addNominee = "/addNominee";
const nominee = "/nominee";
const fileUpload = "/fileupload";

const review = "/docPreview";
const congratulation = "/afterEsign";
const ipv = "/ipv";
const esignHtml = "/esignHtml";
const previewImage = "/previewImage";
const previewPdf = "/previewpdf";
const previewVideo = "/previewVideo";
// {"encrypteval":"d**********@g****.com##845504","insertedid":"5740","attemptcount":1,"status":"S"}

Map routeNames = {
  signup: "Main",
  panCard: "Pan",
  address: "Address",
  persInfo: "Personal",
  nominee: "Nominee",
  bankScreen: "Bank",
  ipv: "IPV",
  segmentSelection: "DematServices",
  fileUpload: "Fileupload",
  review: "DocPreview",
  congratulation: "afterEsign"
};
Route<dynamic> controller(RouteSettings settings) {
  Uri uri = Uri.parse(settings.name ?? "");
  print(uri.path);
  Widget page;
  switch (settings.name) {
    case splashPage:
      page = const SplashScreen();
      break;
    case signup:
      page = const Signup();
      break;
    case mobileOTP:
      Map arguments = settings.arguments as Map;
      page = MobileOTP(
        encryptMobileNumber: arguments["encrypteval"],
        id: arguments["insertedid"],
        name: arguments['name'],
        mobileNumber: arguments["mobileNo"],
        state: arguments["state"],
      );
      break;
    case email:
      Map arguments = settings.arguments as Map;
      page = Email(
        name: arguments['name'],
        mobileNumber: arguments["mobileNo"],
        state: arguments["state"],
      );
      break;
    case emailOTP:
      Map arguments = settings.arguments as Map;
      page = EmailOTP(
        name: arguments['name'],
        mobileNumber: arguments["mobileNo"],
        email: arguments["email"],
        encryptEmail: arguments["encrypteval"],
        id: arguments["insertedid"],
        state: arguments["state"],
      );
      break;
    case stateSelection:
      page = const StateSelection();
      break;
    case panCard:
      page = const PanCard();
      break;
    case address:
      page = const Address();
    case digiLocker:
      Map? data = settings.arguments != null ? settings.arguments as Map : {};
      page = DigiLocker(
        address: data["address"],
        url: data['url'],
      );
    case addressManualEntry:
      page = settings.arguments != null
          ? AddressManualEntry(address: settings.arguments as Map)
          : const AddressManualEntry();
    case bankScreen:
      page = const BankScreen();
    case segmentSelection:
      page = const SegmentSelection();
    // case bankStatement:
    //   page = const BankStatement();
    case persInfo:
      page = const PersInfoScreen();
    case addNominee:
      Map data = settings.arguments as Map;
      page = AddNomineeForm(
        nom: data["nominee"],
        nomineeDetails: data["nomineeDetails"],
      );
    case nominee:
      page = NomineeDashboard(
          isBack:
              settings.arguments != null ? settings.arguments is bool : null);
    case congratulation:
      page = const Congratulation();
    case review:
      page = const Review();
    case ipv:
      page = IPV();
    case fileUpload:
      page = const FileUpload();
    case esignHtml:
      Map data = settings.arguments as Map;
      page = EsignHtml(
        html: data["html"],
        url: data["url"],
      );
    case previewImage:
      Map data = settings.arguments as Map;
      page = ImagePreview(
        title: data["title"],
        data: data["data"],
        fileName: data["fileName"],
      );
    case previewPdf:
      Map data = settings.arguments as Map;
      page = PDFPreview(
        title: data["title"],
        data: data["data"],
        fileName: data["fileName"],
      );
    case previewVideo:
      page = PreviewVideo(file: settings.arguments as File);
    default:
      throw Exception("Error");
  }
  return PageTransition(child: page, type: PageTransitionType.rightToLeft);
}
