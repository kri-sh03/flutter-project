import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/CustomDropDOwn.dart';
import 'package:ekyc/Custom%20Widgets/custom_button.dart';
import 'package:ekyc/Custom%20Widgets/custom_form_field.dart';
import 'package:ekyc/Service/validate_func.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Cookies/cookies.dart';
import '../Custom Widgets/login_page_widget.dart';
import '../Nodifier/nodifierCLass.dart';
import '../Route/route.dart' as route;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController state = TextEditingController();
  List states = [];
  String stateCode = "";
  bool buttonIsLoading = false;
  FormValidateNodifier formValidateNodifier = FormValidateNodifier(
      {"Name": false, "Mobile Number": false, "State": false});
  var _formKey = GlobalKey<FormState>();
  bool formIsValid = false;
  // final _formKey = GlobalKey<FormState>();
  // onchangeValidation(value) {
  //   buttonEnableNodifier.changeValue(validatePhoneNumber(value) == null);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // checkCookie();
      getStateName();
    });

    super.initState();
  }

  checkCookie() async {
    if (await CustomHttpClient.verifyCookies() == true) {
      // getNextRoute(context);
      Navigator.pushNamed(context, route.segmentSelection);
    } else {
      getStateName();
    }
  }

  getStateName() async {
    loadingAlertBox(context);
    var json = await getDropDownValues(context: context, code: "state");
    if (json != null) {
      states = json['lookupvaluearr'];
      if (mounted) {
        setState(() {});
      }
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  getNextRoute(context) async {
    //  response != null ? getNextRoute(context) : Navigator.pop(context);
    loadingAlertBox(context);
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.signup],
      "routeraction": "Next"
    });
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, response["endpoint"], (route) => false);
    } else {
      getStateName();
    }
  }

  generateMobileOtp() async {
    loadingAlertBox(context);
    // String code = states.firstWhere(
    //     (element) => element["description"] == state.text)["code"];
    var json = await otpCallAPI(json: {
      "clientname": nameController.text,
      "sendto": mobileNumberController.text,
      "sendtotype": "MOBILE"
    }, context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (json != null) {
      print(json);
      Navigator.pushNamed(context, route.mobileOTP, arguments: {
        "encrypteval": json["encryptedval"],
        "insertedid": json["validateid"],
        "name": nameController.text,
        "mobileNo": mobileNumberController.text,
        "state": states.firstWhere(
            (element) => element["description"] == state.text)["code"]
      });
    }
    buttonIsLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  checkFormValidOrNot(value) {
    if (nameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty &&
        state.text.isNotEmpty) {
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
    return LoginPageWidget(
      isSignIn: true,
      title: "", //"Lets Start!",
      subTitle:
          "", // "Tell us your Mobile number to receive a OTP for Verifivation",
      children: [
        Form(
            key: _formKey,
            onChanged: () => checkFormValidOrNot(""),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.cut),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomFormField(
                    labelText: "Name",
                    hintText: "Name as per Aadhaar",
                    filled: true,
                    formValidateNodifier: formValidateNodifier,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
                    controller: nameController,
                    onChange: checkFormValidOrNot,
                    validator: (value) => validateName(value, "Name", 2)),
                const SizedBox(
                  height: 20.0,
                ),
                // const Text("State*"),
                // const SizedBox(height: 5.0),
                // CustomDropDown(
                //   formValidateNodifier: formValidateNodifier,
                //   controller: state,
                //   values: states.map((state) => state["description"]).toList()
                //     ..sort(),
                //   isIcon: true,
                //   label: "State",
                //   menuHeight: 200,
                //   onChange: checkFormValidOrNot,
                // ),
                CustomSearchDropDown(
                  filled: true,
                  controller: state,
                  list: states.isEmpty
                      ? []
                      : states.map((state) => state["description"]).toList()
                    ..sort(),
                  labelText: "",
                  hintText: "State",
                  isIcon: true,
                  onChange: checkFormValidOrNot,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Text(
                //   "Mobile Number*",
                //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //       fontWeight: FontWeight.w500,
                //       color: Theme.of(context).textTheme.displayMedium!.color),
                // ),
                // const SizedBox(height: 5.0),
                // Stack(
                //   alignment: Alignment.topLeft,
                //   children: [
                // Container(
                //     margin: const EdgeInsets.only(left: 70.0, top: 5.0),
                //     height: 37.0,
                //     width: 1.0,
                //     // color: Colors.red,
                //     child: const RotatedBox(
                //         quarterTurns: 45,
                //         child: DottedLine(
                //           isSmall: true,
                //         ))),
                CustomFormField(
                    labelText: "Mobile Number",
                    hintText: "Mobile number",
                    formValidateNodifier: formValidateNodifier,
                    filled: true,
                    controller: mobileNumberController,
                    inputFormatters: [
                      // FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
                    /*  prefixIcon: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      // decoration: BoxDecoration(
                      //     border: Border(
                      //         right: BorderSide(
                      //             color: Colors.red,
                      //             style: BorderStyle.solid))),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(right: 5.0),
                            //   color: Colors.green,
                            //   width: 15.0,
                            //   height: 10.0,
                            // ),
                            Image.asset(
                              "assets/images/flag.png",
                              width: 20.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text(
                              "+91",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            const SizedBox(
                              width: 17.0,
                            ),
                          ],
                        ),
                      ),
                    ), */
                    validator: mobileNumberValidation,
                    onChange: checkFormValidOrNot),
                //   ],
                // ),
              ],
            )),
        const SizedBox(
          height: 10.0,
        ),
        // Text("Login with client ID",
        //     style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        const Expanded(flex: 4, child: SizedBox()),
        Container(
          alignment: Alignment.center,
          child: Text.rich(
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: 'By proceeding , I agree to the',
                    style: TextStyle(color: Color.fromRGBO(102, 98, 98, 1))),
                TextSpan(
                    text: " T&C",
                    style: TextStyle(color: Color.fromRGBO(50, 169, 220, 1)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(
                          context, route.esignHtml,
                          arguments: {"url": "https://flattrade.in/terms"})),
                TextSpan(
                    text: ' and',
                    style: TextStyle(color: Color.fromRGBO(102, 98, 98, 1))),
                TextSpan(
                    text: " privacy Policy",
                    style: TextStyle(color: Color.fromRGBO(50, 169, 220, 1)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(
                          context, route.esignHtml,
                          arguments: {"url": "https://flattrade.in/terms"})),
              ])),
        ),
        const SizedBox(
          height: 10.0,
        ),
        CustomButton(
            // valueListenable: formValidateNodifier,
            onPressed: buttonIsLoading || !formIsValid
                ? null
                : () {
                    if (_formKey.currentState!.validate() &&
                        state.text.isNotEmpty) {
                      buttonIsLoading = true;
                      if (mounted) {
                        setState(() {});
                      }
                      generateMobileOtp();
                    }
                  }
            //     () => Navigator.pushNamed(context, route.mobileOTP, arguments: {
            //   "encrypteval": "******3210##225143",
            //   "insertedid": "1234",
            //   "name": "DIWAN",
            //   "mobileNo": "9876543210",
            //   "state": "TamilNadu"
            // }),
            ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

loadingAlertBox(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
      );
    },
  );
}

/* // "Cookie":
          //     "fortunetradingcorporation-_zldp=YyabJSmWdaowzkiFlx8dl5ziLKQspEj3PWDyh7G67qArNzcktkFHE9Zl4wHiSI3%2BmKwM1K1ctjo%3D; _ga_T5Q69Z3LRK=GS1.1.1700489091.6.0.1700489091.60.0.0; _gcl_au=1.1.449352029.1703682970; _ga=GA1.1.237999822.1694689860; _fbp=fb.1.1703682979403.52853987; _ga_MW0L67PCZ7=GS1.1.1703686004.3.0.1703686004.60.0.0",
          // "Accept": "application/json",
          "Origin": "https://uatekyc101.flattrade.in",
          "Referer": "https://uatekyc101.flattrade.in/",
          // "Content-Type": "application/json",
          // "Accept-Language": "en-GB,en-US;q=0.9,en;q=0.8",
          // "Accept-Encoding": "gzip, deflate, br" */
