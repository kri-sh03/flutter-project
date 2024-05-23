import 'dart:io';
import 'dart:typed_data';

import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Cookies/cookies.dart';
import 'package:ekyc/Custom%20Widgets/StepWidget.dart';
import 'package:ekyc/Custom%20Widgets/custom_button.dart';
import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:ekyc/Custom%20Widgets/video_player.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kyc_workflow/digio_config.dart';
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/gateway_event.dart';
import 'package:kyc_workflow/kyc_workflow.dart';
import '../Route/route.dart' as route;

class IPV extends StatefulWidget {
  const IPV({super.key});

  @override
  State<IPV> createState() => _IPVState();
}

Map? ipvDetails;
List? image;
List? video;
String? kidId;
String? gwtId;
String? email;

class _IPVState extends State<IPV> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIPVDetails();
      // getUserDetails();
    });
  }

  getUserDetails() async {
    var response = await getUserDetailsForIPVInAPI(context: context);
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
    digioConfig.logo = "https://your_logo_url";
    digioConfig.environment = Environment.SANDBOX;

    final _kycWorkflowPlugin = KycWorkflow(digioConfig);
    _kycWorkflowPlugin.setGatewayEventListener((GatewayEvent? gatewayEvent) {
      print("gateway event : " + gatewayEvent.toString());
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
    print('workflowResult : ' + workflowResult.toString());
    print(workflowResult.code!.isNegative);

    if (!workflowResult.code!.isNegative) {
      loadingAlertBox(context);
      var response = saveIPVDetailsInAPI(context: context, json: {
        "digio_doc_id": workflowResult.documentId,
        "message": workflowResult.message,
        "txn_id": workflowResult.code.toString()
      });
      if (mounted) {
        Navigator.pop(context);
      }
      if (response != null) {
        getIPVDetails();
      }
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

  getIPVDetails() async {
    loadingAlertBox(context);
    await Future.delayed(Duration(seconds: 2));
    try {
      var response = await getIPVDetailsAPI(context: context);

      if (response != null) {
        ipvDetails = response;

        image =
            response["imgid"] != null && response["imgid"].toString().isNotEmpty
                ? await fetchFile(
                    context: context, id: response["imgid"], list: true)
                : null;

        video = response["videoid"] != null &&
                response["videoid"].toString().isNotEmpty
            ? await fetchFile(
                context: context, id: response["videoid"], list: true)
            : null;
      }
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
        children: [
          Expanded(
              child: ListView(
            children: [
              image == null || video == null
                  ? Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(
                            width: 1.0,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(0.4)),
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
                                Text("Tap to take and upload a Selfie & Video",
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
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, route.previewImage,
                                        arguments: {
                                          "title": "ipvImage",
                                          "fileName": image![0],
                                          "data": image![1]
                                        }),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          // shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: MemoryImage(image![1]))),
                                      // child: Image.file(File(
                                      //   imagePath,
                                      // ))
                                    ),
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
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text("Tap to take and upload a selfie ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
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
                                    child: VideoPlayerInReview(
                                      data: video![1],
                                      fileName: video![0],
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
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 1))),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text("Tap to take and upload a selfie ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
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
                        )
                      ],
                    ),
              if (image != null && video != null) ...[
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
              ]
            ],
          )),
          const SizedBox(height: 10.0),
          image == null || video == null
              ? CustomButton(
                  childText: "Capture",
                  onPressed: () {
                    getUserDetails();
                  })
              : CustomButton(onPressed: () => getNextRoute(context)),
          const SizedBox(height: 20.0),
        ]);
  }
}
