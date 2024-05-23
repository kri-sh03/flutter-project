import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/custom_button.dart';
import 'package:ekyc/Custom%20Widgets/custom_form_field.dart';
import 'package:ekyc/Custom%20Widgets/date_picker_form_field.dart';
import 'package:ekyc/Custom%20Widgets/StepWidget.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:ekyc/Service/validate_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../Nodifier/nodifierCLass.dart';
import '../Route/route.dart' as route;

class PanCard extends StatefulWidget {
  const PanCard({super.key});

  @override
  State<PanCard> createState() => _PanCardState();
}

class _PanCardState extends State<PanCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FormValidateNodifier formValidateNodifier =
      FormValidateNodifier({"PAN Number": false, "Date of Birth": false});
  DateChange dob = DateChange();
  Map? address;
  bool buttonIsLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool formIsValid = false;
  bool? panValidate;
  bool verifyButtonClicked = false;
  String errorCode = "";
  String nameFlag = "";
  String oldName = " ";
  String oldPan = " ";
  DateTime oldDate = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPanDetails();
    });
  }

  getPanDetails() async {
    loadingAlertBox(context);
    var response = await getPANDetailsInAPI(context);
    if (response != null) {
      nameController.text = response["name"] ?? "";
      nameFlag = response["nameflag"] ?? "";
      setState(() {});
    }
    if (mounted) {
      Navigator.pop(context);
      setState(() {});
    }
  }

  checkPanDetails() async {
    loadingAlertBox(context);
    buttonIsLoading = true;
    if (mounted) {
      setState(() {});
    }
    String date = dob.value.toString().substring(8, 10) +
        "/" +
        dob.value.toString().substring(5, 7) +
        "/" +
        dob.value.toString().substring(0, 4);
    var response = await postPanNo(
      context: context,
      panname: nameController.text.trim(),
      pannumber: panNumberController.text.toUpperCase(),
      pandob: date,
    );
    Navigator.pop(context);
    if (response != null) {
      if (response["status"] == "S") {
        // new api response
        // if (response["status"] == "S") {
        //   shoeBottomSheet(response["lastname"] ?? " ", context);
        //   panValidate = true;
        // }else{

        // }
        // old api
        shoeBottomSheet(nameController.text.trim(), context);
        panValidate = true;
      } else if (response["status"] == "E") {
        errorCode = response["statusCode"] ?? "";
        oldName = nameController.text;
        oldPan = panNumberController.text;
        oldDate = dob.value ?? DateTime.now().add(Duration(days: 1));

        print("error $errorCode");
        errorBottomSheet(nameController.text, response["msg"], context);
      }
    }
    buttonIsLoading = false;
    if (mounted) {
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        checkFormValidOrNot("");
      });
    }
  }

  getNextRoute(context) async {
    loadingAlertBox(context);

    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.panCard],
      "routeraction": "Next"
    });
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

  checkFormValidOrNot(value) {
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (panNumberController.text.isNotEmpty && dob.value != null) {
        bool formValid = _formKey.currentState!.validate();
        print("working $formValid");
        if (formIsValid != formValid) {
          formIsValid = formValid;
          if (mounted) {
            setState(() {});
          }
        }
      } else {
        if (formIsValid) {
          formIsValid = false;
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepWidget(
        endPoint: route.panCard,
        step: 1,
        title: "PAN & Address",
        subTitle: "PAN card is necessary to open Demat account in India",
        buttonText: "Verify",
        scrollController: scrollController,
        buttonFunc:
            //  buttonIsLoading || !formIsValid
            //     ? null
            //     :
            () async {
          if (!verifyButtonClicked) {
            verifyButtonClicked = true;
            setState(() {});
          }
          if (!(_formKey.currentState!.validate() && dob.value != null)) {
            return;
          }
          checkPanDetails();
          // shoeBottomSheet("Diwan Anifa M");
        },
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ...getTitleANdSubTitleWidget(
                //     "PAN & Address",
                //     "PAN card is necessary to open Demat account in India",
                //     context),
                // const Text("Name*"),
                // const SizedBox(height: 5.0),

                ...customFormField(
                    readOnly: !(errorCode.contains("NAME") ||
                        errorCode.contains("PAN") ||
                        nameFlag == "Y"),
                    textIsGrey: !(errorCode.contains("NAME") ||
                        errorCode.contains("PAN") ||
                        nameFlag == "Y"),
                    borderIsRed: (errorCode.contains("NAME") ||
                            errorCode.contains("PAN")) &&
                        oldName == nameController.text,
                    labelText: "Name as per PAN card",
                    // hintText: "Name as per PAN card",
                    formValidateNodifier: formValidateNodifier,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
                    controller: nameController,
                    onChange: checkFormValidOrNot,
                    validator:
                        //  oldName == nameController.text &&
                        //         errorCode.contains("NAME")
                        //     ? (value) => ""
                        //     :
                        nameFlag == "Y" ||
                                errorCode.contains("NAME") ||
                                errorCode.contains("PAN")
                            ? (value) =>
                                validateName(value, "Name as per PAN card", 3)
                            : (value) => nullValidation(value),
                    noNeedErrorText: oldName == nameController.text &&
                        errorCode.contains("NAME")

                    // validateName(value, "Name as per PAN card", 3)
                    ),

                const SizedBox(height: 15.0),
                // const Text("PAN Number*"),
                // const SizedBox(height: 5.0),
                ...customFormField(
                  borderIsRed: errorCode.contains("PAN") &&
                      oldPan == panNumberController.text,
                  formValidateNodifier: formValidateNodifier,
                  controller: panNumberController,
                  labelText: "PAN Number",
                  helperText: "Exapmle:ABCDE1234A",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  onChange: checkFormValidOrNot,
                  validator:
                      //  oldPan == panNumberController.text &&
                      //         errorCode.contains("PAN")
                      //     ? (value) => ""
                      //     :
                      (value) => validatePanCard(value),
                ),

                const SizedBox(height: 20.0),
                const Text("Date of Birth as per PAN card*"),
                const SizedBox(height: 5.0),
                CustomDateFormField(
                    borderIsRed: (errorCode.contains("DOB") ||
                            errorCode.contains("PAN")) &&
                        oldDate.toString() == dob.value.toString(),
                    errorText: verifyButtonClicked && dob.value == null
                        ? "DOB is required"
                        : null,
                    formValidateNodifier: formValidateNodifier,
                    date: dob,
                    onChange: checkFormValidOrNot),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/Vector.svg", width: 15.0),
                    const SizedBox(width: 3.0),
                    const Text(
                      "Your information is safe with us!",
                      style: TextStyle(color: Color.fromRGBO(0, 232, 218, 1)),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          )
        ]);
  }

  shoeBottomSheet(String name, context1) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 40.0),
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 60.0,
                // height: name.isEmpty ? 135.0 : null,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(237, 249, 254, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: name.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              name.isNotEmpty
                                  ? Text(
                                      "Hi, $name",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromRGBO(0, 192, 100, 1),
                                          fontWeight: FontWeight.w600),
                                    )
                                  : SizedBox(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         name,
                              //         style: const TextStyle(
                              //             fontSize: 16.0,
                              //             color: Color.fromRGBO(0, 192, 100, 1),
                              //             fontWeight: FontWeight.w600),
                              //       ),
                              //     ),
                              // const SizedBox(width: 20.0),
                              // InkWell(
                              //   child: SvgPicture.asset(
                              //       "assets/images/VectorEdit.svg"),
                              //   onTap: () => Navigator.pushNamed(
                              //       context, route.addressManualEntry,
                              //       arguments: address),
                              // )
                              //   ],
                              // ),
                              const SizedBox(height: 20.0),
                              const Text(
                                  "Using your PAN details we securely fetched your details from the Income Tax Department"),
                              const SizedBox(height: 20.0),
                              RichText(
                                  text: TextSpan(children: [
                                const WidgetSpan(child: Text("Not you? ")),
                                WidgetSpan(
                                  child: InkWell(
                                    child: Text(
                                      're enter PAN',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                )
                              ]))
                            ])
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text("Record (PAN not found in KRA Database)",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromRGBO(98, 100, 103, 1),
                                      fontWeight: FontWeight.w600)),
                              // SizedBox(height: 10.0),
                              // Text("Invalid PAN")
                            ]),
                ),
              ),
              const SizedBox(height: 20.0),
              CustomButton(buttonFunc: () => getNextRoute(context1))
              //      name.isNotEmpty
              // ?
              //  Row(
              //     children: [
              //       const SizedBox(width: 10.0),
              //       Expanded(
              //         child: CustomButton(
              //             child: const Text(
              //               "Processed with Digilocker",
              //               style: TextStyle(fontWeight: FontWeight.w600),
              //               textAlign: TextAlign.center,
              //             ),
              //             onPressed: () {
              //               // Navigator.pop(context);
              //               // shoeBottomSheet("");
              //               Navigator.pop(context);
              //               Navigator.pushNamed(context, route.address);
              //             }),
              //       ),
              //       const SizedBox(width: 10.0),
              //       Expanded(
              //         child: CustomButton(
              //             child: const Text(
              //               "Continue with KYC",
              //               style: TextStyle(fontWeight: FontWeight.w600),
              //               textAlign: TextAlign.center,
              //             ),
              //             onPressed: () {
              //               // Navigator.pop(context);
              //               // shoeBottomSheet("");

              //               // !address!.containsKey("sourceofaddress")
              //               //     ? postKycInfo()
              //               //     : Navigator.pushNamed(
              //               //         context, route.bankScreen);
              //             }),
              //       ),
              //       const SizedBox(width: 10.0),
              //     ],
              //   )

              // : Row(children: [
              //     Expanded(
              //         child: CustomButton(
              //             childText: "Continue",
              //             onPressed: () {
              //               Navigator.pop(context);
              //               Navigator.pushNamed(context, route.address);
              //             })),
              //     const SizedBox(width: 20.0),
              //     Expanded(
              //         child: CustomButton(
              //             isBackgroundTrans: true,
              //             childText: "Re Enter PAN",
              //             onPressed: () {
              //               Navigator.pop(context);
              //             }))
              //   ]),
            ],
          ),
        );
      },
    );
  }

  errorBottomSheet(String name, String html, context1) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 40.0),
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 60.0,
                // height: name.isEmpty ? 135.0 : null,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(237, 249, 254, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          name.isNotEmpty
                              ? Text(
                                  "Hi, $name",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromRGBO(0, 192, 100, 1),
                                      fontWeight: FontWeight.w600),
                                )
                              : SizedBox(),
                          const SizedBox(height: 20.0),
                          HtmlWidget(html),
                          const SizedBox(height: 20.0),
                        ])),
              ),
              const SizedBox(height: 20.0),
              CustomButton(
                  buttonText: errorCode == "NAME"
                      ? "Re-enter Name"
                      : errorCode == "DOB"
                          ? "Re-enter Date of Birth"
                          : errorCode == "NAMEDOB"
                              ? "Re-enter Name & DOB"
                              : "Re-enter PAN",
                  buttonFunc: () => Navigator.pop(context))
            ],
          ),
        );
      },
    );
  }
}
