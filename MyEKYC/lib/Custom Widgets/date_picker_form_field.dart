import '../Nodifier/nodifierCLass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDateFormField extends StatelessWidget {
  final String? label;
  final DateChange date;

  final onChange;
  final FormValidateNodifier formValidateNodifier;
  CustomDateFormField(
      {super.key,
      required this.date,
      this.onChange,
      required this.formValidateNodifier,
      this.label});

  @override
  Widget build(BuildContext context) {
    date.value != null
        ? formValidateNodifier.changeValue(
            formValidateNodifier.getValue..[label ?? "Date of Birth"] = true)
        : null;

    _showDatePicker() async {
      DateTime today = DateTime.now();
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date.value ?? today,
          firstDate: DateTime(1900),
          lastDate: today);
      if (picked != null && picked != date.value) {
        date.onchange(picked);
        onChange != null ? onChange(picked) : null;
        formValidateNodifier.getValue["Date of Birth"] == false
            ? formValidateNodifier.changeValue(
                formValidateNodifier.getValue..["Date of Birth"] = true)
            : null;
      }
    }

    return ValueListenableBuilder(
        valueListenable: date,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomDOBFormField(
                  controller: TextEditingController(
                      text: value?.toString().substring(8, 10) ?? ""),
                  hint: "DD",
                  onTap: _showDatePicker,
                ),
              ),
              const SizedBox(width: 20.0),
              Flexible(
                child: CustomDOBFormField(
                  controller: TextEditingController(
                      text: value?.toString().substring(5, 7) ?? ""),
                  hint: "MM",
                  onTap: _showDatePicker,
                ),
              ),
              const SizedBox(width: 20.0),
              Flexible(
                flex: 2,
                child: CustomDOBFormField(
                  controller: TextEditingController(
                      text: value?.toString().substring(0, 4) ?? ""),
                  hint: "YYYY",
                  onTap: _showDatePicker,
                ),
              ),
            ],
          );
        });
  }
}

class CustomDOBFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final onTap;
  const CustomDOBFormField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: onTap,
      keyboardType: TextInputType.number,
      inputFormatters: [LengthLimitingTextInputFormatter(hint.length)],
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 0, 0, 1)),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: controller.text != ""
                ? const Color.fromRGBO(9, 101, 218, 1)
                : const Color.fromRGBO(
                    195, 195, 195, 1), //9, 101, 218, 1, // Border color
            width: 1.3, // Border width
          ),
        ),
        // suffixIcon: hint == "YYYY"
        //     ? IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today))
        //     : null,
        hintStyle: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.4),
            fontSize: 15.0,
            fontWeight: FontWeight.w600),
        contentPadding: EdgeInsets.zero,
        hintText: hint,
      ),
      validator: (value) => null,
    );
  }
}
