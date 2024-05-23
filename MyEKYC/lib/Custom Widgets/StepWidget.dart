import 'package:ekyc/Custom%20Widgets/alertbox.dart';
import 'package:ekyc/Screens/signup.dart';

import '../Custom%20Widgets/custom_button.dart';
import '../Custom%20Widgets/dotted_line.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../API call/api_call.dart';
import '../Route/route.dart' as route;

class StepWidget extends StatefulWidget {
  final String? endPoint;
  final int? step;
  final String title;
  // final String? title1;
  final String subTitle;
  final bool? backFunc;
  final bool? titleNotShow;
  // final bool? backButtonShow;
  // final bool resizeToAvoidBottomInset;
  final List<Widget> children;
  final ScrollController? scrollController;

  const StepWidget({
    super.key,
    this.step,
    required this.title,
    required this.subTitle,
    // this.resizeToAvoidBottomInset = false,
    required this.children,
    // this.title1,
    this.endPoint,
    this.scrollController,
    this.backFunc,
    this.titleNotShow,
    // this.backButtonShow
  });

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  getPrevoiusRoute(context) async {
    loadingAlertBox(context);
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[widget.endPoint],
      "routeraction": "PREVIOUS"
    });

    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      if (response["endpoint"] == "/" || response["endpoint"] == "/pan") {
        openAlertBox(
            context: context,
            content: "Do you want to Exit?",
            onpressed: () => SystemNavigator.pop());
        return;
      }
      Navigator.pushNamedAndRemoveUntil(
          context, response["endpoint"], (route) => false);
      // Navigator.push(context, response["endpoint"]);
    }
  }

  // openAlertBox(context) {
  //   print("object");
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(
  //           "Are you want to go back ?",
  //           style: Theme.of(context).textTheme.displayMedium,
  //         ),
  //         actions: [
  //           SizedBox(
  //             height: 30.0,
  //             child: ElevatedButton(
  //                 style: ButtonStyle(
  //                   elevation: const MaterialStatePropertyAll(0),
  //                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(6))),
  //                 ),
  //                 onPressed: () {
  //   Navigator.pop(context);
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, route.nominee, (route) => false,
  //       arguments: true);
  // },
  //                 child: const Text("Yes")),
  //           ),
  //           SizedBox(
  //             height: 30.0,
  //             child: ElevatedButton(
  //                 style: ButtonStyle(
  //                   elevation: const MaterialStatePropertyAll(0),
  //                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(6))),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text("No")),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        canPop: widget.endPoint == null && widget.backFunc != true
        // && backFunc != null,
        ,
        onPopInvoked: (didPop) {
          if (widget.backFunc == true) {
            openAlertBox(
              context: context,
              content: "Are you want to go back ?",
              onpressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, route.nominee,
                    //  (route) => false,
                    arguments: true);
              },
            );
            return;
          }
          !didPop ? getPrevoiusRoute(context) : null;
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/background_image.png"))),
            child: SingleChildScrollView(
              controller: widget.scrollController,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 60.0,
                height: MediaQuery.of(context).size.height - 45.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 15.0, top: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 20.0,
                          //   width: 20.0,
                          // ),
                          widget.step == 1
                              ? SizedBox(
                                  width: 15.0,
                                )
                              : GestureDetector(
                                  // padding: const EdgeInsets.only(top: 28.0),
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(9, 101, 218, 0.1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!)),
                                    child: Row(children: [
                                      Icon(
                                        CupertinoIcons.arrow_uturn_left,
                                        size: 12.0,
                                      ),
                                      const SizedBox(width: 2.0),
                                      Text(
                                        "Back",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 12.0),
                                      )
                                    ]),
                                  ),
                                  onTap: () => widget.endPoint == null &&
                                          widget.backFunc != true
                                      ? Navigator.pop(context)
                                      : widget.backFunc == true
                                          ? openAlertBox(
                                              context: context,
                                              content:
                                                  "Are you want to go back ?",
                                              onpressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushNamed(
                                                    context, route.nominee,
                                                    //  (route) => false,
                                                    arguments: true);
                                              },
                                            )
                                          : getPrevoiusRoute(context),
                                ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            //padding: const EdgeInsets.only(top: 27.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  34, 147, 52, 1))),
                                      child: Text(
                                        widget.title,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: const Color.fromRGBO(
                                                  50, 169, 220, 1),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(widget.step != null
                                    ? "Step ${widget.step}/6"
                                    : "")
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          //padding: const EdgeInsets.only(top: 27.0),
                          GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Icon(
                                  Icons.power_settings_new,
                                  color: Colors.white,
                                  size: 20.0,
                                )
                                //  SvgPicture.asset(
                                //   "assets/images/person.svg",
                                //   height: 22.0,
                                //   width: 22.0,
                                // )
                                ),
                            onTap: () => openAlertBox(
                                context: context,
                                content: "Do you want to logout?",
                                onpressed: () => logout(
                                    context)), //helpBottomSheet(context),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    //   child: Column(children: [

                    //   ]),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.titleNotShow != true) ...[
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                widget.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(widget.subTitle),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                            ...widget.children
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

helpBottomSheet(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Facing Difficulties ?",
              style: TextStyle(
                  fontSize: 15.0, color: Color.fromRGBO(106, 100, 100, 1)),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              title: const Text("Need Assistance ?",
                  style: TextStyle(
                      fontSize: 15.0, color: Color.fromRGBO(106, 100, 100, 1))),
              subtitle: const Text(
                "call 044-45609696 / 044-61329696",
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(112, 112, 112, 1)),
              ),
              leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset("assets/images/assistance.svg")]),
            ),
            const DottedLine(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              isSmall: true,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const SizedBox(width: 12.0),
                SvgPicture.asset("assets/images/tutorial.svg"),
                const SizedBox(width: 25.0),
                const Text("Watch Tutorial",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(106, 100, 100, 1)))
              ],
            ),
            const SizedBox(height: 30.0),
            CustomButton(
                childText: "Log out",
                color: const Color.fromRGBO(248, 76, 76, 1),
                onPressed: () => logout(context)),
            const SizedBox(height: 30.0)
          ],
        ),
      );
    },
  );
}
