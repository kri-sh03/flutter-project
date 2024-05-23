import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Nodifier/nodifierCLass.dart';

class CustomCheckBox extends StatelessWidget {
  final String childText;
  final CheckBoxValueNodifier checkBoxValueNodifier;
  final isCenter;
  final onChange;
  const CustomCheckBox(
      {super.key,
      required this.checkBoxValueNodifier,
      this.onChange,
      required this.childText,
      this.isCenter = false});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: checkBoxValueNodifier,
        builder: (context, value, child) {
          return InkWell(
              child: Row(
                mainAxisAlignment: isCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                        color: value
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        border: Border.all(
                            width: 1,
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color!)),
                    child: value
                        ? Icon(
                            Icons.check_sharp,
                            size: 12,
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.white
                                : Color.fromRGBO(0, 0, 0, 1),
                          )
                        : null,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(child: Text(childText))
                ],
              ),
              onTap: () {
                checkBoxValueNodifier
                    .changeValue(!checkBoxValueNodifier.getValue);
                onChange != null
                    ? onChange(checkBoxValueNodifier.getValue)
                    : null;
              });
        });
  }
}
