import 'package:ekyc/Custom%20Widgets/alertbox.dart';

import '../API%20call/api_call.dart';
import '../Custom%20Widgets/StepWidget.dart';
import '../Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Custom Widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../Custom Widgets/custom_radio_button.dart';
import '../Route/route.dart' as route;

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  // FormValidateNodifier buttonEnableNodifier =
  //     FormValidateNodifier({"addressType": null});
  // RadioButtonNodifier radioButtonNodifier = RadioButtonNodifier();
  String? addressType = "digiLocker";
  String? name = "";
  String? perAaddress;
  Map? address;
  String? proof = "";
  bool getKRADataBase = false;

  getAddressStatus() async {
    loadingAlertBox(context);
    var response = await getAddressStatusAPI(context: context);
    if (response != null) {
      if (response["addrstatus"] == "U" || response["addrstatus"] == "I") {
        getAddress();
      } else if (response["addrstatus"] == "") {
        getKraPanSoap();
      }
      return;
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  getAddress() async {
    var response = await getAddressAPI(context: context);
    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      print(response);
      if (response["soa"].toString().toLowerCase().contains("manual")) {
        Navigator.pushReplacementNamed(context, route.addressManualEntry,
            arguments: response);
      } else if (response["soa"]
          .toString()
          .toLowerCase()
          .contains("digilocker")) {
        Navigator.pushReplacementNamed(context, route.digiLocker,
            arguments: {"address": response});
      } else {
        address = response;

        perAaddress =
            "${response["peradrs1"] + ", " + response["peradrs2"] + ", " + response["peradrs3"] + ", " + response["percity"] + ", " + response["perpincode"] + ", " + response["perstate"] + ", " + response["percountry"]}";
        proof = response["peradrsproofname"];
        addressType = "kyc";
      }
    }

    setState(() {});
  }

  getKraPanSoap() async {
    var response = await getPanAddressAPI(context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (response is Map) {
      address = response;
      perAaddress =
          "${response["peradrs1"] + ", " + response["peradrs2"] + ", " + response["peradrs3"] + ", " + response["percity"] + ", " + response["perpincode"] + ", " + response["perstate"] + ", " + response["percountry"]}";
      proof = response["peradrsproofname"];
      addressType = "kyc";
      getKRADataBase = true;
    } else if (response != null) {}

    if (mounted) {
      setState(() {});
    }
  }

  postKycInfo() async {
    loadingAlertBox(context);
    address!.remove("status");
    var response = await insertKycInfoAPI(json: address, context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      getNextRoute(context);
    }
  }

  getNextRoute(context) async {
    loadingAlertBox(context);
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.address],
      "routeraction": "Next"
    });
    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

  getDigiLockerUrl() async {
    // DTCPB2501R
    loadingAlertBox(context);
    var response = await getDigiLockerUrlAPI(context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      // https: //digilocker.flattrade.in/rd/digilocker
      // var url = response["redirecturl"];
      // // print(response["redirecturl"]);

      // // );
      // // var url = Uri.parse("ekyc:");
      // // print(url1.toString());

      // // print("url = $url");

      // if (await canLaunchUrlString(url)) {
      //   launchUrlString(
      //     url,
      //   );
      // }
      // await Future.delayed(Duration(seconds: 3));
      // print("aaaaa");
      // launchUrlString("ekyc://bankScreen");
      // await closeInAppWebView();
      // print(response);
      // print(response["url"]);
      Navigator.pushNamed(context, route.esignHtml,
          arguments: {"url": response["redirecturl"]});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getAddressStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StepWidget(
        endPoint: route.address,
        step: 1,
        title: "PAN & Address",
        subTitle: "Address verification using Aadhaar  ",
        children: [
          Column(
            children: [
              Visibility(
                  visible: name != null && perAaddress != null,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1.5,
                                  color: addressType == "kyc"
                                      ? Color.fromRGBO(50, 186, 124, 1)
                                      : const Color.fromRGBO(
                                          217, 217, 217, 1))),
                          child: Column(children: [
                            Row(
                              children: [
                                SizedBox(width: 18.0),
                                Expanded(
                                  child: Text(
                                    "We Found Your KYC",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                CustomRadioButton(
                                  color: addressType == "kyc"
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                            Visibility(
                                visible: addressType == "kyc",
                                child: Column(
                                  children: [
                                    Text(
                                      name!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(111, 105, 105, 1)),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text.rich(
                                        textAlign: TextAlign.center,
                                        TextSpan(children: <InlineSpan>[
                                          TextSpan(text: perAaddress ?? ""),
                                          WidgetSpan(
                                              child: SizedBox(
                                            width: 10.0,
                                          )),
                                          WidgetSpan(
                                              child: GestureDetector(
                                            child: SvgPicture.asset(
                                              "assets/images/VectorEdit.svg",
                                              color: Colors.blue,
                                            ),
                                            onTap: () => openAlertBox(
                                                context: context,
                                                content:
                                                    "Would you like to continue the manual entry process",
                                                onpressed: () =>
                                                    Navigator.pushNamed(
                                                        context,
                                                        route
                                                            .addressManualEntry,
                                                        arguments: address!
                                                          ..remove(
                                                              "peradrsproofcode"))),
                                          ))
                                        ])),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      "Proof of Address : $proof",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(68, 67, 67, 1)),
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ))
                          ]),
                        ),
                        onTap: () => setState(() {
                          addressType = "kyc";
                        }),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  )),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          width: 1.5,
                          color: addressType == "digiLocker"
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(217, 217, 217, 1))),
                  child: Visibility(
                    visible: addressType == "digiLocker",
                    replacement: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/digilocker.png",
                            width: 45,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "DIGILOCKER",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        CustomRadioButton(
                          color: addressType == "digiLocker"
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(width: 18.0),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/digilocker.png",
                                width: 50,
                              ),
                            ),
                          ),
                          CustomRadioButton(
                            color: addressType == "digiLocker"
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "AADHAAR KYC DOCUMENTS (DIGILOCKER)",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Digilocker automatically verifies your documents needed for account opening with FLATTRADE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(111, 105, 105, 1)),
                      ),
                      const SizedBox(height: 10.0),
                    ]),
                  ),
                ),
                onTap: () => setState(() {
                  addressType = "digiLocker";
                }),
              ),
              const SizedBox(height: 30.0),
              GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60.0,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            width: 1.5,
                            color: addressType == "manual"
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromRGBO(217, 217, 217, 1))),
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Text(
                              "Manual Entry",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              CustomRadioButton(
                                color: addressType == "manual"
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Fill the Form manually yourself",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(111, 105, 105, 1)),
                      ),
                    ]),
                  ),
                  onTap: () => setState(() {
                        addressType = "manual";
                      }))
            ],
          ),
          const Expanded(flex: 4, child: SizedBox()),
          CustomButton(onPressed: () async {
            if (addressType == "manual") {
              Navigator.pushNamed(context, route.addressManualEntry);
            } else if (addressType == "kyc") {
              getKRADataBase ? postKycInfo() : getNextRoute(context);
            } else {
              getDigiLockerUrl();
            }
          }),
          // Expanded(
          //   child: InAppWebView(
          //     initialUrlRequest: URLRequest(
          //       url: WebUri("https://flutter.dev"),
          //     ),
          //   ),
          // )
          const Expanded(child: SizedBox()),
        ]);
  }
}
