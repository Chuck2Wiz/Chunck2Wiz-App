import 'package:chuck2wiz/data/blocs/login/plat_form.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:flutter/cupertino.dart';

class SnsLoginButtonWidget extends StatelessWidget {
  final PlatForm platForm;
  final VoidCallback onClickLogin;

  const SnsLoginButtonWidget(
      {super.key, required this.platForm, required this.onClickLogin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickLogin,
      child: Container(
        decoration: BoxDecoration(
          color: platForm == PlatForm.kakao
              ? ColorDefines.kakaoBackgroundColor
              : ColorDefines.naverBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: platForm == PlatForm.kakao
                  ? Image.asset('assets/images/kakao_logo.png')
                  : Image.asset('assets/images/naver_logo.png'),
            ),
            const SizedBox(width: 4),
            Text(
              platForm == PlatForm.kakao ? "카카오로 시작하기" : "네이버로 시작하기",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: platForm == PlatForm.kakao
                      ? ColorDefines.primaryBlack
                      : ColorDefines.primaryWhite
              ),
            )
          ],
        ),
      ),
    );
  }
}
