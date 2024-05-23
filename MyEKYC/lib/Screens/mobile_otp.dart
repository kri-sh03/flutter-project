import 'dart:async';

import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/login_page_widget.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Custom Widgets/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Custom Widgets/custom_snackBar.dart';
import '../Route/route.dart' as route;

class MobileOTP extends StatefulWidget {
  final String state;
  final String id;
  final String mobileNumber;
  final String encryptMobileNumber;
  final String name;
  const MobileOTP(
      {super.key,
      required this.mobileNumber,
      required this.id,
      required this.name,
      required this.encryptMobileNumber,
      required this.state});

  @override
  State<MobileOTP> createState() => _MobileOTPState();
}

class _MobileOTPState extends State<MobileOTP> {
  String? secureMobileNumber;
  TextEditingController otpPinController = TextEditingController();
  // FormValidateNodifier formValidateNodifier =
  //     FormValidateNodifier({"otp": false});
  bool formIsValid = false;
  bool isResendingOTP = false;
  String id = "";
  bool buttonIsLoading = false;
  Duration time = const Duration(minutes: 2);
  Timer? timer;
  String otp = "";
  @override
  void initState() {
    id = widget.id;
    print("id $id");
    secureMobileNumber =
        "${widget.mobileNumber.substring(0, 3)} xxxxxx${widget.mobileNumber.substring(9)}"; //987654
    timerFunc();
    otp = widget.encryptMobileNumber.split("##")[1];
    if (mounted) {
      setState(() {});
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showSnackbar(
    //       context, widget.encryptMobileNumber.split("##")[1], Colors.green);
    // });
    super.initState();
  }

// {"encrypteval":"d**********@g****.com##845504","insertedid":"5740","attemptcount":1,"status":"S"}
  verifyMobileOTP() async {
    loadingAlertBox(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    var json = await validateOTPAPI(
        json: {"validateId": id, "otp": otpPinController.text},
        context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (json != null) {
      Navigator.pushNamed(context, route.email, arguments: {
        "name": widget.name,
        "mobileNo": widget.mobileNumber,
        "state": widget.state
      });
    }
    buttonIsLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  timerFunc() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time = time - const Duration(seconds: 1);
      if (time == Duration.zero) {
        Future.delayed(const Duration(milliseconds: 500), () {
          timer.cancel();
          if (mounted) {
            setState(() {});
          }
        });
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  ResendMobileOTP() async {
    loadingAlertBox(context);
    // String code = states.firstWhere(
    //     (element) => element["description"] == state.text)["code"];
    var json = await otpCallAPI(json: {
      "username": widget.name,
      "sendto": widget.mobileNumber,
      "sendtotype": "MOBILE"
    }, context: context);
    if (json != null) {
      time = const Duration(minutes: 2);
      timerFunc();
      id = json["validateid"];
      isResendingOTP = false;
      // showSnackbar(context, "OTP sent Sucessfully", Colors.green);
      otp = json["encryptedval"].split("##")[1];
      if (mounted) {
        setState(() {});
      }
      // showSnackbar(context, json["encrypteval"].split("##")[1], Colors.green);
      // setState(() {});
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageWidget(
      title: "OTP Verification",
      subTitle:
          "We have sent a OTP to your registered Mobile number ${widget.encryptMobileNumber.substring(0, widget.encryptMobileNumber.indexOf("#")).replaceAll("*", "x")}",
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 60 > 315
                    ? 315
                    : MediaQuery.of(context).size.width - 60,
                child: PinFieldAutoFill(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  codeLength: 6,
                  decoration:
                      //  CirclePinDecoration(
                      //     strokeColorBuilder: PinListenColorBuilder(
                      //         Theme.of(context).colorScheme.primary, grey1),
                      //     bgColorBuilder: FixedColorListBuilder(List.generate(
                      //         6, (index) => Color.fromARGB(255, 248, 248, 255)))),

                      BoxLooseDecoration(
                          gapSpace: 12,
                          radius: Radius.circular(6.5),
                          strokeWidth: 1.3,
                          textStyle: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                          strokeColorBuilder: PinListenColorBuilder(
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.primary
                              // Colors.blue,
                              // Theme.of(context).textTheme.bodyMedium!.color ??
                              //     Colors.black
                              ),
                          bgColorBuilder: FixedColorBuilder(
                              Color.fromRGBO(255, 255, 255, 1))),
                  enableInteractiveSelection: false,
                  currentCode: otpPinController.text,
                  controller: otpPinController,
                  onCodeChanged: (p0) {
                    // formValidateNodifier.changeValue(formValidateNodifier.getValue
                    //   ..["otp"] = p0?.length == 6 ? true : false);

                    formIsValid = p0?.length == 6 ? true : false;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Visibility(
              visible: otpPinController.text != "",
              replacement: SizedBox(
                width: 20.0,
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.cancel_outlined,
                  size: 20.0,
                ),
                onTap: () => otpPinController.text = "",
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            timer != null && timer!.isActive
                ? RichText(
                    text: TextSpan(children: <InlineSpan>[
                      const WidgetSpan(child: Text("Resend with in:")),
                      WidgetSpan(
                          child: Text(
                        time.toString().substring(2, 7),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ]),
                  )
                : InkWell(
                    onTap: isResendingOTP
                        ? null
                        : () {
                            isResendingOTP = true;
                            if (mounted) {
                              setState(() {});
                            }
                            ResendMobileOTP();
                          },
                    child: Text(
                      //Resend with in :00:42
                      "Resend OTP !",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
            Expanded(
              child: SizedBox(),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Change Number",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              otp,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        const Expanded(flex: 4, child: SizedBox()),
        CustomButton(
            onPressed: buttonIsLoading || !formIsValid
                ? null
                : () {
                    if (otpPinController.text.length != 6) {
                      showSnackbar(
                          context, "Please enter valid OTP", Colors.red);
                      return;
                    }
                    buttonIsLoading = true;
                    if (mounted) {
                      setState(() {});
                    }
                    verifyMobileOTP();
                  }
            //     () => Navigator.pushNamed(context, route.email, arguments: {
            //   "name": widget.name,
            //   "mobileNo": widget.mobileNumber,
            //   "state": widget.state
            // }),
            ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
