import 'package:ekyc/API%20call/api_call.dart';
import 'package:ekyc/Custom%20Widgets/custom_button.dart';
import 'package:ekyc/Custom%20Widgets/custom_form_field.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:ekyc/Service/validate_func.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Custom Widgets/login_page_widget.dart';
import '../Route/route.dart' as route;

class Email extends StatefulWidget {
  final String state;
  final String name;
  final String mobileNumber;
  const Email(
      {super.key,
      required this.name,
      required this.mobileNumber,
      required this.state});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController emailController = TextEditingController();
  // FormValidateNodifier formValidateNodifier =
  //     FormValidateNodifier({"email": false});
  bool buttonIsLoading = false;
  bool emailIsValid = false;
  emailOtpCall() async {
    loadingAlertBox(context);
    var json = await otpCallAPI(json: {
      "clientname": widget.name,
      "sendto": emailController.text,
      "sendtotype": "EMAIL",
    }, context: context);
    if (mounted) {
      Navigator.pop(context);
    }
    if (json != null) {
      print(json);
      Navigator.pushNamed(context, route.emailOTP, arguments: {
        "email": emailController.text,
        "encrypteval": json["encryptedval"],
        "insertedid": json["validateid"],
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

  checkEmailValidate(value) {
    emailIsValid = validateEmail(value) == null ? true : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageWidget(
      title: "Email",
      subTitle: "Tell us your Mail id to receive a OTP for Verification",
      children: [
        CustomFormField(
          controller: emailController,
          labelText: "email",
          hintText: 'Enter the email',
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
            // NoSapceInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]'))
          ],
          validator: emailValidation,
          onChange: checkEmailValidate,
        ),
        const Expanded(flex: 4, child: SizedBox()),
        Container(
          alignment: Alignment.center,
          child: Text.rich(
              style:
                  const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              TextSpan(children: <InlineSpan>[
                const TextSpan(
                    text: 'By proceeding , I agree to the',
                    style: TextStyle(color: Color.fromRGBO(102, 98, 98, 1))),
                TextSpan(
                    text: " T&C",
                    style:
                        const TextStyle(color: Color.fromRGBO(50, 169, 220, 1)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(
                          context, route.esignHtml,
                          arguments: {"url": "https://flattrade.in/terms"})),
                const TextSpan(
                    text: ' and',
                    style: TextStyle(color: Color.fromRGBO(102, 98, 98, 1))),
                TextSpan(
                    text: " privacy Policy",
                    style:
                        const TextStyle(color: Color.fromRGBO(50, 169, 220, 1)),
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
            onPressed: buttonIsLoading || !emailIsValid
                ? null
                : () {
                    buttonIsLoading = true;
                    if (mounted) {
                      setState(() {});
                    }
                    emailOtpCall();
                  }

            // Navigator.pushNamed(context, route.emailOTP, arguments: {
            //   "email": emailController.text,
            //   "encrypteval": "dxxxxxxxx@gxxxx.com",
            //   "insertedid": "123",
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
