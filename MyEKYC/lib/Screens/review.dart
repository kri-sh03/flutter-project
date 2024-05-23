import 'dart:convert';
import 'package:ekyc/Cookies/HttpClient.dart';
import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:ekyc/Screens/signup.dart';
import 'package:esign_plugin/digio_config.dart';
import 'package:esign_plugin/environment.dart';
import 'package:esign_plugin/esign_plugin.dart';
import 'package:esign_plugin/gateway_event.dart';
import 'package:esign_plugin/service_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../API call/api_call.dart';
import '../Custom Widgets/Bank&Segment.dart';
import '../Custom Widgets/Custom.dart';
import '../Custom Widgets/FileUpload.dart';
import '../Custom Widgets/IPVPage.dart';
import '../Custom Widgets/NominationPage.dart';
import '../Custom Widgets/PAN&ADDHAR.dart';
import '../Custom Widgets/PersonalInform.dart';
import '../Custom Widgets/StepWidget.dart';
import '../Custom Widgets/alertbox.dart';
import '../Custom Widgets/custom_button.dart';
import '../Custom Widgets/dematDetails.dart';
import '../Model/Total_api.dart';
import '../Model/route_model.dart';
import '../Nodifier/nodifierCLass.dart';
import '../Route/route.dart' as route;
// import '../Route/route.dart' as route;

// import '../../Route/route.dart' as route;

// ignore: must_be_immutable
class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isLoadingAddress = true;
  final _statusNotifier = ApplicationStatusNotifier();
  ScrollController scrollController = ScrollController();
  bool downArrowVisible = true;
  bool buttonEnable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressDetails();
      scrollController.addListener(() {
        downArrowVisible = scrollController.position.pixels ==
                scrollController.position.maxScrollExtent
            ? false
            : true;
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          buttonEnable = true;
        }
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  List? proofOfAddressDropDownValue;
  Address? address;
  Personal? personalDetails;
  List<Nominearr> nomineeDetails = [];
  Bank? bankDetails;
  Dematandservices? dematandservices;
  Basicinfo? basicDetails;
  Ipv? ipv;
  Signeddoc? signedDoc;
  List<RouteModel> routerdata = [];
  List? checkImageDetails;
  List? signImageDetails;
  List? panImageDetails;
  List? incomeProofImageDetails;

  addressDetails() async {
    loadingAlertBox(context);
    var response = await getReviewDetails(context: context);
    if (response != null) {
      ReviewModel reviewModel = reviewModelFromJson(jsonEncode(response));
      basicDetails = reviewModel.basicinfo;
      address = reviewModel.address;
      personalDetails = reviewModel.personal;
      nomineeDetails = reviewModel.nominearr;
      _tabController =
          TabController(length: nomineeDetails.length, vsync: this);
      bankDetails = reviewModel.bank;
      ipv = reviewModel.ipv;
      signedDoc = reviewModel.signeddoc;

      checkImageDetails = signedDoc!.checkleafid.isNotEmpty
          ? await fetchFile(
              context: context, id: signedDoc!.checkleafid, list: true)
          : null;
      signImageDetails = signedDoc!.signiid.isNotEmpty
          ? await fetchFile(
              context: context, id: signedDoc!.signiid, list: true)
          : null;
      incomeProofImageDetails = signedDoc!.incomeid.isNotEmpty
          ? await fetchFile(
              context: context, id: signedDoc!.incomeid, list: true)
          : null;
      panImageDetails = signedDoc!.panid.isNotEmpty
          ? await fetchFile(context: context, id: signedDoc!.panid, list: true)
          : null;
      print("income $incomeProofImageDetails");
      fetchData();
      // dematandservices = reviewModel.dematandservices;
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
    // }
    //  catch (error) {
    //   showSnackbar(context, "Error: $error", Colors.red);
    //   if (mounted) {
    //     Navigator.pop(context);
    //   }
    // }
    isLoadingAddress = false;
  }

  Map serviceData = {};
  List titles = [];
  List subTitles = [];
  List selectedTile = [];
  String disValue = '';
  String eDisValue = '';
  bool isLoading = true;
  String? didId;
  String? gwtId;
  String? phoneNo;
  String dpScheme = '';
  fetchData() async {
    Map demantServeResponse = await getServeBrokerDetailsApi(context);
    if (mounted) {
      Navigator.pop(context);
    }
    serviceData = demantServeResponse['service_map'];
    titles.addAll(
        serviceData.values.map((element) => element['segement']).toList());
    print(titles);
    List exchangeValues =
        serviceData.values.map((element) => element['exchange']).toList();

    List exchangenameLists = exchangeValues
        .map((sublist) =>
            sublist.map((exchange) => exchange['exchangename']).toList())
        .toList();
// print(exchangenameLists);
    subTitles = exchangenameLists.map((sublist) {
      return 'Trade in ${sublist.join(', ')}';
    }).toList();

    selectedTile = serviceData.values
        .map((element) => element['selected'] == 'Y' ? element['segement'] : '')
        .toList();

    dpScheme = demantServeResponse['dematinfo']['dpschemedesc'];
    print(dpScheme);
    disValue = demantServeResponse['dematinfo']['dis'] == 'N' ? 'No' : 'Yes';
    eDisValue = demantServeResponse['dematinfo']['edis'] == 'Y' ? 'Yes' : 'No';
    isLoading = false;
    print(subTitles);
    getRouteInfo();
    if (mounted) {
      setState(() {});
    }
  }

  getRouteInfo() async {
    var response = await getRouteInfoInAPI(context: context);
    if (response != null) {
      routerdata = response["routerdata"] == null
          ? []
          : List.from(response["routerdata"]
              .map((routeDetails) => RouteModel.fromJson(routeDetails))
              .toList());
      indexOfaddressRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("address"));
      indexOfpersonalRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("personal"));
      indexOfnomineeRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("nominee"));
      indexOfbankRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("bank"));
      indexOfipvRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("ipv"));
      indexOfdematRoute = routerdata.indexWhere((element) =>
          element.routername.toLowerCase().contains("dematservices"));
      indexOffileRoute = routerdata.indexWhere(
          (element) => element.routername.toLowerCase().contains("fileupload"));
      // addressRoute =
      //     indexOfaddressRoute != -1 ? routerdata[indexOfaddressRoute] : null;
      // personalRoute =
      //     indexOfpersonalRoute != -1 ? routerdata[indexOfpersonalRoute] : null;
      // nomineeRoute =
      //     indexOfnomineeRoute != -1 ? routerdata[indexOfnomineeRoute] : null;
      // bankRoute = indexOfbankRoute != -1 ? routerdata[indexOfbankRoute] : null;
      // ipvRoute = indexOfipvRoute != -1 ? routerdata[indexOfipvRoute] : null;
      // dematRoute =
      //     indexOfdematRoute != -1 ? routerdata[indexOfdematRoute] : null;
      // fileRoute = indexOffileRoute != -1 ? routerdata[indexOffileRoute] : null;

      if (mounted) {
        setState(() {});
      }
    }
  }

  int indexOfaddressRoute = -1;
  int indexOfpersonalRoute = -1;
  int indexOfnomineeRoute = -1;
  int indexOfbankRoute = -1;
  int indexOfipvRoute = -1;
  int indexOfdematRoute = -1;
  int indexOffileRoute = -1;

  proceedToEsign() async {
    loadingAlertBox(context);
    var response = await generatePdf(context: context);

    if (response != null) {
      print(response);
      getUserDetails();
      // pdfAlert(context, response["docid"], "esign_pdf", () => html());
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  html() async {
    loadingAlertBox(context);
    var response = await initiateEsign(context: context);
    print("html api call");
    if (mounted) {
      Navigator.pop(context);
    }
    if (response != null) {
      Navigator.pushReplacementNamed(context, route.esignHtml,
          arguments: {"html": response});
      // File f = File("/storage/emulated/0/Documents/docu.html");
      // f.writeAsStringSync(response);
      // print(f.readAsStringSync());
      // var url = Uri.dataFromString(content);
      // if (await canLaunchUrl(url)) {
      //   launchUrl(url, mode: LaunchMode.inAppWebView);
      // }
    }
  }

  getUserDetails() async {
    var response = await getUserDetailsForEsignInAPI(context: context);
    if (response != null) {
      print("ooo");
      print(response);
      didId =
          //  response["access_token"]["entity_id"] != ""
          //     ? response["access_token"]["entity_id"]
          // :
          response["docid"];
      gwtId = response["accessToken"];
      phoneNo = response["identifier"];
      print(didId);
      print(gwtId);
      print(phoneNo);

      if (didId != null &&
          didId!.isNotEmpty &&
          gwtId != null &&
          gwtId!.isNotEmpty &&
          phoneNo != null &&
          phoneNo!.isNotEmpty) {
        function();
        return;
      } else {
        showSnackbar(context, "Some time went wrong", Colors.red);
      }
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  function() async {
    print("object");
    WidgetsFlutterBinding.ensureInitialized();
    var digioConfig = DigioConfig();
    digioConfig.theme.primaryColor = "#32a83a";
    digioConfig.logo = "https://your_logo_url";
    digioConfig.environment = Environment.SANDBOX; // SANDBOX, PRODUCTION
    digioConfig.serviceMode = ServiceMode.OTP; // OTP, FP, IRIS

    final _esignPlugin = EsignPlugin(digioConfig);
    _esignPlugin.setGatewayEventListener((GatewayEvent? gatewayEvent) {
      print("gateway event : " + gatewayEvent.toString());
    });

    final esignResult =
        await _esignPlugin.start(didId!, phoneNo!, gwtId!, null);
    print('esignResult : ' + esignResult.toString());
    print("res ${esignResult.documentId}");

    if (!esignResult.code!.isNegative) {
      var response =
          await saveEsignInAPI(context: context, digid: esignResult.documentId);
      response != null
          ? getNextRoute(context)
          : mounted
              ? Navigator.pop(context)
              : null;
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  getNextRoute(context) async {
    var response = await getRouteNameInAPI(context: context, data: {
      "routername": route.routeNames[route.review],
      "routeraction": "Next"
    });

    if (mounted) {
      Navigator.pop(context);
    }

    if (response != null) {
      print(response);
      Navigator.pushNamed(context, response["endpoint"]);
    }
  }

  @override
  void dispose() {
    print("object");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StepWidget(
          endPoint: route.review,
          title: "Review",
          subTitle: "", //"Carefully review and confirm your details.",
          titleNotShow: true,
          children: [
            Expanded(
                child: Stack(
              children: [
                ListView(
                  controller: scrollController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: routerdata == null ||
                              routerdata.isEmpty ||
                              basicDetails == null
                          ? []
                          : [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Review your details",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                  "Carefully review and confirm your details."),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(12.0).copyWith(top: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius:
                                            BorderRadius.circular(6.52),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1),
                                            spreadRadius: 3.0,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              child: SvgPicture.asset(
                                                "assets/images/person.svg",
                                                height: 25.0,
                                                width: 25.0,
                                              )),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/message.png',
                                                        height: 15.0,
                                                        width: 15.0),
                                                    const SizedBox(width: 10.5),
                                                    Expanded(
                                                      child: !isLoadingAddress &&
                                                              basicDetails !=
                                                                  null
                                                          ? Text(basicDetails!
                                                              .emailid)
                                                          : const Text(""),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                  ],
                                                ),
                                                const SizedBox(height: 5.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/phone.png',
                                                        height: 16.0,
                                                        width: 16.0),
                                                    const SizedBox(width: 10.0),
                                                    Expanded(
                                                        child: !isLoadingAddress &&
                                                                basicDetails !=
                                                                    null
                                                            ? Text(basicDetails!
                                                                .mobileno)
                                                            : const Text("")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   child: Container(
                              //     width: 204.0,
                              //     height: 36.00,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       color: getColorForStage(_statusNotifier.currentStage),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.black.withOpacity(0.2),
                              //           spreadRadius: 4,
                              //           blurRadius: 7,
                              //           offset: const Offset(0, 4),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         getTextForStage(_statusNotifier.currentStage),
                              //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              //               color: const Color.fromRGBO(255, 255, 255, 1),
                              //               fontWeight: FontWeight.w600,
                              //             ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 20.0,
                              // ),
                              const DottedLine(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              indexOfaddressRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOfaddressRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfaddressRoute",
                                      title: 'PAN & Address Details',
                                      children: [
                                        !isLoadingAddress
                                            ? PanAadhaarDetail(
                                                pan: basicDetails!.panno,
                                                name:
                                                    basicDetails!.nameasperpan,
                                                dob: basicDetails!.dob,
                                                proofType: address
                                                        ?.proofofaddresstype ??
                                                    "",
                                                sourceOfAddress:
                                                    address!.sourceofaddress,
                                                permanentAddress:
                                                    "${address!.peraddress1}, ${address!.peraddress2}, ${address!.peraddress3}, ${address!.percity}, ${address!.perpincode}, ${address!.perstate}, ${address!.percountry}",
                                                correspondenceAddress:
                                                    "${address!.coraddress1}, ${address!.coraddress2}, ${address!.coraddress3}, ${address!.corcity}, ${address!.corpincode}, ${address!.corstate}, ${address!.corcountry}",
                                              )
                                            : const PanAadhaarDetail(
                                                name: "",
                                                dob: "",
                                                pan: "",
                                                sourceOfAddress: "",
                                                proofType: "",
                                                permanentAddress: "",
                                                correspondenceAddress: "")
                                      ],
                                    ),
                              indexOfpersonalRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOfpersonalRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfpersonalRoute",
                                      title: 'Personal Details',
                                      children: [
                                        PersonalDetails(
                                          emailOwnerName: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.emailownername
                                              : "",
                                          phoneOwnerName: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.phoneownername
                                              : "",
                                          occuOthers: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.otheroccupation
                                              : " ",
                                          eduOthers: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.educationothers
                                              : "",
                                          mobileBelongs: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!
                                                  .mobilenobelongsto
                                              : "",
                                          mailBelongs: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!
                                                  .emailidbelongsto
                                              : "",
                                          phone: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.mobileno
                                              : "",
                                          motherName: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.mothername
                                              : '',
                                          gender: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.gender
                                              : "",
                                          fatherName: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.fathername
                                              : '',
                                          experiance: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.tradingexposed
                                              : '',
                                          email: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.emailid
                                              : '',
                                          education: !isLoadingAddress
                                              ? personalDetails!
                                                  .educationqualification
                                              : '',
                                          income: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.annualincome
                                              : "",
                                          maritalStatus: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.maritalstatus
                                              : "",
                                          occupation: !isLoadingAddress &&
                                                  personalDetails != null
                                              ? personalDetails!.occupation
                                              : "",
                                        )
                                      ],
                                    ),
                              indexOfnomineeRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOfnomineeRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfnomineeRoute",
                                      title: 'Nomination and declaration',
                                      children: isLoadingAddress
                                          ? [
                                              NominationPage(
                                                  scrollController:
                                                      scrollController,
                                                  Nominearr(
                                                      nomineename: "",
                                                      nomineerelationship: "",
                                                      nomineeshare: "",
                                                      nomineedob: "",
                                                      nomineeaddress1: "",
                                                      nomineeaddress2: "",
                                                      nomineeaddress3: "",
                                                      nomineecity: "",
                                                      nomineestate: "",
                                                      nomineecountry: "",
                                                      nomineepincode: "",
                                                      nomineemobileno: "",
                                                      nomineeemailid: "",
                                                      nomineeproofofidentity:
                                                          "",
                                                      nomineeproofnumber: "",
                                                      nomineefileuploaddocids:
                                                          "",
                                                      nomineefilename: "",
                                                      guardianname: "",
                                                      guardianrelationship: "",
                                                      guardianaddress1: "",
                                                      guardianaddress2: "",
                                                      guardianaddress3: "",
                                                      guardiancity: "",
                                                      guardianstate: "",
                                                      guardiancountry: "",
                                                      guardianpincode: "",
                                                      guardianmobileno: "",
                                                      guardianemailid: "",
                                                      guardianproofofidentity:
                                                          "",
                                                      guardianproofnumber: "",
                                                      guardianfileuploaddocids:
                                                          "",
                                                      guardianfilename: ""),
                                                  name: "",
                                                  dob: "",
                                                  proofNo: "",
                                                  city: "",
                                                  state: "",
                                                  pinCode: "",
                                                  nomineeProof: "",
                                                  nominRelation: "")
                                            ]
                                          : nomineeDetails!.isEmpty
                                              ? []
                                              : nomineeDetails!.length == 1
                                                  ? [
                                                      NominationPage(
                                                          scrollController:
                                                              scrollController,
                                                          nomineeDetails![0],
                                                          name:
                                                              nomineeDetails![0]
                                                                  .nomineename,
                                                          dob:
                                                              nomineeDetails![0]
                                                                  .nomineedob
                                                                  .toString(),
                                                          proofNo: nomineeDetails![
                                                                  0]
                                                              .nomineeproofnumber,
                                                          city:
                                                              nomineeDetails![0]
                                                                  .nomineecity,
                                                          state:
                                                              nomineeDetails![0]
                                                                  .nomineestate,
                                                          pinCode:
                                                              nomineeDetails![0]
                                                                  .nomineepincode,
                                                          nomineeProof:
                                                              nomineeDetails![0]
                                                                  .nomineeproofofidentity,
                                                          nominRelation:
                                                              nomineeDetails![0]
                                                                  .nomineerelationship),
                                                    ]
                                                  : [
                                                      Column(
                                                        children: [
                                                          TabBar(
                                                            indicatorColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                            labelColor:
                                                                Colors.black,
                                                            controller:
                                                                _tabController,
                                                            tabs: [
                                                              ...nomineeDetails!
                                                                  .map((e) =>
                                                                      Tab(
                                                                        text:
                                                                            'Nominee ${nomineeDetails!.indexOf(e) + 1}',
                                                                      ))
                                                                  .toList()
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 300.0,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                50,
                                                            child: TabBarView(
                                                              controller:
                                                                  _tabController,
                                                              children:
                                                                  nomineeDetails!
                                                                      .map(
                                                                        (nominee) =>
                                                                            NominationPage(
                                                                          scrollController:
                                                                              scrollController,
                                                                          nominee,
                                                                          nominRelation:
                                                                              nominee.nomineerelationship,
                                                                          // '',
                                                                          city:
                                                                              nominee.nomineecity,
                                                                          // '',
                                                                          dob: nominee
                                                                              .nomineedob
                                                                              .toString(),
                                                                          // '',
                                                                          name:
                                                                              nominee.nomineename,
                                                                          // '',
                                                                          nomineeProof:
                                                                              nominee.nomineeproofofidentity,
                                                                          // '',
                                                                          proofNo:
                                                                              nominee.nomineeproofnumber,
                                                                          // '',
                                                                          pinCode:
                                                                              nominee.nomineepincode,
                                                                          // '',
                                                                          state:
                                                                              nominee.nomineestate,
                                                                          // ''
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                    ),
                              indexOfbankRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOfbankRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfbankRoute",
                                      title: 'Bank Details',
                                      children: [
                                        BankSegment(
                                          address: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.bankaddress
                                              : '',
                                          accno: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.accountno
                                              : "",
                                          bankName: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.bankname
                                              : "",
                                          branch: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.bankbranch
                                              : "",
                                          ifsc: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.ifsc
                                              : "",
                                          micr: !isLoadingAddress &&
                                                  bankDetails != null
                                              ? bankDetails!.micr
                                              : "",
                                        )
                                      ],
                                    ),
                              indexOfdematRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOfdematRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfdematRoute",
                                      title: 'Demat & Exchange Segments',
                                      children: [
                                        DematDetails(
                                          scheme: !isLoading ? dpScheme : '',
                                          dis: !isLoading ? disValue : '',
                                          edis: !isLoading ? eDisValue : '',
                                          titles: titles,
                                          subTitles: subTitles,
                                          selectedTile: selectedTile,
                                          scrollController: scrollController,
                                        )
                                      ],
                                    ),
                              indexOfipvRoute == -1
                                  ? SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails: routerdata[indexOfipvRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOfipvRoute",
                                      title: 'In Person Verification',
                                      children: [
                                        IPVPage(
                                          imageId:
                                              !isLoadingAddress && ipv != null
                                                  ? ipv!.imagedocid
                                                  : "",
                                          videoId:
                                              !isLoadingAddress && ipv != null
                                                  ? ipv!.videodocid
                                                  : "",
                                        )
                                      ],
                                    ),
                              indexOffileRoute == -1
                                  ? const SizedBox()
                                  : CustomExpansionTile(
                                      routeDetails:
                                          routerdata[indexOffileRoute],
                                      currentStatus: ApplicationStage.completed,
                                      text: "$indexOffileRoute",
                                      title: 'File Upload Details',
                                      onChageExpand: (value) {
                                        if (!value) buttonEnable = true;
                                        setState(() {});
                                      },
                                      children: [
                                        !isLoadingAddress && signedDoc != null
                                            ? FileUploadContainer(
                                                chequeLeaf:
                                                    checkImageDetails != null
                                                        ? checkImageDetails![0]
                                                        : null,
                                                incomeImage:
                                                    incomeProofImageDetails !=
                                                            null
                                                        ? incomeProofImageDetails![
                                                            0]
                                                        : null,
                                                panImage:
                                                    panImageDetails != null
                                                        ? panImageDetails![0]
                                                        : null,
                                                signImage:
                                                    signImageDetails != null
                                                        ? signImageDetails![0]
                                                        : null,
                                                chequeLeafBytes:
                                                    checkImageDetails != null
                                                        ? checkImageDetails![1]
                                                        : null,
                                                incomeImageBytes:
                                                    incomeProofImageDetails !=
                                                            null
                                                        ? incomeProofImageDetails![
                                                            1]
                                                        : null,
                                                panImageBytes:
                                                    panImageDetails != null
                                                        ? panImageDetails![1]
                                                        : null,
                                                signImageBytes:
                                                    signImageDetails != null
                                                        ? signImageDetails![1]
                                                        : null,
                                              )
                                            : const FileUploadContainer(
                                                chequeLeaf: "",
                                                incomeImage: "",
                                                signImage: "",
                                                panImage: "",
                                              )
                                      ],
                                    ),
                              const SizedBox(height: 10.0),
                            ],
                    ),
                  ],
                ),
                downArrowVisible && routerdata != null && routerdata.isNotEmpty
                    ? GestureDetector(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                shape: BoxShape.circle),
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/arrowdown.svg',
                                  width: 7.0,
                                  height: 7.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: SvgPicture.asset(
                                    'assets/images/arrowdown.svg',
                                    width: 7.0,
                                    height: 7.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () => scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        ),
                      )
                    : const SizedBox()
              ],
            )),
            const SizedBox(height: 10.0),
            routerdata == null || routerdata.isEmpty
                ? const SizedBox()
                : CustomButton(
                    childText: getTextForStage(_statusNotifier.currentStage) ==
                            'Completed'
                        ? 'Proceed to E-Sign'
                        : 'Continue',
                    onPressed: !buttonEnable
                        ? null
                        : () {
                            // proceedToEsign();
                            proceedToEsign();
                          }),
            const SizedBox(height: 5.0)
          ]),
    );
  }
}
