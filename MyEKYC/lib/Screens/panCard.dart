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

import '../Nodifier/nodifierCLass.dart';
import '../Route/route.dart' as route;

class PanCard extends StatefulWidget {
  const PanCard({super.key});

  @override
  State<PanCard> createState() => _PanCardState();
}

class _PanCardState extends State<PanCard> {
  TextEditingController panNumberController = TextEditingController();
  FormValidateNodifier formValidateNodifier =
      FormValidateNodifier({"PAN Number": false, "Date of Birth": false});
  DateChange dateChange = DateChange();
  Map? address;
  bool buttonIsLoading = false;
  var _formKey = GlobalKey<FormState>();
  bool formIsValid = false;
  bool? panValidate;

  @override
  void initState() {
    super.initState();
  }

  checkPanDetails() async {
    loadingAlertBox(context);
    buttonIsLoading = true;
    if (mounted) {
      setState(() {});
    }
    String date = dateChange.value.toString().substring(8, 10) +
        "/" +
        dateChange.value.toString().substring(5, 7) +
        "/" +
        dateChange.value.toString().substring(0, 4);
    var response = await postPanNo(
      context: context,
      pannumber: panNumberController.text.toUpperCase(),
      pandob: date,
    );
    Navigator.pop(context);
    if (response != null) {
      shoeBottomSheet(response["lastname"] ?? " ");
      panValidate = true;
    }
    buttonIsLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  getNextRoute(context) async {
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
    if (panNumberController.text.isNotEmpty && dateChange.value != null) {
      bool formValid = _formKey.currentState!.validate();
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
  }

  @override
  Widget build(BuildContext context) {
    return StepWidget(
        endPoint: route.panCard,
        step: 1,
        title: "PAN & Address",
        subTitle: "PAN card is necessary to open Demat account in India",
        children: [
          Expanded(
              child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text("PAN Number*"),
                const SizedBox(height: 5.0),
                CustomFormField(
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
                  validator: validatePanCard,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/Vector.svg", width: 15.0),
                    const SizedBox(width: 3.0),
                    const Text(
                      "Your information is safe with us",
                      style: TextStyle(color: Color.fromRGBO(0, 232, 218, 1)),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Date of Birth*"),
                const SizedBox(height: 5.0),
                CustomDateFormField(
                    formValidateNodifier: formValidateNodifier,
                    date: dateChange,
                    onChange: checkFormValidOrNot),
                const SizedBox(height: 40.0),
                CustomButton(
                    // valueListenable: formValidateNodifier,
                    childText: "Verify",
                    onPressed: buttonIsLoading || !formIsValid
                        ? null
                        : () async {
                            checkPanDetails();
                            // shoeBottomSheet("Diwan Anifa M");
                          }),
              ],
            ),
          ))
        ]);
  }

  shoeBottomSheet(String name) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 60.0,
                height: name.isEmpty ? 135.0 : null,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(237, 249, 254, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: name.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Text(
                                "Hi, $name",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(0, 192, 100, 1),
                                    fontWeight: FontWeight.w600),
                              ),
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
                                  "Using User Details we Securely accessed your details from the Income Tax Department"),
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
              CustomButton(onPressed: () => getNextRoute(context))
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
}
