import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTextFieldWidget extends StatefulWidget {
  final Function(String) onChange;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final String hint;
  final String initialText;
  final TextEditingController? textEditingController;
  final bool readOnly; // readOnly 속성 추가
  final Function()? onTap; // 클릭 시 작동하는 콜백 함수 추가

  const BaseTextFieldWidget({
    super.key,
    this.textStyle,
    this.hintTextStyle,
    this.textEditingController,
    this.initialText = "",
    required this.hint,
    required this.onChange,
    this.readOnly = false, // 기본값을 false로 설정
    this.onTap, // 클릭 시 작동하는 콜백 함수 초기화
  });

  @override
  _BaseTextFieldWidgetState createState() => _BaseTextFieldWidgetState();
}

class _BaseTextFieldWidgetState extends State<BaseTextFieldWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.hintTextStyle,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusColor: Colors.black,
        fillColor: Colors.black,
        hoverColor: Colors.black,
      ),
      controller: _controller,
      onChanged: (value) {
        widget.onChange(value);
      },
      cursorColor: Colors.black,
      style: widget.textStyle,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
    );
  }
}
