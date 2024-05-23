import 'package:flutter/material.dart';

import 'Custom.dart';

// import '../Expansion/Custom.dart';

class PersonalDetails extends StatefulWidget {
  final String occupation;
  final String income;
  final String maritalStatus;
  final String gender;
  final String fatherName;
  final String motherName;
  final String email;
  final String phone;
  final String experiance;
  final String education;
  final String mailBelongs;
  final String mobileBelongs;
  final String? occuOthers;
  final String? eduOthers;
  final String? emailOwnerName;
  final String? phoneOwnerName;
  const PersonalDetails(
      {super.key,
      required this.occupation,
      required this.income,
      required this.maritalStatus,
      required this.gender,
      required this.fatherName,
      required this.motherName,
      required this.email,
      required this.phone,
      required this.experiance,
      required this.education,
      required this.mailBelongs,
      required this.mobileBelongs,
      this.occuOthers,
      this.eduOthers,
      this.emailOwnerName,
      this.phoneOwnerName});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitleText(title: 'Email to belongs to :'),
              CustomParagraph1(text: ' ${widget.mailBelongs}'),
              const SizedBox(
                height: 8.0,
              )
            ],
          ),
          if (widget.emailOwnerName != null &&
              widget.emailOwnerName!.isNotEmpty)
            Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                CustomParagraph1(text: 'Name : ${widget.emailOwnerName}'),
              ],
            ),
          const SizedBox(
            height: 3.0,
          ),
          CustomParagraph1(text: 'Email : ${widget.email}'),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitleText(title: 'Phone to belongs to :'),
              CustomParagraph1(text: ' ${widget.mobileBelongs}'),
              const SizedBox(
                height: 8.0,
              )
            ],
          ),
          if (widget.phoneOwnerName != null &&
              widget.phoneOwnerName!.isNotEmpty)
            Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                CustomParagraph1(text: 'Name : ${widget.phoneOwnerName}'),
              ],
            ),
          const SizedBox(
            height: 3.0,
          ),
          CustomParagraph1(text: 'Phone : ${widget.phone}'),
          const SizedBox(
            height: 25.0,
          ),
          CustomDataRow(
            title1: 'Marital Status',
            value1: widget.maritalStatus,
            title2: 'Gender',
            value2: widget.gender,
          ),
          const SizedBox(
            height: 25.0,
          ),
          CustomDataRow(
            title1: "Father's Name",
            value1: widget.fatherName,
            title2: "Mother's Name",
            value2: widget.motherName,
          ),
          const SizedBox(
            height: 25.0,
          ),
          CustomDataRow(
            title1: "Annual Income",
            value1: widget.income,
            title2: "Trading Experiance",
            value2: widget.experiance,
          ),
          const SizedBox(
            height: 25.0,
          ),
          CustomDataRow(
            title1: 'Occupation',
            value1: widget.occupation,
            title2: 'Education Qualification',
            value2: widget.education,
          ),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              // Check for 'occuOthers'
              if (widget.occuOthers != null && widget.occuOthers!.isNotEmpty)
                Expanded(
                  child: CustomColumnWidget(
                    title: 'Other Occupation',
                    value: widget.occuOthers!,
                  ),
                ),

              // Check for 'eduOthers'
              if (widget.eduOthers != null && widget.eduOthers!.isNotEmpty)
                Expanded(
                  child: CustomColumnWidget(
                    title: 'Other Qualifications',
                    value: widget.eduOthers!,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
