import 'package:flutter/cupertino.dart';

import '../../define/color_defines.dart';

class AiLoadingTextWidget extends StatefulWidget{
  final String selectOptions;

  const AiLoadingTextWidget({super.key, required this.selectOptions});

  @override
  State<StatefulWidget> createState() => _AiLoadingTextState();

}

class _AiLoadingTextState extends State<AiLoadingTextWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: ColorDefines.lightGray,
      end: ColorDefines.darkGray
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Text(
          '${widget.selectOptions}에 대한 분석 중...',
          style: TextStyle(
            fontSize: 16,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }

}