import 'dart:convert';
import 'dart:io';

import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/file_upload_bottomsheet.dart';
import 'package:ekyc/Custom%20Widgets/custom_check_box.dart';
import 'package:ekyc/Custom%20Widgets/custom_button.dart';
import 'package:ekyc/Custom%20Widgets/custom_form_field.dart';
import 'package:ekyc/Custom%20Widgets/StepWidget.dart';
import 'package:ekyc/Custom%20Widgets/custom_drop_down.dart';
import 'package:ekyc/Custom%20Widgets/scrollable_widget.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Nodifier/nodifierCLass.dart';
import '../Service/validate_func.dart';
import '../Route/route.dart' as route;
/* 
class AddressManualEntry extends StatefulWidget {
  const AddressManualEntry({super.key});

  @override
  State<AddressManualEntry> createState() => _AddressManualEntryState();
}

class _AddressManualEntryState extends State<AddressManualEntry> {
  DateChange dateChange = DateChange();

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileNoController =
      TextEditingController(text: "9876543210");
  TextEditingController mailIdController =
      TextEditingController(text: "abc@gmail.com");
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController residentialAddressLine1Controller =
      TextEditingController();
  TextEditingController residentialAddressLine2Controller =
      TextEditingController();
  TextEditingController residentialAddressLine3Controller =
      TextEditingController();
  TextEditingController residentialPinCodeController = TextEditingController();
  TextEditingController residentialCityController = TextEditingController();
  TextEditingController residentialStateController = TextEditingController();
  TextEditingController residentialCountryController = TextEditingController();
// TextfieldValueNodifier proofTypeController = TextfieldValueNodifier();
  TextEditingController proofNumberController = TextEditingController();
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController palceOfIssueController = TextEditingController();
  TextEditingController addressProofFrontPageController =
      TextEditingController();
  TextEditingController addressProofBackPageController =
      TextEditingController();

  TextEditingController prefix = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController proofType = TextEditingController();
  CheckBoxValueNodifier checkBoxValueNodifier = CheckBoxValueNodifier(true);
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    FormValidateNodifier formValidateNodifier = FormValidateNodifier({
      "Name": false,
      "Date of Birth": false,
      "Gender": false,
      // "Mobile Number": false,
      "Mail Id": false,
      "Full Address": false,
      "Address Line 2": false,
      "Address Line 3": false,
      "Pincode": false,
      // "City": false,
      // "State": false,
      // "Country": false,
      "#Full Address": false,
      "#Address Line 2": false,
      "#Address Line 3": false,
      "#Pincode": false,
      // "#City": false,
      // "#State": false,
      // "#Country": false,
      "Proof Type": false,
      "Proof Number": false,
      "Date of issue": false,
      "Place of issue": false,
      // "Address proof front Page": true,
      // "Address proof back Page": true
    });

    DateTime? proofIssueDate;

    showDatePick() async {
      DateTime today = DateTime.now();
      DateTime? pickDate = await showDatePicker(
          context: context,
          initialDate: today,
          firstDate: DateTime(1900),
          lastDate: today);
      if (pickDate != null && proofIssueDate != pickDate) {
        proofIssueDate = pickDate;
        dateOfIssueController.text = pickDate.toString().substring(0, 10);
      }
    }

    return StepWidget(
        step: 1,
        title: "PAN & Address",
        subTitle: "Address verification using Aadhaar  ",
        // resizeToAvoidBottomInset: false,
        children: [
          Expanded(
              child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Prefix"),
                            const SizedBox(height: 5.0),
                            CustomDropDown(
                                formValidateNodifier: formValidateNodifier,
                                controller: prefix,
                                values: const ["Mr", "Ms", "Mrs"]),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                              formValidateNodifier: formValidateNodifier,
                              controller: nameController,
                              labelText: "Name",
                            ),
                          )),
                    ],
                  ),

                  const SizedBox(height: 10.0),
                  const Text("Date of Birth*"),
                  const SizedBox(height: 5.0),
                  CustomDateFormField(
                      formValidateNodifier: formValidateNodifier,
                      date: dateChange,
                      onChange: () {}),
                  const SizedBox(height: 10.0),
                  const Text("Gender*"),
                  const SizedBox(height: 5.0),
                  CustomDropDown(
                      formValidateNodifier: formValidateNodifier,
                      label: "Gender",
                      buttonSizeIsSmall: true,
                      controller: gender,
                      values: const ["male", "female", "others"]),
                  const SizedBox(height: 10.0),
                  ...customFormField(
                      formValidateNodifier: formValidateNodifier,
                      readOnly: true,
                      controller: mobileNoController,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      labelText: "Mobile Number",
                      textIsGrey: true,
                      validator: mobileNumberValidation),
                  const SizedBox(height: 10.0),
                  ...customFormField(
                      formValidateNodifier: formValidateNodifier,
                      controller: mailIdController,
                      labelText: "Mail Id",
                      readOnly: true,
                      textIsGrey: true,
                      validator: emailValidation),
                  const SizedBox(height: 30.0),
                  Text(
                    "Permanent address",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20.0),
                  ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    controller: addressLine1Controller,
                    labelText: "Full Address",
                  ),
                  const SizedBox(height: 10.0),
                  CustomFormField(
                      formValidateNodifier: formValidateNodifier,
                      controller: addressLine2Controller,
                      labelText: "Address Line 2"),
                  const SizedBox(height: 10.0),
                  CustomFormField(
                      formValidateNodifier: formValidateNodifier,
                      controller: addressLine3Controller,
                      labelText: "Address Line 3"),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...customFormField(
                                  formValidateNodifier: formValidateNodifier,
                                  controller: pinCodeController,
                                  labelText: "Pincode",
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: validatePinCode,
                                  onChange: (value) {
                                    if (value.length == 6) {
                                      cityController.text = "Chennai";
                                      stateController.text = "Tamilnadu";
                                      countryController.text = "India";
                                    } else {
                                      cityController.text = "";
                                      stateController.text = "";
                                      countryController.text = "";
                                    }
                                  }),
                            ],
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                              formValidateNodifier: formValidateNodifier,
                              readOnly: true,
                              controller: cityController,
                              labelText: "City",
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                readOnly: true,
                                controller: stateController,
                                labelText: "State"),
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                readOnly: true,
                                controller: countryController,
                                labelText: "Country"),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Residential Address",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20.0),
                  CustomCheckBox(
                      checkBoxValueNodifier: checkBoxValueNodifier,
                      childText:
                          "Residential Address same as permanent address"),

                  const SizedBox(height: 20.0),
                  ValueListenableBuilder(
                      valueListenable: checkBoxValueNodifier,
                      builder: (context, value, child) {
                        return Visibility(
                          visible: !value,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...customFormField(
                                  formValidateNodifier: formValidateNodifier,
                                  controller: residentialAddressLine1Controller,
                                  labelText: "#Full Address",
                                ),
                                const SizedBox(height: 10.0),
                                CustomFormField(
                                    formValidateNodifier: formValidateNodifier,
                                    controller:
                                        residentialAddressLine2Controller,
                                    labelText: "#Address Line 2"),
                                const SizedBox(height: 10.0),
                                CustomFormField(
                                    formValidateNodifier: formValidateNodifier,
                                    controller:
                                        residentialAddressLine3Controller,
                                    labelText: "#Address Line 3"),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...customFormField(
                                                formValidateNodifier:
                                                    formValidateNodifier,
                                                controller:
                                                    residentialPinCodeController,
                                                labelText: "#Pincode",
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: validatePinCode,
                                                onChange: (value) {
                                                  if (value.length == 6) {
                                                    residentialCityController
                                                        .text = "Chennai";
                                                    residentialStateController
                                                        .text = "Tamilnadu";
                                                    residentialCountryController
                                                        .text = "India";
                                                  } else {
                                                    residentialCityController
                                                        .text = "";
                                                    residentialStateController
                                                        .text = "";
                                                    residentialCountryController
                                                        .text = "";
                                                  }
                                                }),
                                          ],
                                        )),
                                    const Expanded(flex: 1, child: SizedBox()),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: customFormField(
                                              formValidateNodifier:
                                                  formValidateNodifier,
                                              readOnly: true,
                                              controller:
                                                  residentialCityController,
                                              labelText: "#City"),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: customFormField(
                                              formValidateNodifier:
                                                  formValidateNodifier,
                                              readOnly: true,
                                              controller:
                                                  residentialStateController,
                                              labelText: "#State"),
                                        )),
                                    const Expanded(flex: 1, child: SizedBox()),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: customFormField(
                                              formValidateNodifier:
                                                  formValidateNodifier,
                                              readOnly: true,
                                              controller:
                                                  residentialCountryController,
                                              labelText: "#Country"),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                              ]),
                        );
                      }),

                  Text(
                    "Proof of Address",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Proof Type"),
                  const SizedBox(height: 5.0),
                  CustomDropDown(
                    formValidateNodifier: formValidateNodifier,
                    label: "Proof Type",
                    controller: proofType,
                    values: const [
                      "Driving Licence",
                      "Ration Card",
                      "Voter Id"
                    ],
                  ),
                  // CustomSearchDropDown(
                  //     controller: proofTypeController,
                  //     list: [],
                  //     labelText: "Proof Type",
                  //     hintText: ""),
                  const SizedBox(height: 10.0),
                  ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    controller: proofNumberController,
                    labelText: "Proof Number",
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                readOnly: true,
                                controller: dateOfIssueController,
                                labelText: "Date of issue",
                                onTap: () => showDatePick()),
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                controller: palceOfIssueController,
                                labelText: "Place of issue"),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ...customFormField(
                      formValidateNodifier: formValidateNodifier,
                      labelText: "Address proof front Page",
                      controller: addressProofFrontPageController,
                      readOnly: true,
                      hintText: "Upload",
                      // textAlign: TextAlign.center,
                      prefixIcon:
                          Row(mainAxisSize: MainAxisSize.min, children: [
                        const SizedBox(width: 10.0),
                        SvgPicture.asset(
                          "assets/images/attachment.svg",
                          width: 22.0,
                        ),
                        const SizedBox(width: 10.0),
                      ]),
                      onTap: () {}),
                  const SizedBox(height: 10.0),
                  ...customFormField(
                      formValidateNodifier: formValidateNodifier,
                      labelText: "Address proof back Page",
                      controller: addressProofBackPageController,
                      hintText: "Upload",
                      readOnly: true,
                      // textAlign: TextAlign.center,
                      prefixIcon:
                          Row(mainAxisSize: MainAxisSize.min, children: [
                        const SizedBox(width: 10.0),
                        SvgPicture.asset(
                          "assets/images/attachment.svg",
                          width: 22.0,
                        ),
                        const SizedBox(width: 10.0),
                      ]),
                      onTap: () {}),
                  const SizedBox(height: 30.0),
                ],
              ),
            ],
          )),
          const SizedBox(height: 20.0),
          CustomButton(
              valueListenable: formValidateNodifier,
              // onPressed: () {
              //   print(dateChange.value);
              // }
              onPressed: () => Navigator.pushNamed(context, route.bankScreen)),
          const SizedBox(height: 50.0)
        ]);
  }
} */

class AddressManualEntry extends StatefulWidget {
  final Map? address;
  const AddressManualEntry({super.key, this.address});

  @override
  State<AddressManualEntry> createState() => _AddressManualEntryState();
}

class _AddressManualEntryState extends State<AddressManualEntry> {
  DateChange dateChange = DateChange();
  String selectedFilePath = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileNoController =
      TextEditingController(text: "9876543210");
  TextEditingController mailIdController =
      TextEditingController(text: "abc@gmail.com");
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController residentialAddressLine1Controller =
      TextEditingController();
  TextEditingController residentialAddressLine2Controller =
      TextEditingController();
  TextEditingController residentialAddressLine3Controller =
      TextEditingController();
  TextEditingController residentialPinCodeController = TextEditingController();
  TextEditingController residentialCityController = TextEditingController();
  TextEditingController residentialStateController = TextEditingController();
  TextEditingController residentialCountryController = TextEditingController();
// TextfieldValueNodifier proofTypeController = TextfieldValueNodifier();
  TextEditingController proofNumberController = TextEditingController();
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController placeOfIssueController = TextEditingController();
  TextEditingController addressProofFrontPageController =
      TextEditingController();
  TextEditingController addressProofBackPageController =
      TextEditingController();

  TextEditingController prefix = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController proofType = TextEditingController();
  TextEditingController poiExpireDateController = TextEditingController();
  DateTime? poiExpireDate;
  DateTime? proofIssueDate;
  // CheckBoxValueNodifier checkBoxValueNodifier = CheckBoxValueNodifier(true);
  bool residentailAddressSameAsPermentAddress = false;
  String? selectedItem;
  final _formKey = GlobalKey<FormState>();
  List proofTypes = [];
  bool formIsValid = false;
  String docid1 = "";
  String docid2 = "";
  List<File?> files = [null, null];
  List ids = [null, null];
  List keys = [null, null];
  List? addressFrontPageFileDetails;
  List? addressBackPageFileDetails;
  ScrollController scrollController = ScrollController();
  bool formValidationIsTriggered = false;
  bool aadhaarValidation = true;
  bool issueDateIsManitory = false;
  String proofCode = "";
  bool showBackPageAddress = false;
  bool countinueButtonIsTriggered = false;
  checkFormValidation(value) {
    // print("working formvalidation");
    // print(proofType.text);
    // print(
    //     "first ${addressLine1Controller.text.isNotEmpty && addressLine2Controller.text.isNotEmpty && pinCodeController.text.isNotEmpty && cityController.text.isNotEmpty && stateController.text.isNotEmpty && countryController.text.isNotEmpty}");
    // print(
    //     "second ${(checkBoxValueNodifier.value || (residentialAddressLine1Controller.text.isNotEmpty && residentialAddressLine2Controller.text.isNotEmpty && residentialPinCodeController.text.isNotEmpty && residentialCityController.text.isNotEmpty && residentialStateController.text.isNotEmpty && residentialCountryController.text.isNotEmpty))}");
    // print(
    //     "third ${dateOfIssueController.text.isNotEmpty && palceOfIssueController.text.isNotEmpty && addressProofFrontPageController.text.isNotEmpty}");
    if (addressLine1Controller.text.isNotEmpty &&
        addressLine2Controller.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        (residentailAddressSameAsPermentAddress ||
            (residentialAddressLine1Controller.text.isNotEmpty &&
                residentialAddressLine2Controller.text.isNotEmpty &&
                residentialPinCodeController.text.isNotEmpty &&
                residentialCityController.text.isNotEmpty &&
                residentialStateController.text.isNotEmpty &&
                residentialCountryController.text.isNotEmpty)) &&
        ((!issueDateIsManitory) ||
            (dateOfIssueController.text.isNotEmpty &&
                placeOfIssueController.text.isNotEmpty)) &&
        proofType.text.isNotEmpty &&
        addressProofFrontPageController.text.isNotEmpty &&
        (!(["01", "02", "06", "07"].contains(proofCode)) ||
            addressProofBackPageController.text.isNotEmpty)) {
      formValidationIsTriggered = true;
      // print("object");
      bool formValid = _formKey.currentState!.validate();
      // print("formIsValid $formValid");
      if (formIsValid != formValid) {
        formIsValid = formValid;
      }
    } else {
      if (formValidationIsTriggered) {
        _formKey.currentState!.validate();
      }
      formIsValid = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  getAdressProofType() async {
    // print("ggg");
    // print(await verifyCookies());
    // if (await verifyCookies() == true) {
    //    print("object");
    //   Navigator.pushNamed(context, route.address);
    // }
    loadingAlertBox(context);

    var json = await getDropDownValues(context: context, code: "AddressProof");
    if (mounted) {
      Navigator.pop(context);
    }
    print(json);
    if (json != null) {
      proofTypes = json['lookupvaluearr']
          .where((element) => element["code"] != "12")
          .toList();
      // print(proofTypes);
      if (mounted) {
        setState(() {});
      }
    }

    // Navigator.pop(context);
  }

  getInitialData() async {
    await getAdressProofType();
    // print(widget.address);
    if (widget.address != null) {
      residentialAddressLine1Controller.text =
          widget.address!["coradrs1"] ?? "";
      residentialAddressLine2Controller.text =
          widget.address!["coradrs2"] ?? "";
      residentialAddressLine3Controller.text =
          widget.address!["coradrs3"] ?? "";
      residentialCityController.text = widget.address!["corcity"] ?? "";
      residentialPinCodeController.text = widget.address!["corpincode"] ?? "";
      residentialStateController.text = widget.address!["corstate"] ?? "";
      residentialCountryController.text = widget.address!["corcountry"] ?? "";
      addressLine1Controller.text = widget.address!["peradrs1"] ?? "";
      addressLine2Controller.text = widget.address!["peradrs2"] ?? "";
      addressLine3Controller.text = widget.address!["peradrs3"] ?? "";
      cityController.text = widget.address!["percity"] ?? "";
      pinCodeController.text = widget.address!["perpincode"] ?? "";
      stateController.text = widget.address!["perstate"] ?? "";
      countryController.text = widget.address!["percountry"] ?? "";
      residentailAddressSameAsPermentAddress =
          widget.address!["aspermenantaddr"] == null ||
                  widget.address!["aspermenantaddr"] == ""
              ? false
              : widget.address!["aspermenantaddr"];
      // residentialAddressLine1Controller.text = widget.address!["coraddress1"];
      // residentialAddressLine2Controller.text = widget.address!["coraddress2"];
      // residentialAddressLine3Controller.text = widget.address!["coraddress3"];
      // residentialCityController.text = widget.address!["corcity"];
      // residentialPinCodeController.text = widget.address!["corpincode"];
      // residentialStateController.text = widget.address!["corstate"];
      // residentialCountryController.text = widget.address!["corcountry"];
      // addressLine1Controller.text = widget.address!["peraddress1"];
      // addressLine2Controller.text = widget.address!["peraddress2"];
      // addressLine3Controller.text = widget.address!["peraddress3"];
      // cityController.text = widget.address!["percity"];
      // pinCodeController.text = widget.address!["perpincode"];
      // stateController.text = widget.address!["perstate"];
      // countryController.text = widget.address!["percountry"];
      // proofType.text = widget.address!["percountry"];
      // proofType.text = widget.address!["peradrsproofname"];
      String soa = widget.address!["soa"] ?? "";
      if (soa.toLowerCase().contains("manual")) {
        proofType.text = widget.address!["peradrsproofcode"] == null ||
                widget.address!["peradrsproofcode"].isEmpty ||
                !soa.toLowerCase().contains("manual")
            ? ""
            : proofTypes.firstWhere((element) =>
                element["code"] ==
                widget.address!["peradrsproofcode"])["description"];
        proofCode = widget.address!["peradrsproofcode"];
        dateOfIssueController.text =
            widget.address!["peradrsproofisudate"] ?? "";
        proofNumberController.text = widget.address!["peradrsproofno"] ?? "";
        placeOfIssueController.text =
            widget.address!["peradrsproofplaceisu"] ?? "";
        poiExpireDateController.text =
            widget.address!["perproofexpirydate"] ?? "";
        ids[0] = !soa.toLowerCase().contains("manual")
            ? null
            : widget.address!["docid1"];

        ids[1] = !soa.toLowerCase().contains("manual") ||
                widget.address!["docid2"].toString().isEmpty
            ? null
            : widget.address!["docid2"];
        docid1 = ids[0] ?? "";
        docid2 = ids[1] ?? "";
        addressProofFrontPageController.text =
            !soa.toLowerCase().contains("manual")
                ? ""
                : widget.address!["perfilename1"] ?? "";
        addressProofBackPageController.text =
            !soa.toLowerCase().contains("manual")
                ? ""
                : widget.address!["perfilename2"] ?? "";

        addressFrontPageFileDetails = docid1.isNotEmpty
            ? await fetchFile(context: context, id: docid1, list: true)
            : null;
        addressBackPageFileDetails = docid2.isNotEmpty
            ? await fetchFile(context: context, id: docid2, list: true)
            : null;
        addressFrontPageFileDetails != null
            ? addressProofFrontPageController.text = "File Uploaded"
            : null;
        addressBackPageFileDetails != null
            ? addressProofBackPageController.text = "File Uploaded"
            : null;
        showBackPageAddress = ["01", "02", "06", "07"].contains(proofCode);
      }
      if (mounted) {
        // print(ids);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInitialData();
    });
    super.initState();
  }

  changeDateFormat(String date) {
    return "${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}";
  }

  submitForm() async {
    loadingAlertBox(context);
    if (ids[1] == null) {
      ids.removeAt(1);
      keys.removeAt(1);
      files.removeAt(1);
    }
    if (ids.isNotEmpty && ids[0] != null && ids[0].toString().length > 0) {
      keys[0] = "";
    }
    if (ids.length > 1 && ids[1] != null && ids[1].toString().length > 0) {
      keys[1] = "";
    }

    Map fileStruct = {
      "id": ids,
      "key": keys.where((element) => element.toString().isNotEmpty).toList(),
      "prooftype": "addressProof"
    };
    // print(fileStruct);

    if (!ids
        .every((element) => element != null && element.toString().isNotEmpty)) {
      List<File> files1 = [];
      for (var element in files) {
        if (element != null) {
          files1.add(element);
        }
      }
      // print(files1);
      var response = await proofUploadAPI(
          context: context, headerMap: fileStruct, files: files1);

      if (response != null) {
        List l = response["data"];

        if (l.length > 0) {
          docid1 = l[0];
        }
        if (l.length > 1) {
          docid2 = l[1];
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
        }
        return;
      }
    }

    // Map json = {
    //   "sourceofaddress": widget.address?["sourceofaddress"] == null ||
    //           widget.address!["sourceofaddress"].toString().isEmpty
    //       ? ""
    //       : "${widget.address!["sourceofaddress"]}_Manual",
    //   "coraddress1": checkBoxValueNodifier.value
    //       ? addressLine1Controller.text
    //       : residentialAddressLine1Controller.text,
    //   "coraddress2": checkBoxValueNodifier.value
    //       ? addressLine2Controller.text
    //       : residentialAddressLine2Controller.text,
    //   "coraddress3": checkBoxValueNodifier.value
    //       ? addressLine3Controller.text
    //       : residentialAddressLine3Controller.text,
    //   "corcity": checkBoxValueNodifier.value
    //       ? cityController.text
    //       : residentialCityController.text,
    //   "corpincode": checkBoxValueNodifier.value
    //       ? pinCodeController.text
    //       : residentialPinCodeController.text,
    //   "corstate": checkBoxValueNodifier.value
    //       ? stateController.text
    //       : residentialStateController.text,
    //   "corcountry": checkBoxValueNodifier.value
    //       ? countryController.text
    //       : residentialCountryController.text,
    //   "peraddress1": addressLine1Controller.text,
    //   "peraddress2": addressLine2Controller.text,
    //   "peraddress3": addressLine3Controller.text,
    //   "percity": cityController.text,
    //   "perpincode": pinCodeController.text,
    //   "perstate": stateController.text,
    //   "percountry": countryController.text,
    //   "proofofaddresstype": proofType.text,
    //   "proofofaddresstypecode": proofTypes.firstWhere(
    //       (element) => element["description"] == proofType.text)["code"],
    //   "perdate": dateOfIssueController.text.substring(8, 10) +
    //       "/" +
    //       dateOfIssueController.text.substring(5, 7) +
    //       "/" +
    //       dateOfIssueController.text.substring(0, 4),
    //   "perproofno": proofNumberController.text,
    //   "perpalceofissue": placeOfIssueController.text,
    //   "docid1": docid1,
    //   "docid2": docid2,
    //   "perfilename1": addressProofFrontPageController.text,
    //   "perfilename2": addressProofBackPageController.text,
    //   "switch": checkBoxValueNodifier.value
    // };

    Map json = {
      "soa": widget.address?["soa"] == null ||
              widget.address!["soa"].toString().isEmpty
          ? ""
          : widget.address!["soa"].toString().toLowerCase().contains("manual")
              ? widget.address!["soa"]
              : "${widget.address!["soa"]}_Manual",
      "coradrs1": residentailAddressSameAsPermentAddress
          ? addressLine1Controller.text
          : residentialAddressLine1Controller.text,
      "coradrs2": residentailAddressSameAsPermentAddress
          ? addressLine2Controller.text
          : residentialAddressLine2Controller.text,
      "coradrs3": residentailAddressSameAsPermentAddress
          ? addressLine3Controller.text
          : residentialAddressLine3Controller.text,
      "corcity": residentailAddressSameAsPermentAddress
          ? cityController.text
          : residentialCityController.text,
      "corpincode": residentailAddressSameAsPermentAddress
          ? pinCodeController.text
          : residentialPinCodeController.text,
      "corstate": residentailAddressSameAsPermentAddress
          ? stateController.text
          : residentialStateController.text,
      "corcountry": residentailAddressSameAsPermentAddress
          ? countryController.text
          : residentialCountryController.text,
      "peradrs1": addressLine1Controller.text,
      "peradrs2": addressLine2Controller.text,
      "peradrs3": addressLine3Controller.text,
      "percity": cityController.text,
      "perpincode": pinCodeController.text,
      "perstate": stateController.text,
      "percountry": countryController.text,
      "peradrsproofname": proofTypes.firstWhere(
          (element) => element["description"] == proofType.text)["code"],
      "peradrsproofcode": proofTypes.firstWhere((element) =>
          element["description"] == proofType.text)["code"], //proofType.text,
      // "peradrsproofno": proofTypes.firstWhere(
      //     (element) => element["description"] == proofType.text)["code"],
      "peradrsproofisudate": dateOfIssueController.text,
      "peradrsproofno": proofNumberController.text,
      "peradrsproofplaceisu": placeOfIssueController.text,
      "perproofexpirydate": poiExpireDateController.text,
      "docid1": docid1,
      "docid2": docid2,
      // "perfilename1": addressProofFrontPageController.text,
      // "perfilename2": addressProofBackPageController.text,
      "aspermenantaddr": residentailAddressSameAsPermentAddress
    };
    // print("check addres  ${jsonIsModified(widget.address!, json)}");
    var response1 = jsonIsModified(widget.address ?? {}, json)
        ? await postManualEntryDetail(context: context, json: json)
        : "";
    // print("response $response1");
    response1 != null
        ? getNextRoute(context)
        : mounted
            ? Navigator.pop(context)
            : null;
  }

  getNextRoute(context) async {
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

  residentailAddressChangeToSameAsPermentAddress() {
    print("bool $residentailAddressSameAsPermentAddress");
    if (!residentailAddressSameAsPermentAddress) return;
    residentialAddressLine1Controller.text = addressLine1Controller.text;
    residentialAddressLine2Controller.text = addressLine2Controller.text;
    residentialAddressLine3Controller.text = addressLine3Controller.text;
    residentialPinCodeController.text = pinCodeController.text;
    residentialCityController.text = cityController.text;
    residentialStateController.text = stateController.text;
    residentialCountryController.text = countryController.text;
    if (mounted) {
      setState(() {});
    }
  }

  checkresAddSameAsPerAdd() {
    if (!residentailAddressSameAsPermentAddress) return;
    if (residentialAddressLine1Controller.text == addressLine1Controller.text &&
        residentialAddressLine2Controller.text == addressLine2Controller.text &&
        residentialAddressLine3Controller.text == addressLine3Controller.text &&
        residentialPinCodeController.text == pinCodeController.text) {
      residentailAddressSameAsPermentAddress = true;
    } else {
      residentailAddressSameAsPermentAddress = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    FormValidateNodifier formValidateNodifier = FormValidateNodifier({
      // "Name": false,
      // "Date of Birth": false,
      // "Gender": false,
      // "Mobile Number": false,
      // "Mail Id": false,
      "Full Address": false,
      "Address Line 2": false,
      "Address Line 3": false,
      "Pincode": false,
      // "City": false,
      // "State": false,
      // "Country": false,
      "#Full Address": false,
      "#Address Line 2": false,
      "#Address Line 3": false,
      "#Pincode": false,
      // "#City": false,
      // "#State": false,
      // "#Country": false,
      "Proof Type": false,
      "Proof Number": false,
      "Date of issue": false,
      "Place of issue": false,
      // "Address proof front Page": true,
      // "Address proof back Page": true
    });
    datePick({required func, isExpiryDate = false}) {
      DateTime today = DateTime.now();
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: 300,
              width: 250.0,
              child: SfDateRangePicker(
                // showTodayButton: true,
                showNavigationArrow: true,
                // showActionButtons: true,
                initialDisplayDate:
                    isExpiryDate ? poiExpireDate : proofIssueDate,
                initialSelectedDate:
                    isExpiryDate ? poiExpireDate : proofIssueDate,
                minDate: isExpiryDate ? today : DateTime(1900),
                maxDate: isExpiryDate ? DateTime(2100) : today,
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  Navigator.pop(context);
                  func(dateRangePickerSelectionChangedArgs.value);
                },
                // onSubmit: (pickDate) {
                //   if (pickDate == null) return;
                //   Navigator.pop(context);
                //   func(pickDate);
                // },
                // onCancel: () {
                //   Navigator.pop(context);
                // },
                selectionMode: DateRangePickerSelectionMode.single,
              ),
            ),
          );
        },
      );
    }

    // showDatePick({isExpiryDate = false}) async {
    //   DateTime today = DateTime.now();
    //   DateTime? pickDate = await showDatePicker(
    //       context: context,
    //       initialDate: (isExpiryDate ? poiExpireDate : proofIssueDate) ?? today,
    //       firstDate: isExpiryDate ? today : DateTime(1900),
    //       lastDate: isExpiryDate ? DateTime(2100) : today);
    //   return pickDate;
    //   // if (pickDate != null && proofIssueDate != pickDate) {
    //   //   proofIssueDate = pickDate;
    //   //   dateOfIssueController.text = pickDate.toString().substring(0, 10);
    //   // }
    // }

    return StepWidget(
        step: 1,
        title: "PAN & Address",
        title1: "Address Verification",
        subTitle: "Add your address manually  ",
        // resizeToAvoidBottomInset: false,
        endPoint: route.address,
        scrollController: scrollController,
        buttonFunc:
            //  !formIsValid
            //     ? null
            //     :
            () {
          if (!countinueButtonIsTriggered) {
            countinueButtonIsTriggered = true;
            setState(() {});
          }
          if (!(_formKey.currentState!.validate() &&
              proofType.text.isNotEmpty)) {
            return;
          }
          submitForm();
        },
        children: [
          // ...getTitleANdSubTitleWidget(
          //     "PAN & Address", "Add your address manually", context),
          Form(
            key: _formKey,
            onChanged: () => checkFormValidation(""),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* Row(
            children: [
              SizedBox(
                width: 70.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Prefix"),
                    const SizedBox(height: 5.0),
                    CustomDropDown(
                        formValidateNodifier: formValidateNodifier,
                        controller: prefix,
                        values: const ["Mr", "Ms", "Mrs"]),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: customFormField(
                      formValidateNodifier: formValidateNodifier,
                      controller: nameController,
                      labelText: "Name",
                    ),
                  )),
            ],
          ),
                          
          const SizedBox(height: 10.0),
          const Text("Date of Birth*"),
          const SizedBox(height: 5.0),
          CustomDateFormField(
              formValidateNodifier: formValidateNodifier,
              date: dateChange,
              onChange: () {}),
          const SizedBox(height: 10.0),
          const Text("Gender*"),
          const SizedBox(height: 5.0),
          CustomDropDown(
              formValidateNodifier: formValidateNodifier,
              label: "Gender",
              buttonSizeIsSmall: true,
              controller: gender,
              values: const ["male", "female", "others"]),
          const SizedBox(height: 10.0),
          ...customFormField(
              formValidateNodifier: formValidateNodifier,
              readOnly: true,
              controller: mobileNoController,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              labelText: "Mobile Number",
              // textIsGrey: true,
              validator: mobileNumberValidation),
          const SizedBox(height: 10.0),
          ...customFormField(
              formValidateNodifier: formValidateNodifier,
              controller: mailIdController,
              labelText: "Mail Id",
              readOnly: true,
              // textIsGrey: true,
              validator: emailValidation),
          const SizedBox(height: 30.0), */
                Text(
                  "Permanent address",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20.0),
                ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    controller: addressLine1Controller,
                    labelText: "Address Line 1",
                    // inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    onChange: (value) {
                      checkFormValidation(value);
                      residentailAddressChangeToSameAsPermentAddress();
                    },
                    validator: (value) =>
                        validateAddresss(value, "Address Line 1", 5, 50)),
                const SizedBox(height: 10.0),
                ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    controller: addressLine2Controller,
                    labelText: "Address Line 2",
                    // inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    onChange: (value) {
                      checkFormValidation(value);
                      residentailAddressChangeToSameAsPermentAddress();
                    },
                    validator: (value) =>
                        validateAddresss(value, "Address Line 2", 3, 50)),
                const SizedBox(height: 10.0),
                ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    controller: addressLine3Controller,
                    labelText: "Address Line 3@",
                    // inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    validator: (value) =>
                        nullValidationWithMaxLength(value, 50),
                    onChange: (value) {
                      residentailAddressChangeToSameAsPermentAddress();
                    }),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...customFormField(
                                formValidateNodifier: formValidateNodifier,
                                controller: pinCodeController,
                                labelText: "Pincode",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                validator: validatePinCode,
                                onChange: (value) async {
                                  if (value.length == 6) {
                                    // cityController.text = "Chennai";
                                    // stateController.text = "Tamilnadu";
                                    await getpindata(
                                        pincode: pinCodeController.text,
                                        url: 'api/pincode',
                                        permenant: true);
                                    countryController.text = "India";
                                  } else {
                                    cityController.text = "";
                                    stateController.text = "";
                                    countryController.text = "";
                                  }
                                  checkFormValidation(value);
                                  residentailAddressChangeToSameAsPermentAddress();
                                }),
                          ],
                        )),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: customFormField(
                              formValidateNodifier: formValidateNodifier,
                              readOnly: true,
                              controller: cityController,
                              labelText: "City",
                              onChange: checkFormValidation),
                        )),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: customFormField(
                              formValidateNodifier: formValidateNodifier,
                              readOnly: true,
                              controller: stateController,
                              labelText: "State",
                              onChange: checkFormValidation),
                        )),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: customFormField(
                              formValidateNodifier: formValidateNodifier,
                              readOnly: true,
                              controller: countryController,
                              labelText: "Country",
                              onChange: checkFormValidation),
                        )),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Residential Address",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20.0),
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          decoration: BoxDecoration(
                              color: residentailAddressSameAsPermentAddress
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!)),
                          child: residentailAddressSameAsPermentAddress
                              ? Icon(Icons.check_sharp,
                                  size: 12,
                                  color:
                                      //  MediaQuery.of(context)
                                      //             .platformBrightness ==
                                      //         Brightness.light
                                      //    ?
                                      Colors.white
                                  // : Color.fromRGBO(0, 0, 0, 1),
                                  )
                              : null,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: const Text(
                                'Residential Address same as permanent address'))
                      ],
                    ),
                    onTap: () {
                      residentailAddressSameAsPermentAddress =
                          !residentailAddressSameAsPermentAddress;
                      checkFormValidation("");
                      residentailAddressChangeToSameAsPermentAddress();
                      if (mounted) {
                        setState(() {});
                      }
                    }),

                // CustomCheckBox(
                //     checkBoxValueNodifier: checkBoxValueNodifier,
                //     childText:
                //         "Residential Address same as permanent address",
                //     onChange: (value) {
                //       if (value) {
                //         residentialAddressLine1Controller.text =
                //             addressLine1Controller.text;
                //         residentialAddressLine2Controller.text =
                //             addressLine2Controller.text;
                //         residentialAddressLine3Controller.text =
                //             addressLine3Controller.text;
                //         residentialCityController.text =
                //             cityController.text;
                //         residentialCountryController.text =
                //             countryController.text;
                //         residentialPinCodeController.text =
                //             pinCodeController.text;
                //         residentialStateController.text =
                //             pinCodeController.text;
                //       } else {
                //         residentialAddressLine1Controller.text = "";
                //         residentialAddressLine2Controller.text = "";
                //         residentialAddressLine3Controller.text = "";
                //         residentialCityController.text = "";
                //         residentialCountryController.text = "";
                //         residentialPinCodeController.text = "";
                //         residentialStateController.text = "";
                //       }
                //       checkFormValidation(value);
                //       setState(() {});
                //     }),

                const SizedBox(height: 20.0),

                Visibility(
                  visible: true,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...customFormField(
                            formValidateNodifier: formValidateNodifier,
                            controller: residentialAddressLine1Controller,
                            labelText: "Address Line 1",
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(50)
                            // ],
                            onChange: (value) {
                              checkFormValidation(value);
                              checkresAddSameAsPerAdd();
                            },
                            validator: (value) => validateAddresss(
                                value, "Address Line 1", 5, 50)),
                        const SizedBox(height: 10.0),
                        ...customFormField(
                            formValidateNodifier: formValidateNodifier,
                            controller: residentialAddressLine2Controller,
                            labelText: "Address Line 2",
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(50)
                            // ],
                            onChange: (value) {
                              checkFormValidation(value);
                              checkresAddSameAsPerAdd();
                            },
                            validator: (value) => validateAddresss(
                                value, "Address Line 2", 3, 50)),
                        const SizedBox(height: 10.0),
                        ...customFormField(
                            formValidateNodifier: formValidateNodifier,
                            controller: residentialAddressLine3Controller,
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(50)
                            // ],
                            labelText: "Address Line 3@",
                            validator: (value) =>
                                nullValidationWithMaxLength(value, 50),
                            onChange: (value) {
                              checkFormValidation(value);
                              checkresAddSameAsPerAdd();
                            }),
                        const SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...customFormField(
                                        formValidateNodifier:
                                            formValidateNodifier,
                                        controller:
                                            residentialPinCodeController,
                                        labelText: "Pincode",
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        validator: validatePinCode,
                                        onChange: (value) async {
                                          if (value.length == 6) {
                                            // residentialCityController
                                            //     .text = "Chennai";
                                            // residentialStateController
                                            //     .text = "Tamilnadu";
                                            await getpindata(
                                                pincode:
                                                    residentialPinCodeController
                                                        .text,
                                                url: 'pincode',
                                                permenant: false);
                                            residentialCountryController.text =
                                                "India";
                                          } else {
                                            residentialCityController.text = "";
                                            residentialStateController.text =
                                                "";
                                            residentialCountryController.text =
                                                "";
                                          }
                                          checkFormValidation(value);
                                          checkresAddSameAsPerAdd();
                                        }),
                                  ],
                                )),
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: customFormField(
                                      formValidateNodifier:
                                          formValidateNodifier,
                                      readOnly: true,
                                      controller: residentialCityController,
                                      labelText: "City",
                                      onChange: checkFormValidation),
                                )),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: customFormField(
                                      formValidateNodifier:
                                          formValidateNodifier,
                                      readOnly: true,
                                      controller: residentialStateController,
                                      labelText: "State",
                                      onChange: checkFormValidation),
                                )),
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: customFormField(
                                      formValidateNodifier:
                                          formValidateNodifier,
                                      readOnly: true,
                                      controller: residentialCountryController,
                                      labelText: "Country",
                                      onChange: checkFormValidation),
                                )),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                      ]),
                ),

                Text(
                  "Proof of Permanent Address",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "File format should be (*.jpg,*.jpeg,*.png,*.pdf) and file size should be less than 5MB",
                  // style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 10.0),
                const Text("Proof Type"),
                const SizedBox(height: 5.0),
                CustomDropDown(
                    formValidateNodifier: formValidateNodifier,
                    label: "Proof Type",
                    controller: proofType,
                    values:
                        proofTypes.map((state) => state["description"]).toList()
                          ..sort(),
                    showError:
                        countinueButtonIsTriggered && proofType.text.isEmpty,
                    onChange: (value) async {
                      String oldProofCode = proofCode;
                      proofCode = proofTypes.firstWhere(
                          (element) => element["description"] == value,
                          orElse: () => {"code": ""})["code"];
                      showBackPageAddress =
                          ["01", "02", "06", "07"].contains(proofCode);
                      // print("old $oldProofCode");
                      // print("new $proofCode");
                      if (proofCode != oldProofCode && oldProofCode != "") {
                        proofNumberController.text = "";
                        dateOfIssueController.text = "";
                        proofIssueDate = null;
                        poiExpireDate = null;
                        placeOfIssueController.text = "";
                        poiExpireDateController.text = "";
                        addressProofFrontPageController.text = "";
                        addressProofBackPageController.text = "";
                        addressFrontPageFileDetails = null;
                        addressBackPageFileDetails = null;
                        files = [null, null];
                        ids = [null, null];
                        keys = [null, null];
                      }
                      issueDateIsManitory =
                          proofCode == "01" || proofCode == "02";
                      checkFormValidation(value);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                      await Future.delayed(Duration(milliseconds: 50));
                      if (countinueButtonIsTriggered) {
                        _formKey.currentState!.validate();
                      }
                    }
                    //  const [
                    //   "Driving Licence",
                    //   "Ration Card",
                    //   "Voter Id"
                    // ],
                    ),
                // CustomSearchDropDown(
                //     controller: proofTypeController,
                //     list: [],
                //     labelText: "Proof Type",
                //     hintText: ""),
                const SizedBox(height: 10.0),
                if (proofTypes.firstWhere(
                        (element) => element["description"] == proofType.text,
                        orElse: () => {"code": "0"})["code"] ==
                    "12") ...[
                  const Text("Proof Number*"),
                  const SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          // textIsGrey: true,
                          controller: TextEditingController(text: "XXXX"),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: CustomFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          // textIsGrey: true,
                          controller: TextEditingController(text: "XXXX"),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: CustomFormField(
                          noNeedErrorText: true,
                          textAlign: TextAlign.center,
                          controller: proofNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4)
                          ],
                          onChange: (value) {
                            aadhaarValidation = value.length == 4;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Enter only the last 4 digits of the Aadhaar number",
                    style: TextStyle(
                        color: aadhaarValidation
                            ? Theme.of(context).textTheme.bodyMedium!.color
                            : Colors.red),
                  ),
                ] else ...[
                  ...customFormField(
                      formValidateNodifier: formValidateNodifier,
                      controller: proofNumberController,
                      labelText: "Proof Number",
                      onChange: checkFormValidation,
                      validator: (value) => validateName(
                          value,
                          proofType.text.isEmpty
                              ? "Proof Number"
                              : proofType.text,
                          proofCode == "01"
                              ? 12
                              : proofCode == "02"
                                  ? 16
                                  : 4),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(proofCode == "01"
                            ? 12
                            : proofCode == "02"
                                ? 16
                                : 50),
                      ]
                      //  proofType.text == "PAN"
                      //     ? validatePanCard(value)
                      //     : validateName(value, proofType.text,
                      //         proofType.text == "AADHAAR" ? 12 : 4)
                      // ,
                      // inputFormatters: proofType.text == "PAN"
                      //     ? [
                      //         LengthLimitingTextInputFormatter(10),
                      //         UpperCaseTextFormatter(),
                      //         FilteringTextInputFormatter.allow(
                      //             RegExp(r'[a-zA-Z0-9]')),
                      //       ]
                      //     : proofType.text == "AADHAAR"
                      //         ? [
                      //             FilteringTextInputFormatter.digitsOnly,
                      //             LengthLimitingTextInputFormatter(12)
                      //           ]
                      //         : null
                      ),
                ],

                const SizedBox(height: 10.0),

                if (issueDateIsManitory) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                readOnly: true,
                                controller: dateOfIssueController,
                                labelText: issueDateIsManitory
                                    ? "Date of issue"
                                    : "Date of issue@",
                                //          () async {
                                //   DateTime? date =
                                //       await showDatePick(isExpiryDate: true);
                                //   if (date != null && poiExpireDate != date) {
                                //     poiExpireDate = date;
                                //     poiExpireDateController.text =
                                //         date.toString().substring(0, 10);
                                //   }
                                // }
                                onTap: () async {
                                  datePick(func: (DateTime? date) {
                                    // print('jjj');
                                    // print(date);
                                    if (date != null &&
                                        proofIssueDate != date) {
                                      proofIssueDate = date;
                                      dateOfIssueController.text =
                                          "${date.toString().substring(8, 10)}/${date.toString().substring(5, 7)}/${date.toString().substring(0, 4)}";
                                    }
                                    setState(() {});
                                  });
                                },
                                onChange: checkFormValidation,
                                validator: (value) => issueDateIsManitory
                                    ? validateNotNull(value, "Date of issue")
                                    : nullValidation(value)),
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: customFormField(
                                formValidateNodifier: formValidateNodifier,
                                controller: placeOfIssueController,
                                labelText: issueDateIsManitory
                                    ? "Place of issue"
                                    : "Place of issue@",
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                onChange: checkFormValidation,
                                validator: (value) => issueDateIsManitory
                                    ? validatePalce(value)
                                    : nullValidation(value)),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: customFormField(
                        formValidateNodifier: formValidateNodifier,
                        readOnly: true,
                        controller: poiExpireDateController,
                        labelText: "Expiry Date",
                        onTap: () async {
                          datePick(
                              isExpiryDate: true,
                              func: (DateTime? date) {
                                if (date != null && poiExpireDate != date) {
                                  poiExpireDate = date;
                                  poiExpireDateController.text =
                                      "${date.toString().substring(8, 10)}/${date.toString().substring(5, 7)}/${date.toString().substring(0, 4)}";
                                }
                                setState(() {});
                              });
                        },
                        validator: (value) {
                          return issueDateIsManitory
                              ? validateNotNull(value, "Expiry Date")
                              : nullValidation(value);
                        }),
                  ),
                  const SizedBox(height: 10),
                ],
                ...customFormField(
                    formValidateNodifier: formValidateNodifier,
                    labelText: "Address proof front Page",
                    controller: addressProofFrontPageController,
                    readOnly: true,
                    hintText: "Upload",
                    // textAlign: TextAlign.center,,
                    onChange: checkFormValidation,
                    prefixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(width: 10.0),
                      SvgPicture.asset(
                        "assets/images/attachment.svg",
                        width: 22.0,
                      ),
                      const SizedBox(width: 10.0),
                    ]),
                    suffixIcon: files[0] != null ||
                            addressFrontPageFileDetails != null
                        ? IconButton(
                            onPressed: () {
                              if (files[0] != null) {
                                Navigator.pushNamed(
                                    context,
                                    addressProofFrontPageController.text
                                            .endsWith(".pdf")
                                        ? route.previewPdf
                                        : route.previewImage,
                                    arguments: {
                                      "title": "manualEntryProof1",
                                      "data": files[0]!.readAsBytesSync(),
                                      "fileName":
                                          addressProofFrontPageController.text
                                    });
                              } else {
                                Navigator.pushNamed(
                                    context,
                                    addressFrontPageFileDetails![0]
                                            .toString()
                                            .endsWith(".pdf")
                                        ? route.previewPdf
                                        : route.previewImage,
                                    arguments: {
                                      "title": "manualEntryProof1",
                                      "data": addressFrontPageFileDetails![1],
                                      "fileName":
                                          addressFrontPageFileDetails![0]
                                    });
                              }
                            },
                            icon: Icon(
                              Icons.preview,
                              color: const Color.fromARGB(255, 99, 97, 97),
                            ))
                        : null,
                    onTap: () {
                      pickFileBottomSheet(context,
                          (path) => pickAddressProof(context, path, true));
                    }),
                Visibility(
                    visible: showBackPageAddress,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        ...customFormField(
                          formValidateNodifier: formValidateNodifier,
                          labelText: "Address proof back Page",
                          controller: addressProofBackPageController,
                          hintText: "Upload",
                          readOnly: true,
                          onChange: checkFormValidation,
                          // textAlign: TextAlign.center,
                          prefixIcon:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(width: 10.0),
                            SvgPicture.asset(
                              "assets/images/attachment.svg",
                              width: 22.0,
                            ),
                            const SizedBox(width: 10.0),
                          ]),
                          suffixIcon: (files.length > 1 && files[1] != null) ||
                                  addressBackPageFileDetails != null
                              ? IconButton(
                                  onPressed: () {
                                    if (files[1] != null) {
                                      Navigator.pushNamed(
                                          context,
                                          addressProofFrontPageController.text
                                                  .endsWith(".pdf")
                                              ? route.previewPdf
                                              : route.previewImage,
                                          arguments: {
                                            "title": "manualEntryProof1",
                                            "data": files[1]!.readAsBytesSync(),
                                            "fileName":
                                                addressProofFrontPageController
                                                    .text
                                          });
                                    } else {
                                      Navigator.pushNamed(
                                          context,
                                          addressBackPageFileDetails![0]
                                                  .toString()
                                                  .endsWith(".pdf")
                                              ? route.previewPdf
                                              : route.previewImage,
                                          arguments: {
                                            "title": "manualEntryProof1",
                                            "data":
                                                addressBackPageFileDetails![1],
                                            "fileName":
                                                addressBackPageFileDetails![0]
                                          });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.preview,
                                    color:
                                        const Color.fromARGB(255, 99, 97, 97),
                                  ))
                              : null,
                          onTap: () {
                            // pickFile();
                            // setState(() {});
                            pickFileBottomSheet(context,
                                (path) => pickAddressProof(context, path));
                          },
                          validator:
                              showBackPageAddress ? null : (value) => null,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ]);
  }

  pickAddressProof(BuildContext context, String path,
      [bool isFrontpage = false]) async {
    File file = File(path);
    // print(path);
    List l = path.split("/");
    if (isFrontpage) {
      addressProofFrontPageController.text = l[l.length - 1];
      ids[0] = "";
      keys[0] = "file0";
      files[0] = file;
    } else {
      addressProofBackPageController.text = l[l.length - 1];
      ids[1] = "";
      keys[1] = "file1";
      files[1] = file;
    }
    if (mounted) {
      setState(() {});
    }
  }

  getpindata(
      {required String pincode,
      required String url,
      required bool permenant}) async {
    // // await checkCookies(context);
    // http.Response response =
    //     await http.get(Uri.parse("http://192.168.2.5:27094/$url"), headers: {
    //   "Origin": "https://uatekyc101.flattrade.in",
    //   "Referer": "https://uatekyc101.flattrade.in/",
    //   "PINCODE": pincode
    // });
    // Map json = jsonDecode(response.body);
    // if (json["status"] == "S") {
    //   // return http.Response("", 440);
    // if (permenant) {
    //   cityController.text = json["resp"]['city'];
    //   stateController.text = json["resp"]['state'];
    // } else {
    //   residentialCityController.text = json["resp"]['city'];
    //   residentialStateController.text = json["resp"]['state'];
    // }
    // } else {
    //   print(json['errmsg']);
    // }

    // return response;

    var response = await getPincode(context: context, pincode: pincode);
    // print(response);
    if (response != null) {
      if (permenant) {
        cityController.text = response["resp"]['city'];
        stateController.text = response["resp"]['state'];
      } else {
        residentialCityController.text = response["resp"]['city'];
        residentialStateController.text = response["resp"]['state'];
      }
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && mounted) {
      PlatformFile file = result.files.single;
      setState(() {
        if (file.bytes != null) {
          selectedFilePath = file.name;
        } else {
          selectedFilePath = file.name;
          // print("selectedFile ${file.name}");
        }
        addressProofBackPageController.text = selectedFilePath;
        // multipart(file);
      });
    }
  }

  /*  multipart(PlatformFile imageFile) async {
    await checkCookies(context);
    String apiUrl =
        'http://192.168.2.5:27094//api/manual_entry'; // Replace with your actual API endpoint

    // Sample data structure
    Map<String, dynamic> userData = {
      "maritalStatus": "s",
      "corAdrs1": residentialAddressLine1Controller.text ?? '',
      "corAdrs2": residentialAddressLine2Controller.text ?? '',
      "corAdrs3": residentialAddressLine3Controller.text ?? '',
      "corCity": residentialCityController.text ?? '',
      "corState": residentialStateController.text ?? '',
      "corPincode": residentialPinCodeController.text ?? '',
      "corCountry": residentialAddressLine3Controller.text ?? '',
      "perAdrs1": addressLine1Controller.text ?? '',
      "perAdrs2": addressLine2Controller.text ?? '',
      "perAdrs3": addressLine3Controller.text ?? '',
      "perCity": cityController.text ?? '',
      "perState": stateController.text ?? '',
      "perCountry": countryController.text ?? '',
      "perPincode": pinCodeController.text ?? '',
      "perAdrsProofName": proofType.text ?? '',
      "perAdrsProofNo": proofNumberController.text ?? '',
      "perAdrsProofPlaceIsu": palceOfIssueController.text ?? '',
      "perAdrsproofIsuDate": dateOfIssueController.text ?? '',
      "perDocId": imageFile,
      "file": [imageFile]
    };

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Attach the image file to the request
    var multipartFile = http.MultipartFile.fromBytes(
      'file', // Assuming 'file' is the name of the field in the API to receive the file
      imageFile.bytes!,
      filename: imageFile.name,
    );

    request.files.add(multipartFile);

    // Add other form fields to the request
    for (var entry in userData.entries) {
      request.fields[entry.key] = entry.value.toString();
    }

    try {
      // Send the request
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
      } else {
      }
    } catch (e) {
    }
  } */
}
