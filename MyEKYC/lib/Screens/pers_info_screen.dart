// import '../Route/route.dart' as route;
// import 'package:ekyc/screen/pers_verify_screen.dart';
import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:ekyc/Custom%20Widgets/scrollable_widget.dart';
import 'package:ekyc/Model/get_pers_info_model.dart';
import 'package:ekyc/Nodifier/nodifierCLass.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../API call/api_call.dart';
import '../Custom Widgets/StepWidget.dart';
import '../Custom Widgets/custom_button.dart';
import '../Custom Widgets/custom_drop_down.dart';
import '../Custom Widgets/custom_form_field.dart';
import '../Custom Widgets/custom_radio_tile.dart';
import '../Route/route.dart' as route;
import '../Service/validate_func.dart';

class PersInfoScreen extends StatefulWidget {
  const PersInfoScreen({super.key});

  @override
  State<PersInfoScreen> createState() => _PersInfoScreenState();
}

class _PersInfoScreenState extends State<PersInfoScreen> {
  bool isFormValidation = false;
  var formKey = GlobalKey<FormState>();
  FormValidateNodifier formValidateNodifier = FormValidateNodifier({
    "Marital Status": false,
    "Gender": false,
    "Phone number belongs to": false,
    "Mail id belongs to": false,
    "Annual income": false,
    "Trading Experience": false,
    "Occupation": false,
    "Education qualification": false
  });

  PersonalStruct? persDetailStruc;

  ///Dropdown controller:

  TextEditingController maritalDropDownController = TextEditingController();
  TextEditingController genderDropDownController = TextEditingController();
  TextEditingController phoneDropDownController = TextEditingController();
  TextEditingController emailDropDownController = TextEditingController();

  TextEditingController annIncDropDownController = TextEditingController();
  TextEditingController tradingExpDropDownController = TextEditingController();
  TextEditingController occuDropDownController = TextEditingController();
  TextEditingController educationDropDownController = TextEditingController();

  ///TextField controller:

  TextEditingController momNameController = TextEditingController();
  TextEditingController momNameTitleController = TextEditingController();
  TextEditingController dadNameController = TextEditingController();
  TextEditingController dadNameTitleController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController emailBelongsController = TextEditingController();
  TextEditingController phoneBelongsController = TextEditingController();

  String politicallyRadio = "N";
  String addNomineeRadio = "Y";

  bool occuBool = false;
  bool educationBool = false;
  bool emailBelongBool = false;
  bool phoneBelongBool = false;
  bool isLoadingPersDetails = true;
  bool isEditPersDetails = false;

  List occuDropDownData = [];
  List nameTitleDropDownData = [];
  List maritalDropDownData = [];
  List genderDropDownData = [];
  List educationDropDownData = [];
  List belongsDropDownData = [];
  List traExpDropDownData = [];
  List annIncDropDownData = [];

  List occuDescList = [];
  List nameTitleDescList = [];
  List maritalDescList = [];
  List genderDescList = [];
  List educationDescList = [];
  List phoneBelongsOwnerDescList = [];
  List emailBelongsOwnerDescList = [];
  List annualIncomeDescList = [];
  List tradingExpDescList = [];
  String defaultOwner = "";

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMaritalDropDownDetails();
    });
    persDetailStruc = PersonalStruct(
        fatherNameTitle: "",
        motherNameTitle: "",
        fatherName: "",
        motherName: "",
        annualIncome: "",
        tradingExperience: "",
        occupation: "",
        gender: "",
        emailOwner: "",
        phoneOwner: "",
        politicalExpo: "",
        maritalStatus: "",
        education: "",
        nomineeOpted: "",
        emailOwnerName: "",
        educationOthers: "",
        occOthers: "",
        phoneOwnerName: "");
    /*  persDetailStruc = PersonalStruct(
        maritalStatus: "902",
        gender: "112",
        emailOwner: "121",
        phoneOwner: "121",
        fatherName: "rg",
        motherName: "sdg",
        annualIncome: "501",
        tradingExperience: "601",
        occupation: "701",
        politicalExpo: "N",
        education: "801",
        nomineeOpted: "Yes"); */
    super.initState();
  }

  formvalidate(value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (maritalDropDownController.text.isNotEmpty &&
          genderDropDownController.text.isNotEmpty &&
          phoneDropDownController.text.isNotEmpty &&
          emailDropDownController.text.isNotEmpty &&
          annIncDropDownController.text.isNotEmpty &&
          tradingExpDropDownController.text.isNotEmpty &&
          occuDropDownController.text.isNotEmpty &&
          educationDropDownController.text.isNotEmpty &&
          dadNameTitleController.text.isNotEmpty &&
          dadNameController.text.isNotEmpty &&
          momNameTitleController.text.isNotEmpty &&
          momNameController.text.isNotEmpty) {
        if (((educationDropDownController.text.toLowerCase() == "others" &&
                    educationController.text.isNotEmpty) ||
                educationDropDownController.text.toLowerCase() != "others") &&
            ((occuDropDownController.text.toLowerCase() == "others" &&
                    occupationController.text.isNotEmpty) ||
                occuDropDownController.text.toLowerCase() != "others") &&
            ((emailDropDownController.text.toLowerCase() != "self" &&
                    emailBelongsController.text.isNotEmpty) ||
                emailDropDownController.text.toLowerCase() == "self") &&
            ((phoneDropDownController.text.toLowerCase() != "self" &&
                    phoneBelongsController.text.isNotEmpty) ||
                phoneDropDownController.text.toLowerCase() == "self")) {
          isFormValidation = true;
        } else {
          isFormValidation = false;
        }
      } else {
        isFormValidation = false;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      endPoint: route.persInfo,
      step: 2,
      title: "Personal Information",
      subTitle: "a bit of personal information about you",
      scrollController: scrollController,
      children: [
        // !isLoadingPersDetails
        //     ?
        Flexible(
            child: Form(
          key: formKey,
          child: ScrollableWidget(
            controller: scrollController,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Personal Information",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: const Color.fromRGBO(102, 98, 98, 1),
                                    fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Marital Status*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: maritalDropDownController,
                      values: maritalDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Marital Status",
                      onChange: formvalidate,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Gender*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: genderDropDownController,
                      values: genderDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Gender",
                      onChange: formvalidate,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Given phone number belongs to*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: phoneDropDownController,
                      values: phoneBelongsOwnerDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Given phone number belongs to",
                      onChange: (phoneBelongsValue) {
                        phoneBelongsValue == defaultOwner
                            ? phoneBelongBool = false
                            : phoneBelongBool = true;
                        phoneBelongsValue == defaultOwner
                            ? phoneBelongsController.text = ""
                            : null;
                        formvalidate(phoneBelongsValue);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {});
                          }
                        });
                      },
                    ),
                    Visibility(
                        visible: phoneDropDownController.text != defaultOwner,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              ...customFormField(
                                controller: phoneBelongsController,
                                labelText:
                                    "${phoneDropDownController.text} Name",
                                onChange: formvalidate,
                              ),
                            ])),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Given mail id belongs to*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: emailDropDownController,
                      values: emailBelongsOwnerDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Given mail id belongs to",
                      onChange: (emailBelongsValue) {
                        emailBelongsValue == defaultOwner
                            ? emailBelongBool = false
                            : emailBelongBool = true;
                        emailBelongsValue == defaultOwner
                            ? emailBelongsController.text = ""
                            : null;
                        formvalidate(emailBelongsValue);
                        // setState(() {})
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {});
                          }
                        });
                      },
                    ),
                    Visibility(
                        visible: emailDropDownController.text != defaultOwner,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              ...customFormField(
                                controller: emailBelongsController,
                                labelText:
                                    "${emailDropDownController.text} Name",
                                onChange: formvalidate,
                              ),
                            ])),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Parents",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: const Color.fromRGBO(102, 98, 98, 1),
                                    fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    const Text("Father's or Spouse Name*"),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 80.0,
                          child: CustomDropDown(
                            controller: dadNameTitleController,
                            values: nameTitleDescList,
                            formValidateNodifier: formValidateNodifier,
                            isIcon: true,
                            hint: "",
                            onChange: (emailBelongsValue) {
                              formvalidate(emailBelongsValue);
                              // setState(() {})
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomFormField(
                              // formValidateNodifier: formValidateNodifier,
                              controller: dadNameController,
                              labelText: "Father's or Spouse Name",
                              hintText: "Father's or Spouse Name",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
                              validator: (value) =>
                                  validateName(value, "Father's Name", 3)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Mother's Name*"),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 80.0,
                          child: CustomDropDown(
                            controller: momNameTitleController,
                            values: nameTitleDescList,
                            formValidateNodifier: formValidateNodifier,
                            isIcon: true,
                            hint: "",
                            onChange: (emailBelongsValue) {
                              formvalidate(emailBelongsValue);
                              // setState(() {})
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomFormField(
                              // formValidateNodifier: formValidateNodifier,
                              controller: momNameController,
                              labelText: "Mother's Name",
                              hintText: "Mother's Name",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
                              validator: (value) =>
                                  validateName(value, "Mother's Name", 3)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Background",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: const Color.fromRGBO(102, 98, 98, 1),
                                    fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Annual income*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: annIncDropDownController,
                      values: annualIncomeDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Annual income",
                      onChange: formvalidate,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Trading Experience*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: tradingExpDropDownController,
                      values: tradingExpDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Trading Experience",
                      onChange: formvalidate,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Occupation*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: occuDropDownController,
                      values: occuDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Occupation",
                      onChange: (occuValue) {
                        occuValue == "Others"
                            ? occuBool = true
                            : occuBool = false;
                        occuValue == "Others"
                            ? occupationController.text = ""
                            : null;
                        formvalidate(occuValue);
                        // setState(() {});
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {});
                          }
                        });
                      },
                    ),
                    Visibility(
                        visible: occuDropDownController.text == "Others",
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              ...customFormField(
                                controller: occupationController,
                                labelText: "Occupation Details",
                                onChange: formvalidate,
                              ),
                            ])),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Education qualification*"),
                    const SizedBox(height: 10.0),
                    CustomDropDown(
                      controller: educationDropDownController,
                      values: educationDescList,
                      formValidateNodifier: formValidateNodifier,
                      isIcon: true,
                      hint: "Education qualification",
                      onChange: (eduValue) {
                        print(
                            "educationController.text ${educationDropDownController.text}");
                        eduValue == "Others"
                            ? educationBool = true
                            : educationBool = false;
                        eduValue == "Others"
                            ? educationController.text = ""
                            : null;
                        formvalidate(eduValue);
                        // setState(() {});
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {});
                          }
                        });
                      },
                    ),
                    Visibility(
                        visible: educationDropDownController.text == "Others",
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              ...customFormField(
                                controller: educationController,
                                labelText: "Education Qualification",
                                onChange: formvalidate,
                              ),
                            ])),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text("Are you a politically exposed person?",
                        // textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomRadioTile(
                          label: 'Yes',
                          value: "Y",
                          groupValue: politicallyRadio,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                politicallyRadio = value!;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        CustomRadioTile(
                          label: 'No',
                          value: "N",
                          groupValue: politicallyRadio,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                politicallyRadio = value!;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Do you wish to add nominee?",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomRadioTile(
                          label: 'Yes',
                          value: "Y",
                          groupValue: addNomineeRadio,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                addNomineeRadio = value!;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        CustomRadioTile(
                          label: 'No',
                          value: "N",
                          groupValue: addNomineeRadio,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                addNomineeRadio = value!;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    "I confirm that I have read and understood the following ",
                                // textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium),
                            TextSpan(
                              text: "terms and condition",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: const Color.fromRGBO(
                                          50, 169, 220, 1)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                        context, route.esignHtml, arguments: {
                                      "url": "https://flattrade.in/terms"
                                    }),
                            )
                          ],
                        )),
                    // Text(
                    //     "I confirm that I have read and understood the following terms and condition",
                    //     textAlign: TextAlign.center,
                    //     style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      // onPressed: occuRadio.isEmpty ||
                      //         annualIncRadio.isEmpty ||
                      //         maritalStsRadio.isEmpty ||
                      //         genderRadio.isEmpty ||
                      //         educationRadio.isEmpty ||
                      //         emailBelongsRadio.isEmpty ||
                      //         phoneBelongsRadio.isEmpty ||
                      //         tradingExpRadio.isEmpty ||
                      onPressed: !isFormValidation
                          ? null
                          : () async {
                              postPersInfo();
                              /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProviderPersVerify()));
                          postPersInfo(); */
                            }
                      //  => Navigator.pushNamed(context, route.nominee)
                      ,
                      childText: "Continue",
                      // valueListenable: formValidateNodifier,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ))
        // : const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  /*      var response = await addPersInfo(json: {
      "maritalStatus": maritalDropDownData.firstWhere((element) =>
          element["description"] == maritalDropDownController.text)["code"],
      "gender": genderDropDownData.firstWhere((element) =>
          element["description"] == genderDropDownController.text)["code"],
      "emailOwner": belongsDropDownData.firstWhere((element) =>
          element["description"] == emailDropDownController.text)["code"],
      "phoneOwner": belongsDropDownData.firstWhere((element) =>
          element["description"] == phoneDropDownController.text)["code"],
      "fatherName": dadNameController.text,
      "motherName": momNameController.text,
      "annualIncome": annIncDropDownData.firstWhere((element) =>
          element["description"] == annIncDropDownController.text)["code"],
      "tradingExperience": traExpDropDownData.firstWhere((element) =>
          element["description"] == tradingExpDropDownController.text)["code"],
      "occupation": occuDropDownData.firstWhere((element) =>
          element["description"] == occuDropDownController.text)["code"],
      "politicalExpo": "N",
      "education": educationDropDownData.firstWhere((element) =>
          element["description"] == educationDropDownController.text)["code"],
      "nomineeOpted": addNomineeRadio.substring(0, 1)
    }); */

  postPersInfo() async {
    loadingAlertBox(context);
    var response = await addPersInfo(
        context: context,
        maritalStatus: maritalDropDownData.firstWhere((element) =>
            element["description"] == maritalDropDownController.text)["code"],
        gender: genderDropDownData.firstWhere((element) =>
            element["description"] == genderDropDownController.text)["code"],
        emailOwner: belongsDropDownData.firstWhere((element) =>
            element["description"] == emailDropDownController.text)["code"],
        phoneOwner: belongsDropDownData.firstWhere((element) =>
            element["description"] == phoneDropDownController.text)["code"],
        fatherTitle: nameTitleDropDownData.firstWhere(
            (element) => element["description"] == dadNameTitleController.text)["code"],
        fatherName: dadNameController.text,
        motherTitle: nameTitleDropDownData.firstWhere((element) => element["description"] == momNameTitleController.text)["code"],
        motherName: momNameController.text,
        annualIncome: annIncDropDownData.firstWhere((element) => element["description"] == annIncDropDownController.text)["code"],
        tradingExperience: traExpDropDownData.firstWhere((element) => element["description"] == tradingExpDropDownController.text)["code"],
        occupation: occuDropDownData.firstWhere((element) => element["description"] == occuDropDownController.text)["code"],
        politicalExpo: politicallyRadio,
        education: educationDropDownData.firstWhere((element) => element["description"] == educationDropDownController.text)["code"],
        nomineeOpted: addNomineeRadio.substring(0, 1),
        eduOthers: educationController.text,
        occOthers: occupationController.text,
        emailOwnerName: emailBelongsController.text,
        phoneOwnerName: phoneBelongsController.text);

    response != null
        ? getNextRoute(context)
        : mounted
            ? Navigator.pop(context)
            : null;
  }

  getNextRoute(context) async {
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.persInfo],
      "routeraction": "Next"
    });

    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

  fetchMaritalDropDownDetails() async {
    loadingAlertBox(context);
    var response =
        await getDropDownValues(context: context, code: "MarritalStatus");
    // print(response);
    if (response != null) {
      maritalDropDownData = response["lookupvaluearr"];
      maritalDescList =
          maritalDropDownData.map((e) => e["description"]).toList();
      // print(maritalDescList);
      // print("${maritalDescList}");
      if (mounted) {
        setState(() {});
      }
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchOccuDropDown();
  }

  fetchOccuDropDown() async {
    var response =
        await getDropDownValues(context: context, code: "Occupation");
    if (response != null) {
      occuDropDownData = response["lookupvaluearr"];
      occuDescList = occuDropDownData.map((e) => e["description"]).toList();
      if (mounted) {
        setState(() {});
      }
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }

    fetchGenderDropDown();
  }

  fetchGenderDropDown() async {
    var response = await getDropDownValues(context: context, code: "Gender");
    if (response != null) {
      genderDropDownData = response["lookupvaluearr"] ?? [];
      genderDescList = genderDropDownData.map((e) => e["description"]).toList();
      if (mounted) {
        setState(() {});
      }
      // print(genderDescList);
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchNameTitleDropDown();
  }

  fetchNameTitleDropDown() async {
    var response =
        await getDropDownValues(context: context, code: "client title");
    if (response != null) {
      nameTitleDropDownData = response["lookupvaluearr"] ?? [];
      nameTitleDescList =
          nameTitleDropDownData.map((e) => e["description"]).toList();

      if (mounted) {
        setState(() {});
      }
      // print(genderDescList);
    } else {
      // if (mounted) {
      //   // Navigator.pop(context);
      // }
    }
    fetchEducationDropDown();
  }

  fetchEducationDropDown() async {
    var response = await getDropDownValues(context: context, code: "Eduaction");
    if (response != null) {
      educationDropDownData = response["lookupvaluearr"] ?? [];
      educationDescList =
          educationDropDownData.map((e) => e["description"]).toList();
      if (mounted) {
        setState(() {});
      }
      // print(educationDescList);
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchphEmailBelongsDropDown();
  }

  fetchphEmailBelongsDropDown() async {
    var response = await getDropDownValues(context: context, code: "Owners");
    if (response != null) {
      belongsDropDownData = response["lookupvaluearr"] ?? [];

      phoneBelongsOwnerDescList =
          belongsDropDownData.map((e) => e["description"]).toList();
      emailBelongsOwnerDescList =
          belongsDropDownData.map((e) => e["description"]).toList();
      int indexOfdefalutOwner =
          belongsDropDownData.indexWhere((element) => element["code"] == "121");
      defaultOwner = indexOfdefalutOwner != -1
          ? belongsDropDownData[indexOfdefalutOwner]["description"]
          : "";
      phoneDropDownController.text = defaultOwner;
      emailDropDownController.text = defaultOwner;
      if (mounted) {
        setState(() {});
      }
      // print(phoneBelongsOwnerDescList);
      // print(emailBelongsOwnerDescList);
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchAnnualIncomeDropDown();
  }

  fetchAnnualIncomeDropDown() async {
    var response =
        await getDropDownValues(context: context, code: "annualIncome");
    if (response != null) {
      annIncDropDownData = response["lookupvaluearr"] ?? [];
      annualIncomeDescList =
          annIncDropDownData.map((e) => e["description"]).toList();
      if (mounted) {
        setState(() {});
      }
      // print(annualIncomeDescList);
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchtradingExpDropDown();
  }

  fetchtradingExpDropDown() async {
    var response =
        await getDropDownValues(context: context, code: "TradingExp");
    if (response != null) {
      traExpDropDownData = response["lookupvaluearr"] ?? [];
      tradingExpDescList =
          traExpDropDownData.map((e) => e["description"]).toList();
      if (mounted) {
        setState(() {});
      }
      // print(tradingExpDescList);
    } else {
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    }
    fetchPersonalDetails();
  }

  fetchPersonalDetails() async {
    GetPersonalDetailsModel? getPersonalDetailsModel =
        await fetchPersonalDetailFromApi(context);
    // phoneDropDownController.text = "Self";
    // emailDropDownController.text = "Self";
    if (getPersonalDetailsModel != null &&
        getPersonalDetailsModel.personalStruct != null) {
      persDetailStruc = getPersonalDetailsModel.personalStruct;
      if (persDetailStruc!.gender.isNotEmpty) {
        genderDropDownController.text = genderDropDownData.firstWhere(
            (element) =>
                element["code"] == persDetailStruc!.gender,
          orElse: () => {"description": ""},
        )["description"];
      }
      // persDetailStruc!.occupation != null &&
      if (persDetailStruc!.occupation.isNotEmpty) {
        //     isEditPersDetails = true;
        occuDropDownController.text = occuDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.occupation,
          orElse: () => {"description": ""},
        )["description"];
        annIncDropDownController.text = annIncDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.annualIncome,
          orElse: () => {"description": ""},
        )["description"];
        maritalDropDownController.text = maritalDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.maritalStatus,
          orElse: () => {"description": ""},
        )["description"];
        educationDropDownController.text = educationDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.education,
          orElse: () => {"description": ""},
        )["description"];
        emailDropDownController.text = belongsDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.emailOwner,
          orElse: () => {"description": ""},
        )["description"];
        phoneDropDownController.text = belongsDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.phoneOwner,
          orElse: () => {"description": ""},
        )["description"];
        tradingExpDropDownController.text = traExpDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.tradingExperience,
          orElse: () => {"description": ""},
        )["description"];
        politicallyRadio = persDetailStruc!.politicalExpo;
        addNomineeRadio = persDetailStruc!.nomineeOpted;
        dadNameTitleController.text = nameTitleDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.fatherNameTitle,
          orElse: () => {"description": ""},
        )["description"];
        momNameTitleController.text = nameTitleDropDownData.firstWhere(
          (element) => element["code"] == persDetailStruc!.motherNameTitle,
          orElse: () => {"description": ""},
        )["description"];
        dadNameController.text = persDetailStruc!.fatherName;
        momNameController.text = persDetailStruc!.motherName;
        educationController.text = persDetailStruc!.educationOthers;
        occupationController.text = persDetailStruc!.occOthers;
        emailBelongsController.text = persDetailStruc!.emailOwnerName;
        phoneBelongsController.text = persDetailStruc!.phoneOwnerName;

        formvalidate("");
      }
    }

    if (mounted) {
      Navigator.pop(context);
    }

    isLoadingPersDetails = false;
    if (mounted) {
      setState(() {});
    }
  }
}
