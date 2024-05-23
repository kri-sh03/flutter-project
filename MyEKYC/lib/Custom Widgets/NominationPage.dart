import 'package:ekyc/Custom%20Widgets/scrollable_widget.dart';
import 'package:flutter/material.dart';

import '../Model/Total_api.dart';
import 'Custom.dart';

// import '../Expansion/Custom.dart';

class NominationPage extends StatefulWidget {
  final Nominearr nominee;
  final String name;
  final String dob;
  final String proofNo;
  final String city;
  final String state;
  final String pinCode;
  final String nomineeProof;
  final String nominRelation;
  final ScrollController scrollController;
  const NominationPage(
    this.nominee, {
    Key? key,
    required this.name,
    required this.dob,
    required this.proofNo,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.nomineeProof,
    required this.nominRelation,
    required this.scrollController,
  }) : super(key: key);
  @override
  State<NominationPage> createState() => _NominationPageState();
}

class _NominationPageState extends State<NominationPage> {
  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: ScrollableWidget(
        controller: widget.scrollController,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.nominee.guardianname != null &&
                      widget.nominee.guardianname.isNotEmpty
                  ? Text(
                      'Nominee Details ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              Theme.of(context).textTheme.displayMedium!.color,
                          fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10.0,
              ),
              CustomDataRow(
                title1: 'Name',
                value1: widget.name,
                title2: 'Date of birth',
                value2: widget.dob,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomDataRow(
                title1: widget.nomineeProof,
                value1: widget.proofNo,
                title2: 'Relation',
                value2: widget.nominRelation,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomDataRow(
                title1: 'City',
                value1: widget.city,
                title2: 'State',
                value2: widget.state,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomColumnWidget(title: 'Pincode', value: widget.pinCode),
              const SizedBox(
                height: 20.0,
              ),
              if (widget.nominee != null &&
                  widget.nominee.guardianname != null &&
                  widget.nominee.guardianname!.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DottedLine(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Guardian Details ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .color,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomDataRow(
                      title1: 'Name',
                      value1: widget.nominee.guardianname!,
                      title2: 'Relationship ',
                      value2: widget.nominee.guardianrelationship ?? '',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomDataRow(
                      title1: widget.nominee.guardianproofofidentity ?? '',
                      value1: widget.nominee.guardianproofnumber ?? '',
                      title2: 'City',
                      value2: widget.nominee.guardiancity ?? '',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
