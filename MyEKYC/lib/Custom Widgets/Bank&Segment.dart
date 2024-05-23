import 'package:flutter/material.dart';

import 'Custom.dart';

// import '../Expansion/Custom.dart';

class BankSegment extends StatefulWidget {
  final String accno;
  final String bankName;
  final String branch;
  final String ifsc;
  final String micr;
  final String address;
  const BankSegment(
      {super.key,
      required this.accno,
      required this.bankName,
      required this.branch,
      required this.ifsc,
      required this.micr,
      required this.address});

  @override
  State<BankSegment> createState() => _BankSegmentState();
}

class _BankSegmentState extends State<BankSegment> {
  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDataRow(
              title1: 'Bank',
              value1: widget.bankName,
              title2: 'Branch',
              value2: widget.branch,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomDataRow(
              title1: 'Acc no',
              value1: widget.accno,
              title2: 'IFSC code',
              value2: widget.ifsc,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomDataRow(
              title1: 'MICR code',
              value1: widget.micr,
              title2: 'Address',
              value2: widget.address,
            ),
          ]),
    );
  }
}
