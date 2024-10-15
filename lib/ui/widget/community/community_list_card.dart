import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityListCard extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String date;
  final String nick;
  final int commentCount;
  final Function() onClickArticle;

  const CommunityListCard({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.nick,
    required this.commentCount,
    required this.onClickArticle
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickArticle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -1),
                blurRadius: 3,
                spreadRadius: 5,
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 8,),
                    Text(content, style: const TextStyle(fontSize: 12, color: Colors.grey, overflow: TextOverflow.ellipsis,),),
                  ],
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(nick, style: const TextStyle(color: ColorDefines.primaryGray, fontWeight: FontWeight.bold, fontSize: 10),),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: const Text("|", style: TextStyle(color: ColorDefines.primaryGray, fontWeight: FontWeight.w900, fontSize: 10),),
                    ),
                    Text(date, style: const TextStyle(color: ColorDefines.primaryGray, fontWeight: FontWeight.bold, fontSize: 10),),
                  ],
                ),
                Text("$commentCount", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            )
          ],
        ),
      ),
    );
  }
}