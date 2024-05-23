import 'package:flutter/material.dart';

import 'Custom.dart';

// import '../Expansion/Custom.dart';

class PanAadhaarDetail extends StatefulWidget {
  final String name;
  final String dob;
  final String pan;
  // final String fatherName;
  final String sourceOfAddress;
  final String permanentAddress;
  final String correspondenceAddress;
  final String proofType;

  const PanAadhaarDetail(
      {super.key,
      required this.name,
      required this.dob,
      required this.pan,
      // required this.fatherName,
      required this.sourceOfAddress,
      required this.proofType,
      required this.permanentAddress,
      required this.correspondenceAddress});

  @override
  State<PanAadhaarDetail> createState() => _PanAadhaarDetailState();
}

class _PanAadhaarDetailState extends State<PanAadhaarDetail> {
  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDataRow(
            title1: 'Name',
            value1: widget.name,
            title2: 'Date of birth',
            value2: widget.dob,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDataRow(
            title1: 'PAN',
            value1: widget.pan,
            title2: 'Soure of Address',
            value2: widget.sourceOfAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          // CustomColumnWidget(
          //     title: 'Soure of Address', value: widget.sourceOfAddress),
          // const SizedBox(
          //   height: 20,
          // ),
          CustomColumnWidget(
              title: 'Permanent Address', value: widget.permanentAddress),
          const SizedBox(
            height: 20,
          ),
          CustomColumnWidget(
              title: 'Correspondence Address',
              value: widget.correspondenceAddress),
          const SizedBox(
            height: 10,
          ),
          CustomColumnWidget(
            title: 'Proof Type',
            value: widget.proofType,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // CustomColumnWidget(
          //     title: 'Soure of Address', value: widget.sourceOfAddress),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }
}
