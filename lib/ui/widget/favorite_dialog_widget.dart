import 'package:flutter/material.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';

class FavoriteDialog extends StatefulWidget {
  @override
  _FavoriteDialogState createState() => _FavoriteDialogState();
}

class _FavoriteDialogState extends State<FavoriteDialog> {
  final List<String> favorite = ['교통사고', '명예훼손', '임대차', '이혼', '폭행', '사기', '성범죄', '저작권'];

  final List<String> selectedFavorite = [];

  void _onFavoriteTap(String favorite) {
    setState(() {
      if (selectedFavorite.contains(favorite)) {
        selectedFavorite.remove(favorite);
      } else if (selectedFavorite.length < 3) {
        selectedFavorite.add(favorite);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '관심분야를 선택해주세요.\n(최대 3개 선택 가능)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: favorite.map((favorite) {
                final isSelected = selectedFavorite.contains(favorite);
                return GestureDetector(
                  onTap: () => _onFavoriteTap(favorite),
                  child: _buildFavoriteChip(favorite, isSelected),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  label: '취소',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: ColorDefines.primaryWhite,
                  textColor: ColorDefines.primaryBlack,
                ),
                _buildActionButton(
                  label: '확인',
                  onPressed: selectedFavorite.isNotEmpty
                      ? () => Navigator.pop(context, selectedFavorite)
                      : null,
                  backgroundColor: ColorDefines.mainColor,
                  textColor: ColorDefines.primaryWhite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteChip(String favorite, bool isSelected) {
    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        color: ColorDefines.primaryWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? ColorDefines.mainColor : ColorDefines.primaryGray,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        favorite,
        style: TextStyle(
          color: isSelected ? ColorDefines.mainColor : ColorDefines.primaryBlack,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      child: Text(label),
    );
  }
}
