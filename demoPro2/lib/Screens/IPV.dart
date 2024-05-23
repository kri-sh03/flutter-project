import 'dart:convert';
import 'dart:io';

import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/StepWidget.dart';
import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:ekyc/Custom%20Widgets/video_player.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kyc_workflow/digio_config.dart';
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/gateway_event.dart';
import 'package:kyc_workflow/kyc_workflow.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Custom Widgets/alertbox.dart';
import '../Custom Widgets/loadImage.dart';
import '../Route/route.dart' as route;

class IPV extends StatefulWidget {
  const IPV({super.key});

  @override
  State<IPV> createState() => _IPVState();
}

class _IPVState extends State<IPV> {
  Map? ipvDetails;
  String? image;
  String? otp;
  String? video;
  String? kidId;
  String? gwtId;
  String? email;
  ScrollController scrollController = ScrollController();
  var key;

  @override
  void initState() {
    key = UniqueKey();
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getPermission();
      getIPVDetails();
      // getUserDetails();
    });
  }

  getUserDetails() async {
    if (!Platform.isIOS) {
      if (await getPermission() != true) return;
    }
    loadingAlertBox(context);
    var response = await getUserDetailsForIPVInAPI(context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      print("ooo");
      print(response);
      kidId =
          //  response["access_token"]["entity_id"] != ""
          //     ? response["access_token"]["entity_id"]
          // :
          response["id"];
      gwtId = response["access_token"]["id"];
      email = response["customer_identifier"];
      if (kidId != null &&
          kidId!.isNotEmpty &&
          gwtId != null &&
          gwtId!.isNotEmpty &&
          email != null &&
          email!.isNotEmpty) {
        function();
      } else {
        showSnackbar(context, "Some thing went wrong", Colors.red);
      }
    }
  }

  function() async {
    WidgetsFlutterBinding.ensureInitialized();

    var digioConfig = DigioConfig();

    digioConfig.theme.primaryColor = "#32a83a";
    digioConfig.environment = Environment
        .SANDBOX; // SANDBOX is testing server, PRODUCTION is production server

    final _kycWorkflowPlugin = KycWorkflow(digioConfig);
    _kycWorkflowPlugin.setGatewayEventListener((GatewayEvent? gatewayEvent) {
      // print("gateway event : " + gatewayEvent.toString());
    });
    // kid KID240206133931111HCXK2U1WA79ZGA
    // git GWT2402061339312233SFZGUEDZ3U34E
    // diwananifa@gmail.com
    // var workflowResult =
    //     await _kycWorkflowPlugin.start(kidId!, email!, gwtId!, null);
    var workflowResult = await _kycWorkflowPlugin.start(
        // "KID240206152242522F45KSJNVZ6P229",
        // "diwananifa@gmail.com",
        // "GWT240206152242563XCNPFLOZPVOTY3",
        kidId!,
        email!,
        gwtId!,
        null);
    // print('workflowResult : ' + workflowResult.toString());
    // print(workflowResult.code!.isNegative);
    // print("error code ${workflowResult.errorCode}");

    if (!workflowResult.code!.isNegative) {
      loadingAlertBox(context);
      var response = await saveIPVDetailsInAPI(context: context, json: {
        "digio_doc_id": workflowResult.documentId,
        "message": workflowResult.message,
        "txn_id": workflowResult.code.toString()
      });
      print('***************************');
      print(jsonEncode({
        "digio_doc_id": workflowResult.documentId,
        "message": workflowResult.message,
        "txn_id": workflowResult.code.toString()
      }));
      print(jsonEncode(response));
      if (mounted) {
        Navigator.pop(context);
      }
      if (response != null) {
        getIPVDetails();
      }
    } else {
      showSnackbar(context, workflowResult.message ?? "Some thing went wrong",
          Colors.red);
    }
  }

  getNextRoute(context) async {
    loadingAlertBox(context);
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.ipv],
      "routeraction": "Next"
    });
    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

  Future<bool?> getPermission() async {
    List<Permission> permissions = [
      Permission.location,
      Permission.camera,
      Permission.microphone,
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();
    List<String> notPermit = [];

    permissions.forEach((element) {
      PermissionStatus? permissionStatus = statuses[element];
      String name = element.toString().split(".")[1];
      !permissionStatus!.isGranted
          ? notPermit
              .add("${name.substring(0, 1).toUpperCase()}${name.substring(1)}")
          : null;
    });
    if (!statuses.keys.every((element) => statuses[element]!.isGranted)) {
      // openPermissionAlertBox(notPermit.join(", "));
      openAlertBox(
          barrierDismissible: false,
          context: context,
          content:
              "${notPermit.join(", ")} permission required to complete IPV for account opening.",
          button1Content: "Accept permission",
          onpressedButton1: () async {
            Navigator.pop(context);
            var a = await openAppSettings();
            // print("a $a");
          },
          needButton2: false);
      return false;
    } else {
      return true;
    }
  }

  getIPVDetails() async {
    loadingAlertBox(context);

    try {
      var response = await getIPVDetailsAPI(context: context);
      if (response != null) {
        ipvDetails = response;
        image = response["imgid"];
        otp = response["code"];
        video = response["videoid"];
        key = UniqueKey();
      }
      print("image------$otp");
    } catch (e) {
      showSnackbar(
          context, exceptionShowSnackBarContent(e.toString()), Colors.red);
    }
    if (mounted) {
      Navigator.pop(context);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StepWidget(
        step: 5,
        endPoint: route.ipv,
        title: "In Person Verification",
        subTitle: "Record yourself a video saying the OTP below",
        scrollController: scrollController,
        buttonText: image == null || image!.isEmpty ? "Capture" : null,
        buttonFunc: image == null || image!.isEmpty
            ? getUserDetails
            : () => getNextRoute(context),
        children: [
          Column(
            children: [
              // ...getTitleANdSubTitleWidget("In Person Verification",
              //     "Record yourself a video saying the OTP below", context),
              image == null || image!.isEmpty
                  ? Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromRGBO(9, 101, 218, 1)
                            // Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium!
                            //     .color!
                            //     .withOpacity(0.4)
                            ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   width: 10.0,
                          // ),
                          Container(
                              height: 50.0,
                              width: 50.0,
                              alignment: Alignment.center,
                              child:
                                  SvgPicture.asset("assets/images/selfie.svg")),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Selfie & Video",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Click Capture button to take and upload a Selfie & Video",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ],
                            ),
                          ),
                          // SvgPicture.asset(
                          //   "assets/images/arrow.svg",
                          //   width: 8.0,
                          //   height: 12.0,
                          // )
                        ],
                      ))
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1.0,
                                    color:
                                        const Color.fromRGBO(9, 101, 218, 1)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // image: DecorationImage(
                                        //     fit: BoxFit.fill,
                                        //     image:
                                        //      MemoryImage(image![1])
                                        //      )
                                        ),
                                    child: LoadImage(
                                      key: key,
                                      data: image,
                                      fileTitle: "IPVImage",
                                      fileName: "",
                                    ),
                                    // child: Image.file(File(
                                    //   imagePath,
                                    // ))
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Selfie captured",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 1))),
                                        // const SizedBox(
                                        //   height: 5.0,
                                        // ),
                                        // Text("Tap to take and upload a selfie ",
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodySmall),
                                        // const SizedBox(
                                        //   height: 10.0,
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () async {},
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.start,
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: [
                                        //       SvgPicture.asset(
                                        //           "assets/images/selfie.svg"),
                                        //       const SizedBox(
                                        //         width: 10.0,
                                        //       ),
                                        //       const Text("Recapture",
                                        //           style: TextStyle(
                                        //             color: Color.fromRGBO(
                                        //                 9, 101, 218, 1),
                                        //             fontSize: 10,
                                        //             fontWeight: FontWeight.w600,
                                        //           ))
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  // SvgPicture.asset(
                                  //   "assets/images/arrow.svg",
                                  //   width: 8.0,
                                  //   height: 12.0,
                                  // )
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Visibility(
                          visible: video != null && video!.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color.fromRGBO(
                                            9, 101, 218, 1))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: VideoPlayerInReview(
                                        key: key,
                                        data: video,
                                        otp: otp ?? "",
                                      ),
                                      // child: Image.file(File(
                                      //   imagePath,
                                      // ))
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Selfie Video captured",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 1))),
                                          // const SizedBox(
                                          //   height: 5.0,
                                          // ),
                                          // Text(
                                          //     "Tap to take and upload a selfie ",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodySmall),
                                          // const SizedBox(
                                          //   height: 10.0,
                                          // ),
                                          // GestureDetector(
                                          //   onTap: () async {},
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.center,
                                          //     children: [
                                          //       SvgPicture.asset(
                                          //           "assets/images/selfie.svg"),
                                          //       const SizedBox(
                                          //         width: 10.0,
                                          //       ),
                                          //       const Text("Recapture",
                                          //           style: TextStyle(
                                          //             color: Color.fromRGBO(
                                          //                 9, 101, 218, 1),
                                          //             fontSize: 10,
                                          //             fontWeight: FontWeight.w600,
                                          //           ))
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/arrow.svg",
                                    //   width: 8.0,
                                    //   height: 12.0,
                                    // )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
              if (image != null && image!.isNotEmpty) ...[
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Row(children: [
                        SvgPicture.asset("assets/images/selfie.svg"),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text("Recapture",
                            style: TextStyle(
                              color: Color.fromRGBO(9, 101, 218, 1),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                      onTap: () => getUserDetails(),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ]);
  }
}
