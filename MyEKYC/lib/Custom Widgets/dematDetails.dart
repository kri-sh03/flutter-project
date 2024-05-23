import '../Custom%20Widgets/Service.dart';
import '../Custom%20Widgets/scrollable_widget.dart';
import 'package:flutter/material.dart';

import 'Custom.dart';

// import '../Expansion/Custom.dart';

class DematDetails extends StatelessWidget {
  final String scheme;
  final String dis;
  final String edis;
  final List titles;
  final List subTitles;
  final List selectedTile;
  final ScrollController scrollController;

  const DematDetails(
      {super.key,
      required this.scheme,
      required this.dis,
      required this.edis,
      required this.titles,
      required this.subTitles,
      required this.selectedTile,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomColumnWidget(title: 'Select DP Scheme :', value: scheme),
            const SizedBox(
              height: 25,
            ),
            CustomColumnWidget(
                title: 'Do You Require DIS Slip Book ?', value: dis),
            const SizedBox(
              height: 25,
            ),
            CustomColumnWidget(
                title:
                    'Whether You are required to transact EDIS transaction for sale obligation ?',
                value: edis),
            const SizedBox(
              height: 25,
            ),
            const DottedLine(),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Exchange Segments ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.displayMedium!.color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 300,
              child: ScrollableWidget(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTile(
                        title: titles[index],
                        subtitle: subTitles[index],
                        selectedTile: selectedTile);
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
