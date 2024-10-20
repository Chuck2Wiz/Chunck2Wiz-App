import 'package:flutter/material.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:flutter/cupertino.dart';

Widget _buildSetAccountDialog({
  required BuildContext context,
  required String title,
  String? content,
  required VoidCallback onConfirm,
}) {
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Re-add rounded corners
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: ColorDefines.primaryBlack,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (content != null)
            Text(
              content,
              style: const TextStyle(
                color: ColorDefines.primaryGray,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 24), // More space between content and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly spaced buttons
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: ColorDefines.primaryGray,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                child: const Text(
                  '확인',
                  style: TextStyle(
                    color: ColorDefines.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildLogoutConfirmationDialog({required BuildContext context, required Function() onClickLogout}) {
  return _buildSetAccountDialog(
    context: context,
    title: '로그아웃 하시겠습니까?',
    onConfirm: onClickLogout,
  );
}

Widget buildDeleteAccountConfirmationDialog({required BuildContext context, required Function() onClickDelete}) {
  return _buildSetAccountDialog(
    context: context,
    title: '정말 탈퇴하시겠습니까?',
    content: '탈퇴를 하실 경우, 회원님의 정보가 모두 사라집니다.',
    onConfirm: onClickDelete,
  );
}
