import 'package:ekyc/Cookies/cookies.dart';
import 'package:ekyc/Custom%20Widgets/custom_tile.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../API call/api_call.dart';
import '../Custom Widgets/Custom.dart';
import '../Custom Widgets/StepWidget.dart';
import '../Custom Widgets/custom_button.dart';
import '../Custom Widgets/custom_drop_down.dart';
import '../Custom Widgets/custom_radio_button.dart';
import '../Custom Widgets/custom_snackBar.dart';
import '../Nodifier/nodifierCLass.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../Route/route.dart' as route;

class SegmentSelection extends StatefulWidget {
  const SegmentSelection({super.key});

  @override
  State<SegmentSelection> createState() => _SegmentSelectionState();
}

class _SegmentSelectionState extends State<SegmentSelection> {
  TextEditingController dpSchemeController = TextEditingController(text: "");
  FormValidateNodifier formValidateNodifierDpScheme =
      FormValidateNodifier({'Select DP Scheme': false});
  List demantDropDownValues = [];
  List demantDropDownOptions = [];
  String? disValue;
  String? eDisValue;
  List titles = [];
  List subTitles = [];
  List selectedTile = [];
  List userSelects = [];
  List brokerageHeading = [];
  List brokerageData = [];
  bool isLoading = true;
  String schemePdfDocId = "";
  Map serviceData = {};
  WebViewController con1 = WebViewController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var dropDownResponse =
        await getDropDownValues(context: context, code: "DematData");

    if (dropDownResponse != null) {
      demantDropDownValues = dropDownResponse['lookupvaluearr'] ?? [];
      int dpschemeIndex = demantDropDownValues
          .indexWhere((element) => element["code"] == "341");
      dpSchemeController.text = dpschemeIndex != -1
          ? demantDropDownValues[dpschemeIndex]["description"]
          : "";

      demantDropDownOptions.addAll(demantDropDownValues
          .map((element) => element['description'])
          .toList());
    }

    Map? demantServeResponse = await getServeBrokerDetailsApi(context);
    // print(demantServeResponse);
    if (demantServeResponse != null) {
      brokerageHeading = demantServeResponse['brokhead'];
      brokerageData = demantServeResponse['brokdata'];

      serviceData = demantServeResponse['service_map'];
      titles.addAll(
          serviceData.values.map((element) => element['segement']).toList());

      List exchangeValues =
          serviceData.values.map((element) => element['exchange']).toList();

      List exchangenameLists = exchangeValues
          .map((sublist) =>
              sublist.map((exchange) => exchange['exchangename']).toList())
          .toList();

      subTitles = exchangenameLists.map((sublist) {
        return 'Trade in ${sublist.join(' ')}';
      }).toList();
      userSelects = serviceData.values
          .map((element) =>
              element['userstatus'] == 'Y' ? element['segement'] : '')
          .toList();
      selectedTile = serviceData.values
          .map((element) =>
              element['selected'] == 'Y' ? element['segement'] : '')
          .toList();
      demantServeResponse['dematinfo']['dpscheme'] == null ||
              demantServeResponse['dematinfo']['dpscheme'].toString().isEmpty
          ? ""
          : dpSchemeController.text = demantDropDownValues.firstWhere(
              (element) =>
                  element['code'] ==
                  demantServeResponse['dematinfo']['dpscheme'])['description'];
      schemePdfDocId = demantServeResponse['dematinfo']['dpschemedocid'];
      disValue = demantServeResponse['dematinfo']['dis'] == 'N' ? 'No' : 'Yes';
      eDisValue =
          demantServeResponse['dematinfo']['edis'] == 'Y' ? 'Yes' : 'No';

      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  getNextRoute(context) async {
    //  response != null ? getNextRoute(context) : Navigator.pop(context);
    loadingAlertBox(context);
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.segmentSelection],
      "routeraction": "Next"
    });
    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

//flutter run -d chrome --web-port=8080

  insertSegmentDetails() async {
    loadingAlertBox(context);
    Map demantDetails = {
      "dpScheme": demantDropDownValues.firstWhere((element) =>
          element['description'] == dpSchemeController.text)['code'],
      "dis": disValue == 'Yes' ? 'Y' : 'N',
      "edis": eDisValue == 'Yes' ? 'Y' : 'N',
      "status": ""
    };
    for (var element in serviceData.keys) {
      !selectedTile.contains(element)
          ? serviceData[element]['selected'] = 'N'
          : serviceData[element]['selected'] = 'Y';
    }
    List serveIds = [];
    List brokIds = [];

    // brokIds = brokerageData
    //     .map((sublist) => sublist.map((element) =>
    //         RegExp(r'ID:(\d+)').firstMatch(element)?.group(1)))
    //     .map((row) => row
    //         .where((element) => element != null)
    //         .map((element) => element!))
    //     .reduce((value, element) => [...value, ...element]);

    brokIds = brokerageData
        .map((sublist) => sublist[1])
        .map((element) => element.toString().split(',')[1])
        .map((e) => e.toString().split(':')[1])
        .toList();
    serveIds.addAll(serviceData.values
        .map((element) => element['selected'] == 'Y' ? element['exchange'] : [])
        .map((sublist) => sublist.map((exchange) => exchange['exchangeid']))
        .toList()
        .reduce((value, element) => [...value, ...element]));
    Map demantServ = {
      "dematinfo": demantDetails,
      "servicearr": serveIds,
      "brokeragearr": brokIds
    };
    Map json = await insertDemantserveApi(context, demantServ);
    if (mounted) {
      Navigator.pop(context);
    }
    if (json['status'] == 'S') {
      getNextRoute(context);
    } else {
      showSnackbar(context, json['msg'], Colors.red);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  insertRiskdisclosure() async {
    loadingAlertBox(context);
    var response = await riskdisclosureinsertInAPI(context: context, json: {
      "contentid": htmlData["contentid"],
      "contenttype": htmlData["contenttype"]
    });
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      print("insert dis $response");
      insertSegmentDetails();
    }
  }

  Map htmlData = {};
  getHtmlData() async {
    loadingAlertBox(context);
    var response = await getDishClosureData(context: context);
    Navigator.pop(context);
    if (response != null) {
      htmlData = response;
      // Navigator.pushNamed(context, route.esignHtml,
      //     arguments: {"html": response["content"]});
      // con1
      //   // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //   ..loadHtmlString(response["content"])
      //   ..enableZoom(true);
      showTerms();
      // contentid
      // contenttype
    }
  }

  insertData() async {
    if (dpSchemeController.text.isEmpty) {
      showSnackbar(context, "please select the demant Scheme", Colors.red);
      return;
    }
    if (selectedTile.where((element) => element != "").isEmpty) {
      showSnackbar(context, "please select the trading segments", Colors.red);
      return;
    }
    for (var element in serviceData.keys) {
      !selectedTile.contains(element)
          ? serviceData[element]['selected'] = 'N'
          : serviceData[element]['selected'] = 'Y';
    }
    serviceData["FUTURE AND OPTIONS"]['selected'] == 'Y'
        ? getHtmlData()
        : insertSegmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : StepWidget(
            endPoint: route.segmentSelection,
            step: 4,
            title: 'Bank and Segments',
            subTitle:
                'Enter your bank details and select your preferred segments',
            children: [
              Expanded(
                child: ListView(
                  children: [
                    schemePdfDocId != null && schemePdfDocId.isNotEmpty
                        ? InkWell(
                            child: Text(
                              "VIEW SCHEME DETAILS",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, route.previewPdf,
                                arguments: {
                                  "title": "dpSchmeDetails",
                                  "data": schemePdfDocId,
                                  "fileName": "dpSchmeDetails.pdf"
                                }),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Demant Scheme',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomDropDown(
                      buttonSizeIsSmall: true,
                      isIcon: true,
                      label: 'Select DP Scheme',
                      controller: dpSchemeController,
                      values: demantDropDownOptions,
                      formValidateNodifier: formValidateNodifierDpScheme,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Choose your trading segments",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...List.generate(
                      titles.length,
                      (index) => CustomTile(
                        title: titles[index],
                        subtitle: subTitles[index],
                        selectedTile: selectedTile,
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              if (userSelects.contains(titles[index])) {
                                selectedTile.contains(titles[index])
                                    ? selectedTile.remove(titles[index])
                                    : selectedTile.add(titles[index]);
                              }
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Do you Require DIS Slip Book ?',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        buildCustomRadioButton('Yes', disValue!, () {
                          if (mounted) {
                            setState(() {
                              disValue = 'Yes';
                              eDisValue = 'No';
                            });
                          }
                        }),
                        const SizedBox(width: 30.0),
                        buildCustomRadioButton('No', disValue!, () {
                          if (mounted) {
                            setState(() {
                              disValue = 'No';
                              eDisValue = 'Yes';
                            });
                          }
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Whether you are required to transact EDIS transaction for sale obligation ?',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        buildCustomRadioButton(
                          'Yes',
                          eDisValue!,
                          () {
                            if (mounted) {
                              setState(() {
                                eDisValue = 'Yes';
                                disValue = 'No';
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 30.0),
                        buildCustomRadioButton(
                          'No',
                          eDisValue!,
                          () {
                            if (mounted) {
                              setState(() {
                                eDisValue = 'No';
                                disValue = 'Yes';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Brokerage Tariff Detatils",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomStyledContainer(
                      brokData: brokerageData,
                      brokHead: brokerageHeading,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButton(
                onPressed: insertData,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          );
  }

  void showTerms() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(9, 101, 218, 0.1),
                            borderRadius: BorderRadius.circular(8.0),
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
                      onTap: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(''),
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         width: 5.0,
                    //         color: const Color.fromRGBO(147, 147, 147, 1),
                    //       ),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: const Icon(Icons.close), //arrow_uturn_left
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  htmlData["contenttype"],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DottedLine(),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      HtmlWidget(htmlData["content"]),
                    ],
                  ),

                  // ListView(
                  //   children: [
                  //     Text(
                  //       "RISK DISCLOSURES ON DERIVATIVES",
                  //       textAlign: TextAlign.center,
                  //       style: Theme.of(context).textTheme.bodyLarge,
                  //     ),
                  //     const SizedBox(height: 10.0),
                  //     Flex(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       mainAxisSize: MainAxisSize.max,
                  //       direction: Axis.horizontal,
                  //       children: List.generate(
                  //         ((MediaQuery.of(context).size.width) / 12).floor(),
                  //         (index) => const SizedBox(
                  //           width: 6,
                  //           height: 2,
                  //           child: DecoratedBox(
                  //             decoration: BoxDecoration(color: Colors.black),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       height: 10.0,
                  //     ),
                  //     const Text(
                  //       "9 out of 10 individual traders in equity Futures and Options Segment, incurred net losses.",
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //     const Text(
                  //       "On an average, loss makers registered net trading loss close to ₹ 50,000.",
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //     const Text(
                  //       "Over and above the net trading losses incurred, loss makers expended an additional 28% of net trading losses as transaction costs.",
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //     const Text(
                  //       "Those making net trading profits, incurred between 15% to 50% of such profits as transaction cost.",
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //     Text(
                  //       "Source : ",
                  //       style: Theme.of(context).textTheme.bodyLarge,
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //     const Text(
                  //       "SEBI study dated January 25, 2023 on “Analysis of Profit and Loss of Individual Traders dealing in equity Futures and Options (F&O) Segment”, wherein Aggregate Level findings are based on annual Profit/Loss incurred by individual traders in equity F&O during FY 2021-22.",
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         decorationColor: Colors.blue,
                  //         color: Colors.blue,
                  //         fontStyle: FontStyle.italic,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //   ],
                  // ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  onPressed: () => insertRiskdisclosure(),
                  childText: htmlData["buttontext"],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCustomRadioButton(
      String value, String groupValue, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CustomRadioButton(
            color: groupValue == value
                ? const Color.fromRGBO(9, 101, 218, 1)
                : Colors.transparent,
          ),
          const SizedBox(width: 10.0),
          Text(value),
        ],
      ),
    );
  }
}

class CustomStyledContainer extends StatelessWidget {
  final List brokData;
  final List brokHead;

  const CustomStyledContainer({
    super.key,
    required this.brokData,
    required this.brokHead,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromRGBO(93, 140, 201, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...brokHead.map(
                    (element) => Text(
                      element,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  brokData.length,
                  (index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: index == brokData.length - 1
                                    ? BorderSide.none
                                    : const BorderSide(
                                        width: 0.5,
                                      ),
                                right: const BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(brokData[index][0]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: index == brokData.length - 1
                                    ? BorderSide.none
                                    : const BorderSide(
                                        width: 0.5,
                                      ),
                              ),
                            ),
                            child: Text(
                              brokData[index][1].toString().split(',').first,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* class CustomStyledContainer extends StatelessWidget {
  final List brokData;
  final List brokHead;

  const CustomStyledContainer({
    super.key,
    required this.brokData,
    required this.brokHead,
  });

  @override
  Widget build(BuildContext context) {
    List exchangeList = [];
    // List values = [];

    for (var i = 1; i < brokHead.length; i++) {
      exchangeList.add(brokHead[i]);
    }
    print(brokHead);
    print(brokData);
    return DefaultTabController(
      length: brokData.length,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 5.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.only(right: 10),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                tabs: [
                  ...brokData.map((title) => Tab(text: title.first)),
                ],
              ),
              SizedBox(
                height: 150.0,
                child: TabBarView(
                  children: brokData
                      .map((element) => SizedBox(
                            height: 150.0,
                            child: ListView(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    exchangeList.length,
                                    (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child:
                                                    Text(exchangeList[index])),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                element[index + 1] != 'N/A'
                                                    ? element[index + 1]
                                                        .toString()
                                                        .split(',')[0]
                                                    : '',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */
