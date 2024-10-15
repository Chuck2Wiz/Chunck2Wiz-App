import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTextFieldWidget extends StatelessWidget {
  final Function(String) onChange;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final String hint;
  final TextEditingController? textEditingController;

  const BaseTextFieldWidget({
    super.key,
    this.textStyle,
    this.hintTextStyle,
    this.textEditingController,
    required this.hint,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintTextStyle,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusColor: Colors.black,
          fillColor: Colors.black,
          hoverColor: Colors.black),
      controller: textEditingController,
      onChanged: onChange,
      cursorColor: Colors.black,
      style: textStyle,
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }

}